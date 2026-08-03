module Reg_File(
    input clk,
    input reset,
    input RegWrite,
    input [5:0] Rs1,
    input [5:0] Rs2,
    input [5:0] Rd,
    input [63:0] Write_data,
    output [63:0] ReadData1,
    output [63:0] ReadData2
);

    reg [63:0] Registers [63:0];
    integer i;

    // Write logic and reset logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            for (i = 0; i < 64; i = i + 1)
                Registers[i] <= 64'b0;
        else if (RegWrite)
            Registers[Rd] <= Write_data;
    end

    // Preload register values
    initial begin 
        Registers[0]  = 0;
        Registers[1]  = 64'd4;
        Registers[2]  = 64'd2;
        Registers[3]  = 64'd24;
        Registers[4]  = 64'd4;
        Registers[5]  = 64'd1;
        Registers[6]  = 64'd44;
        Registers[7]  = 64'd4;
        Registers[8]  = 64'd2;
        Registers[9]  = 64'd1;
        Registers[10] = 64'd23;
        Registers[11] = 64'd4;
        Registers[12] = 64'd90;
        Registers[13] = 64'd10;
        Registers[14] = 64'd20;
        Registers[15] = 64'd30;
        Registers[16] = 64'd40;
        Registers[17] = 64'd50;
        Registers[18] = 64'd60;
        Registers[19] = 64'd70;
        Registers[20] = 64'd80;
        Registers[21] = 64'd80;
        Registers[22] = 64'd90;
        Registers[23] = 64'd70;
        Registers[24] = 64'd60;
        Registers[25] = 64'd65;
        Registers[26] = 64'd4;
        Registers[27] = 64'd32;
        Registers[28] = 64'd12;
        Registers[29] = 64'd34;
        Registers[30] = 64'd5;
        Registers[31] = 64'd10;
        Registers[32] = 64'd100;
        Registers[33] = 64'd200;
        Registers[34] = 64'd300;
        Registers[35] = 64'd400;
        Registers[36] = 64'd500;
        Registers[37] = 64'd600;
        Registers[38] = 64'd700;
        Registers[39] = 64'd800;
        Registers[40] = 64'd900;
        Registers[41] = 64'd1000;
        Registers[42] = 64'd1100;
        Registers[43] = 64'd1200;
        Registers[44] = 64'd1300;
        Registers[45] = 64'd1400;
        Registers[46] = 64'd1500;
        Registers[47] = 64'd1600;
        Registers[48] = 64'd1700;
        Registers[49] = 64'd1800;
        Registers[50] = 64'd1900;
        Registers[51] = 64'd2000;
        Registers[52] = 64'd2100;
        Registers[53] = 64'd2200;
        Registers[54] = 64'd2300;
        Registers[55] = 64'd2400;
        Registers[56] = 64'd2500;
        Registers[57] = 64'd2600;
        Registers[58] = 64'd2700;
        Registers[59] = 64'd2800;
        Registers[60] = 64'd2900;
        Registers[61] = 64'd3000;
        Registers[62] = 64'd3100;
        Registers[63] = 64'd3200;
    end

    // Read logic
    assign ReadData1 = Registers[Rs1];
    assign ReadData2 = Registers[Rs2];

endmodule