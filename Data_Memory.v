module Data_Memory (
    input         clk,
    input         reset,
    input         Memwrite,
    input         Memread,
    input  [63:0] write_data,   // Data to be written (from ALU result or reg file)
    input  [5:0]  rd,           // memory index (6-bit → 64 memory locations)
    output [63:0] MemData_out   // Data read from memory
);

    reg [63:0] D_memory [0:63];
    integer k;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (k = 0; k < 64; k = k + 1) begin
                D_memory[k] <= 64'b0;
            end
        end else if (Memwrite) begin
            D_memory[rd] <= write_data;      // store into memory index = rd
        end
    end

    assign MemData_out = (Memread) ? D_memory[rd] : 64'b0;
endmodule