module PC_plus4(
	input [63:0] fromPC,
	output [63:0] NextoPC
);
assign NextoPC = 4 + fromPC;

endmodule