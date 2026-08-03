module ALU_LoadStore (
    input  [63:0] mem_data_in,     
    input  [63:0] B,               
    input  [2:0]  funct3,          
    input         is_load,        
    output reg [63:0] load_result, 
    output reg [63:0] store_data   
);

    always @(*) begin
        load_result = 64'b0;
        store_data  = 64'b0;

        if (is_load) begin
            case (funct3)
                3'b000: load_result = {{56{mem_data_in[7]}},  mem_data_in[7:0]};    // lb
                3'b001: load_result = {{48{mem_data_in}}, mem_data_in[15:0]};   // lh
                3'b010: load_result = {{32{mem_data_in}}, mem_data_in[31:0]};   // lw
                3'b011: load_result = mem_data_in;                                   // ld
                3'b100: load_result = {56'b0, mem_data_in[7:0]};                     // lbu
                3'b101: load_result = {48'b0, mem_data_in[15:0]};                    // lhu
                3'b110: load_result = {32'b0, mem_data_in[31:0]};                    // lwu
                default: load_result = 64'h0;
            endcase
        end else begin
            case (funct3)
                3'b000: store_data = {56'b0, B[7:0]};         // sb
                3'b001: store_data = {48'b0, B[15:0]};        // sh
                3'b010: store_data = {32'b0, B[31:0]};        // sw
                3'b011: store_data = B;                        // sd
                default: store_data = 64'h0;
            endcase
        end
    end
endmodule