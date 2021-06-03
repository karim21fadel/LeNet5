`timescale 1ns / 1ps


module Reg_Accmulator #(parameter DATA_WIDTH = 32 )
(
 input clk,
 input reset, 
 input [DATA_WIDTH-1:0] Data_in,
 input [DATA_WIDTH-1:0] data_bias,
 input Enable,
 input bias_sel, 
 output  [DATA_WIDTH-1:0] Data_out
 );
 
 reg [DATA_WIDTH-1:0] Data;
 wire [DATA_WIDTH-1:0] Data_out_FP;
 wire [DATA_WIDTH-1:0] data_out_mux;
 wire bias_sel_reg;
 
 Reg #(.DATA_WIDTH(1)) r1 (.clk(clk), .reset(reset), .Data_in(bias_sel), .Data_out(bias_sel_reg));

 always @(posedge clk ,posedge reset)
    begin 
      if (reset) 
        Data <= 32'b0; 
      else if (Enable) 
        Data <= data_out_mux; 
    end 
    
  assign Data_out = Data; 


 FP_Adder add ( .FP_in1(Data_in), .FP_in2(Data_out), .FP_out(Data_out_FP) );
 
 assign data_out_mux = bias_sel_reg ? Data_out_FP : data_bias;

  ////////////////// need flag to reset acc after first image 
endmodule 