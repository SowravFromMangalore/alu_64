module ALU_Branch (
    input  [63:0] A,
    input  [63:0] B,
    input  [2:0]  funct3,
    output reg branch_taken
);

    always @(*) begin
        case (funct3)
            3'b000: branch_taken = (A == B);             // beq
            3'b001: branch_taken = (A != B);             // bne
            3'b100: branch_taken = ($signed(A) < $signed(B)); // blt
            3'b101: branch_taken = ($signed(A) >= $signed(B)); // bge
            3'b110: branch_taken = (A < B);              // bltu
            3'b111: branch_taken = (A >= B);             // bgeu
            default: branch_taken = 0;
        endcase
    end
endmodule