module MEM_Stage(
    input         clk,
    input         reset,
    input         MemWrite,
    input         MemRead,
    input  [63:0] ALU_Result,    // value to store
    input  [5:0]  rd,            // memory index (6-bit for 64 entries)
    output [63:0] Mem_Data_Out
);

    Data_Memory mem (
        .clk(clk),
        .reset(reset),
        .Memwrite(MemWrite),
        .Memread(MemRead),
        .write_data(ALU_Result),  // store ALU result
        .rd(rd),                  // memory index
        .MemData_out(Mem_Data_Out)
    );
endmodule