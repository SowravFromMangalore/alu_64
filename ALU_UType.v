module ALU_UType (
    input  [63:0] PC,
    input  [31:0] imm_u,  // upper immediate (20-bit shifted left by 12)
    input         sel,    // 0 = LUI, 1 = AUIPC
    output reg [63:0] result
);

    always @(*) begin
        if (sel)
            result = PC + {imm_u, 12'b0};  // AUIPC: PC + (imm << 12)
        else
            result = {imm_u, 12'b0};       // LUI: (imm << 12)
    end
endmodule