//////////////////////////////////////////////////
// Engineer: Chen Zhaohui (xinming)
// Email: chenzhaohui.czh@alibaba-inc.com
//
// Project Name: MVP
// Module Name: reduce_buffer
// Modify Date: 08/15/2021 16:10

// Description: reduce_buffer is a set of 16*2 single port urams
//
//              Notice! COE_WIDTH  <= 36
//                      ADDR_WIDTH <= 12
//
//              Logic：
//              [COE_WIDTH-1:0] i/o_data [0] -> polynomial 0
//              [COE_WIDTH-1:0] i/o_data [1] -> polynomial 1
//              [COE_WIDTH-1:0] i/o_data [2] -> polynomial 2
//              [COE_WIDTH-1:0] i/o_data [3] -> polynomial 3
//////////////////////////////////////////////////

`include "common_defines.vh"
module reduce_buffer#(
    parameter COE_WIDTH        = 35,
    parameter ADDR_WIDTH     = 12,
    parameter BUFFER_DEPTH      = 16,
    parameter NUM_POLY          = 4,
    parameter COMMON_URAM_DELAY = 1    // Number of pipeline Registers
)(
    input             clk,
    input      [3:0]  i_uram_index,    
    input             i_we,
    input      [ADDR_WIDTH-1:0] i_addr,
    input      [NUM_POLY * COE_WIDTH-1:0] i_data,
    output     [NUM_POLY * COE_WIDTH-1:0] o_data
);    

integer i;
reg  [3:0]              i_uram_index_pip_reg [COMMON_URAM_DELAY-1:0];
reg  [BUFFER_DEPTH-1:0] mem_en_bundle;
wire [NUM_POLY * COE_WIDTH-1:0]             o_data_bundle        [BUFFER_DEPTH-1:0] ;

always@(*) begin
    case(i_uram_index)
        4'd0 : mem_en_bundle = 16'b0000_0000_0000_0001;
        4'd1 : mem_en_bundle = 16'b0000_0000_0000_0010;
        4'd2 : mem_en_bundle = 16'b0000_0000_0000_0100;
        4'd3 : mem_en_bundle = 16'b0000_0000_0000_1000;
        4'd4 : mem_en_bundle = 16'b0000_0000_0001_0000;
        4'd5 : mem_en_bundle = 16'b0000_0000_0010_0000;
        4'd6 : mem_en_bundle = 16'b0000_0000_0100_0000;
        4'd7 : mem_en_bundle = 16'b0000_0000_1000_0000;
        4'd8 : mem_en_bundle = 16'b0000_0001_0000_0000;
        4'd9 : mem_en_bundle = 16'b0000_0010_0000_0000;
        4'd10: mem_en_bundle = 16'b0000_0100_0000_0000;
        4'd11: mem_en_bundle = 16'b0000_1000_0000_0000;
        4'd12: mem_en_bundle = 16'b0001_0000_0000_0000;
        4'd13: mem_en_bundle = 16'b0010_0000_0000_0000;
        4'd14: mem_en_bundle = 16'b0100_0000_0000_0000;
        4'd15: mem_en_bundle = 16'b1000_0000_0000_0000;
        default: mem_en_bundle = 16'b0000_0000_0000_0000;
    endcase
end

genvar index_upv;

generate
    for (index_upv = 0; index_upv < BUFFER_DEPTH; index_upv = index_upv+1) begin
        uram_polyvec # (
            .NUM_POLY(NUM_POLY),
            .COMMON_URAM_DELAY(COMMON_URAM_DELAY)
        )
        upv_inst(
            .clk(clk),  
            .mem_en(mem_en_bundle[index_upv]),  
            .we(i_we),    
            .addr(i_addr),
            .din(i_data), 
            .dout(o_data_bundle[index_upv])
        );
    end
endgenerate

always @ (posedge clk) begin
    i_uram_index_pip_reg[0] <= i_uram_index;
end

always @ (posedge clk) begin
    for (i = 0; i < COMMON_URAM_DELAY-1; i = i+1) begin
        i_uram_index_pip_reg[i+1] <= i_uram_index_pip_reg[i];
    end
end

/* select an output */
assign o_data = o_data_bundle[i_uram_index_pip_reg[COMMON_URAM_DELAY-1]];
// always@(*) begin
//     case(i_uram_index_pip_reg[COMMON_URAM_DELAY-1])
//         4'd0 : o_data = o_data_bundle[0];
//         4'd1 : o_data = o_data_bundle[1];
//         4'd2 : o_data = o_data_bundle[2];
//         4'd3 : o_data = o_data_bundle[3];
//         4'd4 : o_data = o_data_bundle[4];
//         4'd5 : o_data = o_data_bundle[5];
//         4'd6 : o_data = o_data_bundle[6];
//         4'd7 : o_data = o_data_bundle[7];
//         4'd8 : o_data = o_data_bundle[8];
//         4'd9 : o_data = o_data_bundle[9];
//         4'd10: o_data = o_data_bundle[10];
//         4'd11: o_data = o_data_bundle[11];
//         4'd12: o_data = o_data_bundle[12];
//         4'd13: o_data = o_data_bundle[13];
//         4'd14: o_data = o_data_bundle[14];
//         4'd15: o_data = o_data_bundle[15];
//         default: o_data = o_data_bundle[0];
//     endcase
// end
endmodule
