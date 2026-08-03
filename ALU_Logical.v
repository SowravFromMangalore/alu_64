module ALU_Logical (
    input  [63:0] A,
    input  [63:0] B,
    input  [3:0]  ALU_Control,
    output reg [63:0] ALU_Result
);
    always @(*) begin
        case (ALU_Control)
            4'b0000: ALU_Result = A & B;                     // AND
            4'b0001: ALU_Result = A | B;                     // OR
            4'b0010: ALU_Result = A ^ B;                     // XOR
            4'b0011: ALU_Result = ~(A | B);                  // NOR
            4'b0100: ALU_Result = ~(A & B);                  // NAND
            4'b0101: ALU_Result = (A == B) ? 64'd1 : 64'd0;  // Equal
            4'b0110: ALU_Result = (A != B) ? 64'd1 : 64'd0;  // Not Equal
            4'b1000: ALU_Result = ($signed(A) < $signed(B)) ? 64'd1 : 64'd0; // SLT (signed)
            4'b1001: ALU_Result = (A < B) ? 64'd1 : 64'd0;   // SLTU (unsigned)
            default: ALU_Result = 64'hDEAD_BEEF_DEAD_BEEF;
        endcase
    end
endmodule