module ALU_Jump (
    input  [63:0] PC,
    input  [63:0] A,             // Used for JALR: rs1
    input  [31:0] Imm,           // JAL: immediate, JALR: I-type immediate
    input         is_jalr,       // 1 for JALR, 0 for JAL
    output [63:0] target_addr,
    output [63:0] link_addr
);
    wire [63:0] imm_ext = {{32{Imm[31]}}, Imm};

    assign target_addr = is_jalr ? (A + imm_ext) & ~64'b1 : PC + imm_ext;
    assign link_addr   = PC + 64'd4;  // Address to return to
endmodule