module Control_Unit(
    input  [6:0] instruction,
    output reg Branch,
    output reg MemRead,
    output reg MemtoReg,
    output reg MemWrite,
    output reg ALUSrc,
    output reg RegWrite
);

always @(*) begin
    // Default value
    {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch} = 6'b000000;

    case(instruction)
        7'b0110011: {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch} = 6'b001000; // R-Type
        7'b0000011: {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch} = 6'b111100; // Load
        7'b0100011: {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch} = 6'b100010; // Store
        7'b1100011: {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch} = 6'b000001; // Branch
        7'b0010011: {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch} = 6'b101000; // Immediate-type ALU
        7'b0110111: {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch} = 6'b100100; // LUI
        7'b0010111: {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch} = 6'b100100; // AUIPC
        7'b1101111: {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch} = 6'b010010; // JAL
        7'b1100111: {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch} = 6'b110010; // JALR
        default:    {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch} = 6'b000000;
    endcase
end

endmodule