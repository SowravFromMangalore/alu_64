module ALU_Shift (
    input  [63:0] A,
    input  [63:0] B,
    input  [3:0]  ALU_Control,
    output reg [63:0] ALU_Result
);
    wire [5:0] shamt = B[5:0]; // shift amount (0-63)

    always @(*) begin
        case (ALU_Control)
            4'b0000: ALU_Result = A << shamt;                       // SLL
            4'b0001: ALU_Result = A >> shamt;                       // SRL
            4'b0010: ALU_Result = $signed(A) >>> shamt;             // SRA
            4'b0011: ALU_Result = {A[62:0], A[63]};                 // ROL (rotate left 1)
            4'b0100: ALU_Result = {A[0], A[63:1]};                  // ROR (rotate right 1)
            4'b0101: ALU_Result = {A[31:0], A[63:32]};              // Swap upper/lower halves
            default: ALU_Result = 64'hDEAD_BEEF_DEAD_BEEF;
        endcase
    end
endmodule