module EX_Stage(
    // Pipeline inputs
    input  [63:0] ReadData1,
    input  [63:0] ReadData2,
    input  [63:0] ImmExt,
    input  [63:0] PC_in,
    input  [3:0]  ALU_Control,
    input         ALUSrc,
    input  [2:0]  funct3,
    input         is_imm_op,
    input         is_branch,
    input         is_jump,
    input         is_loadstore,
    input         is_u_type,
    input         is_jalr,
    input         sel_u_type,
    input         is_load,

    // Pipeline outputs
    output [63:0] ALU_Result,
    output [63:0] PC_Branch,

    // Debug outputs
    output [63:0] A_out,
    output [63:0] B_out,
    output        branch_taken
);

    wire [63:0] ALU_input2;

    // Select second operand based on ALUSrc control signal
    assign ALU_input2 = ALUSrc ? ImmExt : ReadData2;

    // Debug outputs
    assign A_out = ReadData1;
    assign B_out = ALU_input2;

    // ALU operation
    ALU_Unit alu (
        .A(ReadData1),
        .B(ALU_input2),
        .Imm(ImmExt),
        .PC(PC_in),
        .ALU_Control(ALU_Control),
        .funct3(funct3),
        .is_imm_op(is_imm_op),
        .is_branch(is_branch),
        .is_jump(is_jump),
        .is_loadstore(is_loadstore),
        .is_u_type(is_u_type),
        .is_jalr(is_jalr),
        .sel_u_type(sel_u_type),
        .is_load(is_load),             
        .ALU_result(ALU_Result),
        .branch_taken(branch_taken)
        // Do not connect unused outputs: .branch_target, .store_data, .link_addr
    );

    // Branch target address calculation: PC + Immediate
    Adder branch_adder (
        .in_1(PC_in),
        .in_2(ImmExt),
        .Sum_out(PC_Branch)
    );

endmodule