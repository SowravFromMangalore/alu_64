module ALU_Unit (
    input  [63:0] A,
    input  [63:0] B,
    input  [63:0] Imm,
    input  [3:0]  ALU_Control,
    input  [2:0]  funct3,
    input  [63:0] PC,
    input         is_imm_op,
    input         is_branch,
    input         is_jump,
    input         is_loadstore,
    input         is_u_type,
    input         is_jalr,         // for ALU_Jump
    input         sel_u_type,      // 0 = LUI, 1 = AUIPC
    input         is_load,         // for load/store
    output [63:0] ALU_result,
    output        branch_taken,
    output [63:0] branch_target,
    output [63:0] store_data,
    output [63:0] link_addr
);

    // Internal wires
    wire [63:0] reg_result;
    wire [31:0] imm_result_32;
    wire [63:0] imm_result;
    wire [63:0] u_result;
    wire [63:0] j_target;
    wire [63:0] j_link;
    wire [63:0] load_res;
    wire [63:0] store_res;
    wire        br_taken;

    // ALU Register-type operations
    ALU_Register alu_r (
        .A(A),
        .B(B),
        .ALU_Control(ALU_Control),
        .ALU_Result(reg_result)
    );

    // ALU Immediate operations - output is 32-bit, sign-extend to 64-bit
    ALU_Immediate alu_i (
        .A(A[31:0]),
        .Imm(Imm),
        .ALU_Control(ALU_Control),
        .ALU_Result(imm_result_32)
    );
    assign imm_result = {{32{imm_result_32[31]}}, imm_result_32};

    // Branch comparison unit
    ALU_Branch alu_b (
        .A(A),
        .B(B),
        .funct3(funct3),
        .branch_taken(br_taken)
    );
    
    // Jump address calculation and link address
    ALU_Jump alu_j (
        .PC(PC),
        .A(A),
        .Imm(Imm),
        .is_jalr(is_jalr),
        .target_addr(j_target),
        .link_addr(j_link)
    );
    
    // U-type instruction result (LUI, AUIPC)
    ALU_UType alu_u (
        .PC(PC),
        .imm_u(Imm),
        .sel(sel_u_type),
        .result(u_result)
    );

    // Load/store address and store data calculation
    ALU_LoadStore alu_ls (
        .mem_data_in(64'b0), // unused here
        .B(B),
        .funct3(funct3),
        .is_load(is_load),
        .load_result(load_res),
        .store_data(store_res)
    );

    // Select appropriate ALU_result based on instruction type
    assign ALU_result =
        is_jump      ? j_link :
        is_branch    ? 64'b0  :
        is_loadstore ? (is_load ? load_res : (A + Imm)) :
        is_u_type    ? u_result :
        is_imm_op    ? imm_result :
                      reg_result;

    assign branch_taken  = br_taken;
    assign branch_target = j_target;
    assign store_data    = store_res;
    assign link_addr     = j_link;

endmodule