// Engineer: Chen Zhaohui (xinming)
// Email: chenzhaohui.czh@alibaba-inc.com
//
// Project Name: MVP
// Module Name: sp_uram
// Modify Date: 08/15/2021 16:10

// Description: sp_uram is a single port ram
//////////////////////////////////////////////////


module sp_uram #(
  parameter AWIDTH = 12,  // Address Width
  parameter DWIDTH = 70,  // Data Width
  parameter NBPIPE = 1    // Number of pipeline Registers
 )( 
    input               clk,       // Clock 
    input               mem_en,    // Memory Enable
    input               we,        // Write Enable
    input  [AWIDTH-1:0] addr,      // Address Input
    input  [DWIDTH-1:0] din,       // Data Input  
    output [DWIDTH-1:0] dout       // Data Output
);

(* ram_style = "ultra" *)
reg [DWIDTH-1:0] mem[(1<<AWIDTH)-1:0];        // Memory Declaration      
reg [DWIDTH-1:0] mem_pipe_reg[NBPIPE-1:0];    // Pipelines for memory
reg mem_en_pipe_reg [NBPIPE-1:0];              // Pipelines for memory enable

integer          i;

// RAM : Write has one latency.
always @ (posedge clk)
begin
    if(we && mem_en)
        mem[addr] <= din;
end

// RAM output data goes through a pipeline.
// The enable of the RAM goes through a pipeline to produce a
// series of pipelined enable signals required to control the data
// pipeline.
always @ (posedge clk) begin
    mem_pipe_reg[0]    <= mem[addr];
    mem_en_pipe_reg[0] <= mem_en;
end

always @ (posedge clk) begin
    for (i = 0; i < NBPIPE-1; i = i+1) begin
        mem_pipe_reg[i+1]    <= mem_pipe_reg[i];
        mem_en_pipe_reg[i+1] <= mem_en_pipe_reg[i];
    end
end

// Final output register gives user the option to add a reset and
// an additional enable signal just for the data ouptut
assign dout = mem_en_pipe_reg[NBPIPE-1]? mem_pipe_reg[NBPIPE-1]:'d0;

endmodule
/* 
// The following is an instantation template for
// xilinx_ultraram_single_port_no_change

   xilinx_ultraram_single_port_no_change # (
                                             .AWIDTH(AWIDTH),
                                             .DWIDTH(DWIDTH),
                                             .NBPIPE(NBPIPE)
                                            )
                      your_instance_name    (
                                             clk(clk),   
                                             rst(rst),   
                                             we(we),    
                                             din(din), 
                                             addr(addr),
                                             dout(dout)
                                            );
*/                                            
