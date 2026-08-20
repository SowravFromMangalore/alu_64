module FP_Reg_File(
    input clk,
    input reset,
    input RegWrite,
    input [5:0] Rs1,
    input [5:0] Rs2,
    input [5:0] Rd,
    input [63:0] Write_data,
    output [63:0] ReadData1,
    output [63:0] ReadData2
);
endmodule
