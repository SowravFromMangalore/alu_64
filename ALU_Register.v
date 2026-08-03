module ALU_Register (
    input [63:0] A,
    input [63:0] B,
    input [3:0] ALU_Control,
    output reg [63:0] ALU_Result
);

    always @(*) begin
        case (ALU_Control)
            4'b0000: ALU_Result = A & B;                     // and
            4'b0001: ALU_Result = A | B;                     // or
            4'b0010: ALU_Result = A + B;                     // add
            4'b0011: ALU_Result = A ^ B;                     // xor
            4'b0100: ALU_Result = A << B[5:0];               // sll
            4'b0101: ALU_Result = A >> B[5:0];               // srl
            4'b0110: ALU_Result = A - B;                     // sub
            4'b0111: ALU_Result = $signed(A) >>> B[5:0];     // sra
            4'b1000: ALU_Result = ($signed(A) < $signed(B)) ? 1 : 0; // slt
            4'b1001: ALU_Result = (A < B) ? 1 : 0;           // sltu
            default: ALU_Result = 64'hDEAD_BEEF_DEAD_BEEF;   // invalid
        endcase
    end
endmodule