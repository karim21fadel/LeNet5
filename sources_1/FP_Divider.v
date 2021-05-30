`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/25/2021 03:07:08 PM
// Design Name: 
// Module Name: Divider_Final
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

module FP_Divider #(parameter Data_Width = 32 , E=8, M=23 )
    (
    input [Data_Width-1:0] FP_in1,
    input [Data_Width-1:0] FP_in2,
    output  [Data_Width-1:0] FP_out
    );
    
	//assign FP_out = FP_in1 / FP_in2; 
    wire  [Data_Width-1:0] FP_in2_rec;
    	 
    assign  FP_in2_rec =    (FP_in2 == 32'b 01000000100000000000000000000000) ? (32'b 00111110100000000000000000000000) :
    		                (FP_in2 == 32'b 01000001000100000000000000000000) ? (32'b 00111101111000111000110110100100) :
    					    (FP_in2 == 32'b 01000001100000000000000000000000) ? (32'b 00111101100000000000000000000000) :
    					    (FP_in2 == 32'b 01000001110010000000000000000000) ? (32'b 00111101001000111101011100001010) :
    					    (32'b 00111100111000111011110011010011);
    	
    FP_Multiplier	M1 ( .FP_in1 (FP_in1) ,.FP_in2 (FP_in2_rec),.FP_out(FP_out));

endmodule