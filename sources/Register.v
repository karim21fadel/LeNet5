`timescale 1ns / 1ps

module Register #(parameter DATA_WIDTH = 32 )
(
 input clk,
 input reset, 
 input [DATA_WIDTH-1:0] Data_in,
 input Enable, 
 output reg [DATA_WIDTH-1:0] Data_out);


 always @(posedge clk ,posedge reset)
   begin
   if (reset)
        Data_out<= {DATA_WIDTH{1'b0}}; 
   else if (Enable)
        Data_out <= Data_in;
   end		
endmodule 

