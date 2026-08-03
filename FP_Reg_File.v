module FP_Reg_File(
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

    reg [63:0] FP_Registers [63:0];
    integer i;

    // Write and reset logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 64; i = i + 1)
                FP_Registers[i] <= 64'b0;
        end else if (RegWrite) begin
            FP_Registers[Rd] <= Write_data;
        end
    end

    // Preload floating-point register values (IEEE-754 doubles)
    initial begin
        FP_Registers[0]  = 64'h0000_0000_0000_0000; // 0.0
        FP_Registers[1]  = 64'h3FF0_0000_0000_0000; // 1.0
        FP_Registers[2]  = 64'h4000_0000_0000_0000; // 2.0
        FP_Registers[3]  = 64'h4008_0000_0000_0000; // 3.0
        FP_Registers[4]  = 64'h400C_0000_0000_0000; // 3.5
        FP_Registers[5]  = 64'h4010_0000_0000_0000; // 4.0
        FP_Registers[6]  = 64'h4014_0000_0000_0000; // 5.0
        FP_Registers[7]  = 64'h4018_0000_0000_0000; // 6.0
        FP_Registers[8]  = 64'h401C_0000_0000_0000; // 7.0
        FP_Registers[9]  = 64'h4020_0000_0000_0000; // 8.0
        FP_Registers[10] = 64'h4020_8000_0000_0000; // 8.5
        FP_Registers[11] = 64'h4021_0000_0000_0000; // 9.0
        FP_Registers[12] = 64'h4021_8000_0000_0000; // 9.5
        FP_Registers[13] = 64'h4022_0000_0000_0000; // 10.0
        FP_Registers[14] = 64'h4022_8000_0000_0000; // 10.5
        FP_Registers[15] = 64'h4023_0000_0000_0000; // 11.0
        FP_Registers[16] = 64'h4023_8000_0000_0000; // 11.5
        FP_Registers[17] = 64'h4024_0000_0000_0000; // 12.0
        FP_Registers[18] = 64'h4024_8000_0000_0000; // 12.5
        FP_Registers[19] = 64'h4025_0000_0000_0000; // 13.0
        FP_Registers[20] = 64'h4025_8000_0000_0000; // 13.5
        FP_Registers[21] = 64'h4026_0000_0000_0000; // 14.0
        FP_Registers[22] = 64'h4026_8000_0000_0000; // 14.5
        FP_Registers[23] = 64'h4027_0000_0000_0000; // 15.0
        FP_Registers[24] = 64'h4027_8000_0000_0000; // 15.5
        FP_Registers[25] = 64'h4028_0000_0000_0000; // 16.0
        FP_Registers[26] = 64'h4028_8000_0000_0000; // 16.5
        FP_Registers[27] = 64'h4029_0000_0000_0000; // 17.0
        FP_Registers[28] = 64'h4029_8000_0000_0000; // 17.5
        FP_Registers[29] = 64'h402A_0000_0000_0000; // 18.0
        FP_Registers[30] = 64'h402A_8000_0000_0000; // 18.5
        FP_Registers[31] = 64'h402B_0000_0000_0000; // 19.0
        FP_Registers[32] = 64'h402B_8000_0000_0000; // 19.5
        FP_Registers[33] = 64'h402C_0000_0000_0000; // 20.0
        FP_Registers[34] = 64'h402C_8000_0000_0000; // 20.5
        FP_Registers[35] = 64'h402D_0000_0000_0000; // 21.0
        FP_Registers[36] = 64'h402D_8000_0000_0000; // 21.5
        FP_Registers[37] = 64'h402E_0000_0000_0000; // 22.0
        FP_Registers[38] = 64'h402E_8000_0000_0000; // 22.5
        FP_Registers[39] = 64'h402F_0000_0000_0000; // 23.0
        FP_Registers[40] = 64'h402F_8000_0000_0000; // 23.5
        FP_Registers[41] = 64'h4030_0000_0000_0000; // 24.0
        FP_Registers[42] = 64'h4030_8000_0000_0000; // 24.5
        FP_Registers[43] = 64'h4031_0000_0000_0000; // 25.0
        FP_Registers[44] = 64'h4031_8000_0000_0000; // 25.5
        FP_Registers[45] = 64'h4032_0000_0000_0000; // 26.0
        FP_Registers[46] = 64'h4032_8000_0000_0000; // 26.5
        FP_Registers[47] = 64'h4033_0000_0000_0000; // 27.0
        FP_Registers[48] = 64'h4033_8000_0000_0000; // 27.5
        FP_Registers[49] = 64'h4034_0000_0000_0000; // 28.0
        FP_Registers[50] = 64'h4034_8000_0000_0000; // 28.5
        FP_Registers[51] = 64'h4035_0000_0000_0000; // 29.0
        FP_Registers[52] = 64'h4035_8000_0000_0000; // 29.5
        FP_Registers[53] = 64'h4036_0000_0000_0000; // 30.0
        FP_Registers[54] = 64'h4036_8000_0000_0000; // 30.5
        FP_Registers[55] = 64'h4037_0000_0000_0000; // 31.0
        FP_Registers[56] = 64'h4037_8000_0000_0000; // 31.5
        FP_Registers[57] = 64'h4038_0000_0000_0000; // 32.0
        FP_Registers[58] = 64'h4038_8000_0000_0000; // 32.5
        FP_Registers[59] = 64'h4039_0000_0000_0000; // 33.0
        FP_Registers[60] = 64'h4039_8000_0000_0000; // 33.5
        FP_Registers[61] = 64'h403A_0000_0000_0000; // 34.0
        FP_Registers[62] = 64'h403A_8000_0000_0000; // 34.5
        FP_Registers[63] = 64'h403B_0000_0000_0000; // 35.0
    end

    // Read logic
    assign ReadData1 = FP_Registers[Rs1];
    assign ReadData2 = FP_Registers[Rs2];

endmodule
