module WB_Stage(
    input [63:0] ALU_result, Mem_Data,
    input sel1, sel3,
    input [63:0] PC_plus4,
    output [63:0] WriteBack_Data
); 
    wire [63:0] mux1_out;
    
    Mux1 m1(
        .sel1(sel1),
        .A1(ALU_result),
        .B1(Mem_Data),
        .Mux1_out(mux1_out)
    );

    Mux3 m3(
        .sel3(sel3),
        .A3(mux1_out),
        .B3(PC_plus4),
        .Mux3_out(WriteBack_Data)
    );

endmodule 