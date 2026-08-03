module Mux3(
	input sel3,
	input [63:0] A3,B3,
	output [63:0] Mux3_out
);
	assign Mux3_out = (sel3 == 1'b0) ? A3 : B3;

endmodule