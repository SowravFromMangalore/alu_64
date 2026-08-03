module Instruction_Mem (
    input  wire [5:0] addr,
    output reg  [63:0] instruction
);

    reg [63:0] memory [0:63];

    always @(*) begin
        instruction = memory[addr];
    end

    initial begin
        // R-type Instructions
        memory[0]  = {7'b0000000, 6'd2, 6'd1, 3'b000, 6'd3, 7'b0, 7'b0, 7'b0110011, 15'b0}; // add x3, x1, x2
        memory[1]  = {7'b0100000, 6'd2, 6'd1, 3'b000, 6'd4, 7'b0, 7'b0, 7'b0110011, 15'b0}; // sub x4, x1, x2
        memory[2]  = {7'b0000000, 6'd2, 6'd1, 3'b001, 6'd5, 7'b0, 7'b0, 7'b0110011, 15'b0}; // sll x5, x1, x2
        memory[3]  = {7'b0000000, 6'd2, 6'd1, 3'b010, 6'd6, 7'b0, 7'b0, 7'b0110011, 15'b0}; // slt x6, x1, x2
        memory[4]  = {7'b0000000, 6'd2, 6'd1, 3'b011, 6'd7, 7'b0, 7'b0, 7'b0110011, 15'b0}; // sltu x7, x1, x2
        memory[5]  = {7'b0000000, 6'd2, 6'd1, 3'b100, 6'd8, 7'b0, 7'b0, 7'b0110011, 15'b0}; // xor x8, x1, x2
        memory[6]  = {7'b0000000, 6'd2, 6'd1, 3'b101, 6'd9, 7'b0, 7'b0, 7'b0110011, 15'b0}; // srl x9, x1, x2
        memory[7]  = {7'b0100000, 6'd2, 6'd1, 3'b101, 6'd10, 7'b0, 7'b0, 7'b0110011, 15'b0}; // sra x10, x1, x2
        memory[8]  = {7'b0000000, 6'd2, 6'd1, 3'b110, 6'd11, 7'b0, 7'b0, 7'b0110011, 15'b0}; // or x11, x1, x2
        memory[9]  = {7'b0000000, 6'd2, 6'd1, 3'b111, 6'd12, 7'b0, 7'b0, 7'b0110011, 15'b0}; // and x12, x1, x2

        // I-type Instructions
        memory[10] = {12'd4, 6'd1, 3'b000, 6'd13, 7'b0, 7'b0, 7'b0010011, 15'b0}; // addi x13, x1, 4
        memory[11] = {12'd4, 6'd1, 3'b010, 6'd14, 7'b0, 7'b0, 7'b0010011, 15'b0}; // slti x14, x1, 4
        memory[12] = {12'd4, 6'd1, 3'b011, 6'd15, 7'b0, 7'b0, 7'b0010011, 15'b0}; // sltiu x15, x1, 4
        memory[13] = {12'd4, 6'd1, 3'b100, 6'd16, 7'b0, 7'b0, 7'b0010011, 15'b0}; // xori x16, x1, 4
        memory[14] = {12'd4, 6'd1, 3'b110, 6'd17, 7'b0, 7'b0, 7'b0010011, 15'b0}; // ori x17, x1, 4
        memory[15] = {12'd4, 6'd1, 3'b111, 6'd18, 7'b0, 7'b0, 7'b0010011, 15'b0}; // andi x18, x1, 4
        memory[16] = {7'b0000000, 6'd4, 6'd1, 3'b001, 6'd19, 7'b0, 7'b0, 7'b0010011, 15'b0}; // slli x19, x1, 4
        memory[17] = {7'b0000000, 6'd4, 6'd1, 3'b101, 6'd20, 7'b0, 7'b0, 7'b0010011, 15'b0}; // srli x20, x1, 4
        memory[18] = {7'b0100000, 6'd4, 6'd1, 3'b101, 6'd21, 7'b0, 7'b0, 7'b0010011, 15'b0}; // srai x21, x1, 4

        // Word Arithmetic (RV64)
        memory[19] = {7'b0000000, 6'd2, 6'd1, 3'b000, 6'd22, 7'b0, 7'b0, 7'b0111011, 15'b0}; // addw x22, x1, x2
        memory[20] = {7'b0100000, 6'd2, 6'd1, 3'b000, 6'd23, 7'b0, 7'b0, 7'b0111011, 15'b0}; // subw x23, x1, x2
        memory[21] = {7'b0000000, 6'd2, 6'd1, 3'b001, 6'd24, 7'b0, 7'b0, 7'b0111011, 15'b0}; // sllw x24, x1, x2
        memory[22] = {7'b0000000, 6'd2, 6'd1, 3'b101, 6'd25, 7'b0, 7'b0, 7'b0111011, 15'b0}; // srlw x25, x1, x2
        memory[23] = {7'b0100000, 6'd2, 6'd1, 3'b101, 6'd26, 7'b0, 7'b0, 7'b0111011, 15'b0}; // sraw x26, x1, x2
        memory[24] = {12'd4, 6'd1, 3'b000, 6'd27, 7'b0, 7'b0, 7'b0011011, 15'b0}; // addiw x27, x1, 4
        memory[25] = {7'b0000000, 6'd4, 6'd1, 3'b001, 6'd28, 7'b0, 7'b0, 7'b0011011, 15'b0}; // slliw x28, x1, 4
        memory[26] = {7'b0000000, 6'd4, 6'd1, 3'b101, 6'd29, 7'b0, 7'b0, 7'b0011011, 15'b0}; // srliw x29, x1, 4
        memory[27] = {7'b0100000, 6'd4, 6'd1, 3'b101, 6'd30, 7'b0, 7'b0, 7'b0011011, 15'b0}; // sraiw x30, x1, 4

        // Load Instructions
        memory[28] = {12'd4, 6'd1, 3'b000, 6'd31, 7'b0, 7'b0, 7'b0000011, 15'b0}; // lb x31, 4(x1)
        memory[29] = {12'd8, 6'd1, 3'b001, 6'd1,  7'b0, 7'b0, 7'b0000011, 15'b0}; // lh x1, 8(x1)
        memory[30] = {12'd12,6'd1, 3'b010, 6'd2,  7'b0, 7'b0, 7'b0000011, 15'b0}; // lw x2, 12(x1)
        memory[31] = {12'd16,6'd1, 3'b011, 6'd3,  7'b0, 7'b0, 7'b0000011, 15'b0}; // ld x3, 16(x1)
        memory[32] = {12'd20,6'd1, 3'b100, 6'd4,  7'b0, 7'b0, 7'b0000011, 15'b0}; // lbu x4, 20(x1)
        memory[33] = {12'd24,6'd1, 3'b101, 6'd5,  7'b0, 7'b0, 7'b0000011, 15'b0}; // lhu x5, 24(x1)
        memory[34] = {12'd28,6'd1, 3'b110, 6'd6,  7'b0, 7'b0, 7'b0000011, 15'b0}; // lwu x6, 28(x1)

        // Store Instructions
        memory[35] = {7'b0000000, 6'd7, 6'd1, 3'b000, 6'd0, 7'b0, 7'b0, 7'b0100011, 15'b0}; // sb x7, 0(x1)
        memory[36] = {7'b0000000, 6'd8, 6'd1, 3'b001, 6'd2, 7'b0, 7'b0, 7'b0100011, 15'b0}; // sh x8, 2(x1)
        memory[37] = {7'b0000000, 6'd9, 6'd1, 3'b010, 6'd4, 7'b0, 7'b0, 7'b0100011, 15'b0}; // sw x9, 4(x1)
        memory[38] = {7'b0000000, 6'd10,6'd1, 3'b011, 6'd6, 7'b0, 7'b0, 7'b0100011, 15'b0}; // sd x10, 6(x1)

        // Branch Instructions
        memory[39] = {7'b0000000, 6'd2, 6'd1, 3'b000, 6'd0, 7'b0, 7'b0, 7'b1100011, 15'b0}; // beq x1, x2, 0
        memory[40] = {7'b0000000, 6'd2, 6'd1, 3'b001, 6'd0, 7'b0, 7'b0, 7'b1100011, 15'b0}; // bne x1, x2, 0
        memory[41] = {7'b0000000, 6'd2, 6'd1, 3'b100, 6'd0, 7'b0, 7'b0, 7'b1100011, 15'b0}; // blt x1, x2, 0
        memory[42] = {7'b0000000, 6'd2, 6'd1, 3'b101, 6'd0, 7'b0, 7'b0, 7'b1100011, 15'b0}; // bge x1, x2, 0
        memory[43] = {7'b0000000, 6'd2, 6'd1, 3'b110, 6'd0, 7'b0, 7'b0, 7'b1100011, 15'b0}; // bltu x1, x2, 0
        memory[44] = {7'b0000000, 6'd2, 6'd1, 3'b111, 6'd0, 7'b0, 7'b0, 7'b1100011, 15'b0}; // bgeu x1, x2, 0

        // Jumps and System Instructions
        memory[45] = {32'b00000000000000000000000000010111, 32'b0}; // auipc x0, 0 (padded)
        memory[46] = {12'd4, 6'd1, 3'b000, 6'd10, 7'b0, 7'b0, 7'b1100111, 15'b0}; // jalr x10, 4(x1)
        memory[47] = {32'b00000000000000000000000011101111, 32'b0}; // jal x0, 0 (padded)

        // Upper Immediate Instructions
        memory[48] = {20'd1, 6'd2, 7'b0, 7'b0110111, 24'b0}; // lui x2, 0x1
        memory[49] = {20'd2, 6'd3, 7'b0, 7'b0010111, 24'b0}; // auipc x3, 0x2

        // System Instructions
        memory[50] = {32'b00000000000000000000000001110011, 32'b0}; // ecall (padded)
        memory[51] = {32'b00000000000100000000000001110011, 32'b0}; // ebreak (padded)

        // RV64D Floating Point (Pseudo Encoded)
        memory[52] = {32'h20000053, 32'b0}; // fadd.d f0, f1, f2
        memory[53] = {32'h20001053, 32'b0}; // fsub.d f0, f1, f2
        memory[54] = {32'h20002053, 32'b0}; // fmul.d f0, f1, f2
        memory[55] = {32'h20003053, 32'b0}; // fdiv.d f0, f1, f2
        memory[56] = {32'hc2200053, 32'b0}; // fcvt.d.w f0, x0
        memory[57] = {32'hd2000053, 32'b0}; // fcvt.w.d x0, f0
        memory[58] = {32'h20004053, 32'b0}; // fsgnj.d f0, f1, f2
        memory[59] = {32'h20005053, 32'b0}; // fsgnjn.d f0, f1, f2
        memory[60] = {32'h20006053, 32'b0}; // fsgnjx.d f0, f1, f2
        memory[61] = {32'h2000a053, 32'b0}; // feq.d x0, f1, f2
        memory[62] = {32'h2000b053, 32'b0}; // flt.d x0, f1, f2
        memory[63] = {32'h2000c053, 32'b0}; // fle.d x0, f1, f2
    end
endmodule