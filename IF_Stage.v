module IF_Stage(
    input clk,
    input reset,
    input PCSrc,               // Branch control signal
    input [63:0] branch_target, // Branch target address
    output [63:0] instruction,  // Fetched instruction
    output [63:0] PC_plus4_out,  // PC+4 output
    output [63:0] PC_out        // PC_out
);

    // Internal signals
    wire [63:0] next_PC;
    wire [63:0] PC_plus4;

    // Program Counter
    Program_Counter PC (
        .clk(clk),
        .reset(reset),
        .PC_in(next_PC),
        .PC_out(PC_out)
    );

    // Instruction Memory
    Instruction_Mem Inst_Mem (
        .addr(PC_out),
        .instruction(instruction)
    );

    // PC+4 Calculator
    PC_plus4 pc_adder (
        .fromPC(PC_out),
        .NextoPC(PC_plus4)
    );

    // PC Source Mux
    Mux2 PC_mux (
        .sel2(PCSrc),
        .A2(PC_plus4),         // Normal sequential execution
        .B2(branch_target),    // Branch target
        .Mux2_out(next_PC)
    );

    // Output assignment
    assign PC_plus4_out = PC_plus4;

endmodule