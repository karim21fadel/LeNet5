`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/04/2021 11:46:46 AM
// Design Name: 
// Module Name: Register
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

