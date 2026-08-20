module ALU_FPUnit (
    input  wire [63:0] A,
    input  wire [63:0] B,
    input  wire [3:0]  ALU_Control,   // Operation selector
    input  wire [63:0] int_in,        // Integer input for conversions
    output reg  [63:0] ALU_Result,    // Floating-point or integer output
    output reg  [63:0] int_out        // Integer output for conversions and compares
);
endmodule
