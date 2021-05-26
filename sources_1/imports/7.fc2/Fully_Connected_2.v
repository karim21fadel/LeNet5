`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2021 03:43:46 PM
// Design Name: 
// Module Name: Fully_Connected
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


module Fully_Connected_2 #( parameter DATA_WIDTH          = 32)
(
	input [DATA_WIDTH-1:0] Data_in,
    input [DATA_WIDTH-1:0] Data_Weight_1,
    input [DATA_WIDTH-1:0] Data_Weight_2,
    input [DATA_WIDTH-1:0] Data_Weight_3,
    input [DATA_WIDTH-1:0] Data_Weight_4,
    input [DATA_WIDTH-1:0] Data_Weight_5,
    input [DATA_WIDTH-1:0] Data_Weight_6,
    input [DATA_WIDTH-1:0] Data_Weight_7,
    input [DATA_WIDTH-1:0] Data_Weight_8,
    input [DATA_WIDTH-1:0] Data_Weight_9,
    input [DATA_WIDTH-1:0] Data_Weight_10,
    
    output [DATA_WIDTH-1:0] Data_out_FC_1,
    output [DATA_WIDTH-1:0] Data_out_FC_2,
    output [DATA_WIDTH-1:0] Data_out_FC_3,
    output [DATA_WIDTH-1:0] Data_out_FC_4,
    output [DATA_WIDTH-1:0] Data_out_FC_5,
    output [DATA_WIDTH-1:0] Data_out_FC_6,
    output [DATA_WIDTH-1:0] Data_out_FC_7,
    output [DATA_WIDTH-1:0] Data_out_FC_8,
    output [DATA_WIDTH-1:0] Data_out_FC_9,
    output [DATA_WIDTH-1:0] Data_out_FC_10
   
    );
    
    FP_Multiplier M1 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_1),.FP_out(Data_out_FC_1));
    FP_Multiplier M2 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_2),.FP_out(Data_out_FC_2));
    FP_Multiplier M3 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_3),.FP_out(Data_out_FC_3));
    FP_Multiplier M4 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_4),.FP_out(Data_out_FC_4));
    FP_Multiplier M5 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_5),.FP_out(Data_out_FC_5));
    FP_Multiplier M6 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_6),.FP_out(Data_out_FC_6));
    FP_Multiplier M7 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_7),.FP_out(Data_out_FC_7));
    FP_Multiplier M8 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_8),.FP_out(Data_out_FC_8));
    FP_Multiplier M9 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_9),.FP_out(Data_out_FC_9));
    FP_Multiplier M10 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_10),.FP_out(Data_out_FC_10));
    
endmodule
