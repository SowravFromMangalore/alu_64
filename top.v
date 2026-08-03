module top(
    input  clk,
    input  reset,
    output [63:0] instr_out,   // debug: current IF instruction
    output [63:0] A,
    output [63:0] B,
    output [63:0] ALU_Result
);

    // ---------------- IF stage ----------------
    wire [63:0] PC_IF, instruction_IF, PC_plus4_IF;
    reg  [63:0] PC_ID;

    // ---------------- ID stage ----------------
    wire [63:0] Imm_ID, ReadData1, ReadData2, PC_out_ID;
    wire [3:0]  ALU_Control_ID;
    wire        Branch_ID, MemRead_ID, MemWrite_ID, ALUSrc_ID;
    wire        RegWrite_ID, MemtoReg_ID, branch_taken_ID;

    // ---------------- ID/EX pipeline ----------------
    reg [63:0] PC_EX, Imm_EX;
    reg [3:0]  ALU_Control_EX;
    reg        ALUSrc_EX, Branch_EX, MemRead_EX, MemWrite_EX;
    reg        MemtoReg_EX, RegWrite_EX;

    // ---------------- EX stage ----------------
    wire [63:0] ALU_Result_EX, PC_Branch_EX, A_EX, B_EX;
    wire        branch_taken_EX;

    // ---------------- EX/MEM pipeline ----------------
    reg        MemRead_MEM, MemWrite_MEM, MemtoReg_MEM, RegWrite_MEM;
    reg [63:0] ALU_Result_MEM;

    // ---------------- MEM stage ----------------
    wire [63:0] Mem_Data_MEM;

    // ---------------- MEM/WB pipeline ----------------
    reg        MemtoReg_MEM_WB, RegWrite_MEM_WB;
    reg [63:0] ALU_Result_MEM_WB, Mem_Data_MEM_WB;

    // ---------------- WB stage ----------------
    wire [63:0] WriteBack_Data_WB;

    // ---------------- Branch control ----------------
    // Use both ID-stage early branch detect and EX-stage final result
    wire take_branch       = branch_taken_EX | branch_taken_ID;
    wire [63:0] branch_target = PC_Branch_EX;

    // ====================== IF Stage ======================
    IF_Stage if_stage (
        .clk(clk),
        .reset(reset),
        .PCSrc(take_branch),
        .branch_target(branch_target),
        .instruction(instruction_IF),
        .PC_plus4_out(PC_plus4_IF),
        .PC_out(PC_IF)
    );

    // IF/ID latch
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            PC_ID <= 0;
        end else begin
            PC_ID <= PC_IF;
        end
    end

    // ====================== ID Stage ======================
    ID_Stage id_stage (
        .clk(clk),
        .reset(reset),
        .instruction(instruction_IF),
        .PC_in(PC_ID),
        .RegWrite_WB(RegWrite_MEM_WB),
        .Result_WB(WriteBack_Data_WB),
        .ImmExt(Imm_ID),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2),
        .PC_out(PC_out_ID),
        .ALU_Control(ALU_Control_ID),
        .Branch(Branch_ID),
        .MemRead(MemRead_ID),
        .MemWrite(MemWrite_ID),
        .ALUSrc(ALUSrc_ID),
        .RegWrite(RegWrite_ID),
        .MemtoReg(MemtoReg_ID),
        .branch_taken(branch_taken_ID)   // actively used with EX
    );

    // ID/EX latch
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            PC_EX <= 0; Imm_EX <= 0;
            ALU_Control_EX <= 0; ALUSrc_EX <= 0; Branch_EX <= 0;
            MemRead_EX <= 0; MemWrite_EX <= 0; MemtoReg_EX <= 0; RegWrite_EX <= 0;
        end else begin
            PC_EX <= PC_out_ID;
            Imm_EX <= Imm_ID;
            ALU_Control_EX <= ALU_Control_ID;
            ALUSrc_EX <= ALUSrc_ID;
            Branch_EX <= Branch_ID;
            MemRead_EX <= MemRead_ID;
            MemWrite_EX <= MemWrite_ID;
            MemtoReg_EX <= MemtoReg_ID;
            RegWrite_EX <= RegWrite_ID;
        end
    end

    // ====================== EX Stage ======================
    EX_Stage ex_stage (
        .ReadData1(ReadData1),
        .ReadData2(ReadData2),
        .ImmExt(Imm_EX),
        .PC_in(PC_EX),
        .ALU_Control(ALU_Control_EX),
        .ALUSrc(ALUSrc_EX),
        .funct3(instruction_IF[14:12]),
        .is_imm_op(1'b0),
        .is_branch(Branch_EX),
        .is_jump(1'b0),
        .is_loadstore(MemRead_EX | MemWrite_EX),
        .is_u_type(1'b0),
        .is_jalr(1'b0),
        .sel_u_type(1'b0),
        .is_load(MemRead_EX),
        .ALU_Result(ALU_Result_EX),
        .PC_Branch(PC_Branch_EX),
        .A_out(A_EX),
        .B_out(B_EX),
        .branch_taken(branch_taken_EX)
    );

    // EX/MEM latch
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            MemRead_MEM <= 0; MemWrite_MEM <= 0; MemtoReg_MEM <= 0; RegWrite_MEM <= 0;
            ALU_Result_MEM <= 0;  
        end else begin
            MemRead_MEM <= MemRead_EX;
            MemWrite_MEM <= MemWrite_EX;
            MemtoReg_MEM <= MemtoReg_EX;
            RegWrite_MEM <= RegWrite_EX;
            ALU_Result_MEM <= ALU_Result_EX;            // value to be stored
    end
end
    // ====================== MEM Stage ======================
    MEM_Stage mem_stage (
        .clk(clk),
        .reset(reset),
        .MemWrite(MemWrite_MEM),
        .MemRead(MemRead_MEM),
        .ALU_Result(ALU_Result_MEM),        // store value
        .rd(instruction_IF[11:7]),         // index (bits used)
        .Mem_Data_Out(Mem_Data_MEM)
    );

    // MEM/WB latch
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            MemtoReg_MEM_WB <= 0; RegWrite_MEM_WB <= 0;
            ALU_Result_MEM_WB <= 0; Mem_Data_MEM_WB <= 0;
        end else begin
            MemtoReg_MEM_WB   <= MemtoReg_MEM;
            RegWrite_MEM_WB   <= RegWrite_MEM;
            ALU_Result_MEM_WB <= ALU_Result_MEM;
            Mem_Data_MEM_WB   <= Mem_Data_MEM;
        end
    end

    // ====================== WB Stage ======================
    WB_Stage wb_stage (
        .ALU_result(ALU_Result_MEM_WB),
        .Mem_Data(Mem_Data_MEM_WB),
        .sel1(MemtoReg_MEM_WB),
        .sel3(1'b0),
        .PC_plus4(PC_plus4_IF),
        .WriteBack_Data(WriteBack_Data_WB)
    );

    // ---------------- Debug outputs ----------------
    assign instr_out  = instruction_IF;
    assign A          = A_EX;
    assign B          = B_EX;
    assign ALU_Result = ALU_Result_EX;

endmodule