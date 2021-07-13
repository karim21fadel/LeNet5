`timescale 1ns / 1ps

module Reg_acc_2 #(parameter DATA_WIDTH = 16, ARITH_TYPE = 1)
(
   input clk ,reset,
   input bias_sel,enable_write,
input [DATA_WIDTH - 1 : 0] Data_in_1 ,   
input [DATA_WIDTH - 1 : 0] Data_in_2 ,   
input [DATA_WIDTH - 1 : 0] Data_in_3 ,   
input [DATA_WIDTH - 1 : 0] Data_in_4 ,   
input [DATA_WIDTH - 1 : 0] Data_in_5 ,   
input [DATA_WIDTH - 1 : 0] Data_in_6 ,   
input [DATA_WIDTH - 1 : 0] Data_in_7 ,   
input [DATA_WIDTH - 1 : 0] Data_in_8 ,   
input [DATA_WIDTH - 1 : 0] Data_in_9 ,   
input [DATA_WIDTH - 1 : 0] Data_in_10,  

input [DATA_WIDTH-1:0]  data_bias_1, 
input [DATA_WIDTH-1:0] data_bias_2, 
input [DATA_WIDTH-1:0] data_bias_3, 
input [DATA_WIDTH-1:0] data_bias_4, 
input [DATA_WIDTH-1:0] data_bias_5, 
input [DATA_WIDTH-1:0] data_bias_6, 
input [DATA_WIDTH-1:0] data_bias_7, 
input [DATA_WIDTH-1:0] data_bias_8, 
input [DATA_WIDTH-1:0] data_bias_9, 
input [DATA_WIDTH-1:0] data_bias_10,

output [DATA_WIDTH - 1 : 0] Data_out_FC_1  ,
output [DATA_WIDTH - 1 : 0] Data_out_FC_2  ,
output [DATA_WIDTH - 1 : 0] Data_out_FC_3  ,
output [DATA_WIDTH - 1 : 0] Data_out_FC_4  ,
output [DATA_WIDTH - 1 : 0] Data_out_FC_5  ,
output [DATA_WIDTH - 1 : 0] Data_out_FC_6  ,
output [DATA_WIDTH - 1 : 0] Data_out_FC_7  ,
output [DATA_WIDTH - 1 : 0] Data_out_FC_8  ,
output [DATA_WIDTH - 1 : 0] Data_out_FC_9  ,
output [DATA_WIDTH - 1 : 0] Data_out_FC_10 
  );
    
    
    
    
Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC1_out(.clk(clk),.reset(reset),. data_in_from_previous(Data_in_1 ),.data_bias(data_bias_1),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out(Data_out_FC_1 ));
Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC2_out(.clk(clk),.reset(reset),. data_in_from_previous(Data_in_2 ),.data_bias(data_bias_2),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out(Data_out_FC_2 ));
Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC3_out(.clk(clk),.reset(reset),. data_in_from_previous(Data_in_3 ),.data_bias(data_bias_3),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out(Data_out_FC_3 ));
Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC4_out(.clk(clk),.reset(reset),. data_in_from_previous(Data_in_4 ),.data_bias(data_bias_4),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out(Data_out_FC_4 ));
Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC5_out(.clk(clk),.reset(reset),. data_in_from_previous(Data_in_5 ),.data_bias(data_bias_5),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out(Data_out_FC_5 ));
Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC6_out(.clk(clk),.reset(reset),. data_in_from_previous(Data_in_6 ),.data_bias(data_bias_6),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out(Data_out_FC_6 ));
Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC7_out(.clk(clk),.reset(reset),. data_in_from_previous(Data_in_7 ),.data_bias(data_bias_7),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out(Data_out_FC_7 ));
Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC8_out(.clk(clk),.reset(reset),. data_in_from_previous(Data_in_8 ),.data_bias(data_bias_8),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out(Data_out_FC_8 ));
Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC9_out(.clk(clk),.reset(reset),. data_in_from_previous(Data_in_9 ),.data_bias(data_bias_9),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out(Data_out_FC_9 ));
Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC10_out(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_10),.data_bias(data_bias_10),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out(Data_out_FC_10));


endmodule




