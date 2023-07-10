//////////////////////////////////////////////////
// Engineer: Chen Zhaohui (xinming)
// Email: chenzhaohui.czh@alibaba-inc.com
//
// Project Name: MVP
// Module Name: single_port_rom
// Modify Date: 07/15/2021 16:10

// Description: read-only for twiddle factor, using dram or bram
//////////////////////////////////////////////////

`include "ntt_intt_defines.vh"
module single_port_rom#(
    parameter COE_WIDTH = 39,
    parameter Q_TYPE = 0,
    parameter ADDR_WIDTH = 11,
    parameter NTT_INTT_CASE = 0,        // 0 for NTT, 1 for INTT
    parameter PATH = 0,
    parameter COMMON_BRAM_DELAY = 1
)
(
    input                     clka,
    input   [ADDR_WIDTH-1:0]  addra,
    output  [COE_WIDTH-1:0]   douta
);

//(* ram_style = "{auto | block | distributed | pipe_distributed | block_power1 | block_power2}" *)
(* ram_style = "block" *) reg [COE_WIDTH-1:0] mem_bank [0:(1<<ADDR_WIDTH)-1];
reg [COE_WIDTH-1:0] douta_reg [0:COMMON_BRAM_DELAY-1];
//reg [COE_WIDTH-1:0] douta_itn_reg;
//reg [COE_WIDTH-1:0] douta_reg [0:COMMON_BRAM_DELAY-2];

if (Q_TYPE == 2) begin  // (COE_WIDTH == 39)
    if (NTT_INTT_CASE == 0) begin
        initial begin
            case(PATH)
                0:$readmemh ("../../src/ntt/ntt_rom_39q/tf0.mem", mem_bank);
                1:$readmemh ("../../src/ntt/ntt_rom_39q/tf1.mem", mem_bank);
                2:$readmemh ("../../src/ntt/ntt_rom_39q/tf2.mem", mem_bank);
                3:$readmemh ("../../src/ntt/ntt_rom_39q/tf3.mem", mem_bank);
                default: begin end
            endcase
        end
    end else begin
        initial begin
            case(PATH)
                0:$readmemh ("../../src/intt/intt_rom_39q/tf0.mem", mem_bank);
                1:$readmemh ("../../src/intt/intt_rom_39q/tf1.mem", mem_bank);
                2:$readmemh ("../../src/intt/intt_rom_39q/tf2.mem", mem_bank);
                3:$readmemh ("../../src/intt/intt_rom_39q/tf3.mem", mem_bank);
                default: begin end
            endcase
        end
    end
end
else if  (Q_TYPE == 0) begin
    if (NTT_INTT_CASE == 0) begin
        initial begin
            case(PATH)
                0:$readmemh ("../../src/ntt/ntt_rom_35q0/tf0.mem", mem_bank);
                1:$readmemh ("../../src/ntt/ntt_rom_35q0/tf1.mem", mem_bank);
                2:$readmemh ("../../src/ntt/ntt_rom_35q0/tf2.mem", mem_bank);
                3:$readmemh ("../../src/ntt/ntt_rom_35q0/tf3.mem", mem_bank);
                default: begin end
            endcase
        end
    end else begin
        initial begin
            case(PATH)
                0:$readmemh ("../../src/intt/intt_rom_35q0/tf0.mem", mem_bank);
                1:$readmemh ("../../src/intt/intt_rom_35q0/tf1.mem", mem_bank);
                2:$readmemh ("../../src/intt/intt_rom_35q0/tf2.mem", mem_bank);
                3:$readmemh ("../../src/intt/intt_rom_35q0/tf3.mem", mem_bank);
                default: begin end
            endcase
        end
    end
end
else begin
    if (NTT_INTT_CASE == 0) begin
        initial begin
            case(PATH)
                0:$readmemh ("../../src/ntt/ntt_rom_35q1/tf0.mem", mem_bank);
                1:$readmemh ("../../src/ntt/ntt_rom_35q1/tf1.mem", mem_bank);
                2:$readmemh ("../../src/ntt/ntt_rom_35q1/tf2.mem", mem_bank);
                3:$readmemh ("../../src/ntt/ntt_rom_35q1/tf3.mem", mem_bank);
                default: begin end
            endcase
        end
    end else begin
        initial begin
            case(PATH)
                0:$readmemh ("../../src/intt/intt_rom_35q1/tf0.mem", mem_bank);
                1:$readmemh ("../../src/intt/intt_rom_35q1/tf1.mem", mem_bank);
                2:$readmemh ("../../src/intt/intt_rom_35q1/tf2.mem", mem_bank);
                3:$readmemh ("../../src/intt/intt_rom_35q1/tf3.mem", mem_bank);
                default: begin end
            endcase
        end
    end
end

/* read */
//genvar index_dout;
//generate
//    for(index_dout = 0; index_dout<COMMON_BRAM_DELAY; index_dout = index_dout+1) begin
//        always@(posedge clka) begin
//            if(index_dout == 0)
//                douta_itn_reg <= mem_bank[addra];
//            else if(index_dout == 1)
//                douta_reg[0] <= douta_itn_reg;
//            else
//                douta_reg[index_dout-1] <= douta_reg[index_dout-2];
//        end
//    end
//endgenerate
//assign douta = douta_reg[COMMON_BRAM_DELAY-2];


always@(posedge clka) begin
    douta_reg[0] <= mem_bank[addra];
end

genvar index_dout;
generate
    for(index_dout = 1; index_dout<COMMON_BRAM_DELAY; index_dout = index_dout+1) begin
        always@(posedge clka) begin
            douta_reg[index_dout] <= douta_reg[index_dout-1];
        end
    end
endgenerate
assign douta = douta_reg[COMMON_BRAM_DELAY-1];

// genvar index_dout;
// generate
//     for(index_dout = 0; index_dout<COMMON_BRAM_DELAY; index_dout = index_dout+1) begin
//         always@(posedge clka) begin
//             if(index_dout == 0)
//                 douta_reg[index_dout] <= mem_bank[addra];
//             else
//                 douta_reg[index_dout] <= douta_reg[index_dout-1];
//         end
//     end
// endgenerate
// assign douta = douta_reg[COMMON_BRAM_DELAY-1];

endmodule
