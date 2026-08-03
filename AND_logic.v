module AND_logic(
	input Branch , zero,
	output branch_taken
);  
assign branch_taken = Branch & zero;

endmodule