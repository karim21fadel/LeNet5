`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/21/2021 03:45:27 PM
// Design Name: 
// Module Name: Reg
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Reg #(parameter DATA_WIDTH = 32 )
(
 input clk,
 input reset, 
 input [DATA_WIDTH-1:0] Data_in,
 output reg [DATA_WIDTH-1:0] Data_out);


 always @(posedge clk ,posedge reset)
   begin
   if (reset)
        Data_out <= {DATA_WIDTH{1'b0}}; 
   else 
        Data_out <= Data_in;
   end		
endmodule 