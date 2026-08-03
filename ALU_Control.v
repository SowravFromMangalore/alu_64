module ALU_Control (
    input [6:0] opcode,
    input [2:0] funct3,
    input [6:0] funct7,
    output reg [3:0] ALU_Control
);

    always @(*) begin
        case(opcode)
            7'b0110011: begin // R-type
                case({funct7, funct3})
                    10'b0000000000: ALU_Control = 4'b0010; // add
                    10'b0100000000: ALU_Control = 4'b0110; // sub
                    10'b0000000111: ALU_Control = 4'b0000; // and
                    10'b0000000110: ALU_Control = 4'b0001; // or
                    10'b0000000100: ALU_Control = 4'b0011; // xor
                    10'b0000000001: ALU_Control = 4'b0100; // sll
                    10'b0000000101: ALU_Control = 4'b0101; // srl
                    10'b0100000101: ALU_Control = 4'b0111; // sra
                    10'b0000000010: ALU_Control = 4'b1000; // slt
                    10'b0000000011: ALU_Control = 4'b1001; // sltu
                    default:         ALU_Control = 4'b1111;
                endcase
            end

            7'b0010011: begin // I-type
                case(funct3)
                    3'b000: ALU_Control = 4'b0010; // addi
                    3'b111: ALU_Control = 4'b0000; // andi
                    3'b110: ALU_Control = 4'b0001; // ori
                    3'b100: ALU_Control = 4'b0011; // xori
                    3'b001: ALU_Control = 4'b0100; // slli
                    3'b101: begin
                        if (funct7 == 7'b0000000) ALU_Control = 4'b0101; // srli
                        else if (funct7 == 7'b0100000) ALU_Control = 4'b0111; // srai
                        else ALU_Control = 4'b1111;
                    end
                    3'b010: ALU_Control = 4'b1000; // slti
                    3'b011: ALU_Control = 4'b1001; // sltiu
                    default: ALU_Control = 4'b1111;
                endcase
            end

            7'b0000011, // Load
            7'b0100011: ALU_Control = 4'b0010; // Store -> add offset to base address

            7'b1100011: ALU_Control = 4'b0110; // Branch: compare for BEQ, BNE etc.

            7'b0110111: ALU_Control = 4'b1010; // LUI
            7'b0010111: ALU_Control = 4'b1011; // AUIPC

            default: ALU_Control = 4'b1111; // Invalid
        endcase
    end
endmodule