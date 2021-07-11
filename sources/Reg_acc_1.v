`timescale 1ns / 1ps

    module Reg_acc_1# (parameter DATA_WIDTH = 16, ARITH_TYPE = 1)
    ( input clk ,
      input reset,
      input bias_sel,
      input enable_write,
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
      input [DATA_WIDTH - 1 : 0] Data_in_11,  
      input [DATA_WIDTH - 1 : 0] Data_in_12,  
      input [DATA_WIDTH - 1 : 0] Data_in_13,  
      input [DATA_WIDTH - 1 : 0] Data_in_14,  
      input [DATA_WIDTH - 1 : 0] Data_in_15,  
      input [DATA_WIDTH - 1 : 0] Data_in_16,  
      input [DATA_WIDTH - 1 : 0] Data_in_17,  
      input [DATA_WIDTH - 1 : 0] Data_in_18,  
      input [DATA_WIDTH - 1 : 0] Data_in_19,  
      input [DATA_WIDTH - 1 : 0] Data_in_20,  
      input [DATA_WIDTH - 1 : 0] Data_in_21,  
      input [DATA_WIDTH - 1 : 0] Data_in_22,  
      input [DATA_WIDTH - 1 : 0] Data_in_23,  
      input [DATA_WIDTH - 1 : 0] Data_in_24,  
      input [DATA_WIDTH - 1 : 0] Data_in_25,  
      input [DATA_WIDTH - 1 : 0] Data_in_26,  
      input [DATA_WIDTH - 1 : 0] Data_in_27,  
      input [DATA_WIDTH - 1 : 0] Data_in_28,  
      input [DATA_WIDTH - 1 : 0] Data_in_29,  
      input [DATA_WIDTH - 1 : 0] Data_in_30,  
      input [DATA_WIDTH - 1 : 0] Data_in_31,  
      input [DATA_WIDTH - 1 : 0] Data_in_32,  
      input [DATA_WIDTH - 1 : 0] Data_in_33,  
      input [DATA_WIDTH - 1 : 0] Data_in_34,  
      input [DATA_WIDTH - 1 : 0] Data_in_35,  
      input [DATA_WIDTH - 1 : 0] Data_in_36,  
      input [DATA_WIDTH - 1 : 0] Data_in_37,  
      input [DATA_WIDTH - 1 : 0] Data_in_38,  
      input [DATA_WIDTH - 1 : 0] Data_in_39,  
      input [DATA_WIDTH - 1 : 0] Data_in_40,  
      input [DATA_WIDTH - 1 : 0] Data_in_41,  
      input [DATA_WIDTH - 1 : 0] Data_in_42,  
      input [DATA_WIDTH - 1 : 0] Data_in_43,  
      input [DATA_WIDTH - 1 : 0] Data_in_44,  
      input [DATA_WIDTH - 1 : 0] Data_in_45,  
      input [DATA_WIDTH - 1 : 0] Data_in_46,  
      input [DATA_WIDTH - 1 : 0] Data_in_47,  
      input [DATA_WIDTH - 1 : 0] Data_in_48,  
      input [DATA_WIDTH - 1 : 0] Data_in_49,  
      input [DATA_WIDTH - 1 : 0] Data_in_50,  
      input [DATA_WIDTH - 1 : 0] Data_in_51,  
      input [DATA_WIDTH - 1 : 0] Data_in_52,  
      input [DATA_WIDTH - 1 : 0] Data_in_53,  
      input [DATA_WIDTH - 1 : 0] Data_in_54,  
      input [DATA_WIDTH - 1 : 0] Data_in_55,  
      input [DATA_WIDTH - 1 : 0] Data_in_56,  
      input [DATA_WIDTH - 1 : 0] Data_in_57,  
      input [DATA_WIDTH - 1 : 0] Data_in_58,  
      input [DATA_WIDTH - 1 : 0] Data_in_59,  
      input [DATA_WIDTH - 1 : 0] Data_in_60,  
      input [DATA_WIDTH - 1 : 0] Data_in_61,  
      input [DATA_WIDTH - 1 : 0] Data_in_62,  
      input [DATA_WIDTH - 1 : 0] Data_in_63,  
      input [DATA_WIDTH - 1 : 0] Data_in_64,  
      input [DATA_WIDTH - 1 : 0] Data_in_65,  
      input [DATA_WIDTH - 1 : 0] Data_in_66,  
      input [DATA_WIDTH - 1 : 0] Data_in_67,  
      input [DATA_WIDTH - 1 : 0] Data_in_68,  
      input [DATA_WIDTH - 1 : 0] Data_in_69,  
      input [DATA_WIDTH - 1 : 0] Data_in_70,  
      input [DATA_WIDTH - 1 : 0] Data_in_71,  
      input [DATA_WIDTH - 1 : 0] Data_in_72,  
      input [DATA_WIDTH - 1 : 0] Data_in_73,  
      input [DATA_WIDTH - 1 : 0] Data_in_74,  
      input [DATA_WIDTH - 1 : 0] Data_in_75,  
      input [DATA_WIDTH - 1 : 0] Data_in_76,  
      input [DATA_WIDTH - 1 : 0] Data_in_77,  
      input [DATA_WIDTH - 1 : 0] Data_in_78,  
      input [DATA_WIDTH - 1 : 0] Data_in_79,  
      input [DATA_WIDTH - 1 : 0] Data_in_80,  
      input [DATA_WIDTH - 1 : 0] Data_in_81,  
      input [DATA_WIDTH - 1 : 0] Data_in_82,  
      input [DATA_WIDTH - 1 : 0] Data_in_83,  
      input [DATA_WIDTH - 1 : 0] Data_in_84,  
      input [DATA_WIDTH-1:0] data_bias_1, 
      input [DATA_WIDTH-1:0] data_bias_2, 
      input [DATA_WIDTH-1:0] data_bias_3, 
      input [DATA_WIDTH-1:0] data_bias_4, 
      input [DATA_WIDTH-1:0] data_bias_5, 
      input [DATA_WIDTH-1:0] data_bias_6, 
      input [DATA_WIDTH-1:0] data_bias_7, 
      input [DATA_WIDTH-1:0] data_bias_8, 
      input [DATA_WIDTH-1:0] data_bias_9, 
      input [DATA_WIDTH-1:0] data_bias_10,
      input [DATA_WIDTH-1:0] data_bias_11,
      input [DATA_WIDTH-1:0] data_bias_12,
      input [DATA_WIDTH-1:0] data_bias_13,
      input [DATA_WIDTH-1:0] data_bias_14,
      input [DATA_WIDTH-1:0] data_bias_15,
      input [DATA_WIDTH-1:0] data_bias_16,
      input [DATA_WIDTH-1:0] data_bias_17,
      input [DATA_WIDTH-1:0] data_bias_18,
      input [DATA_WIDTH-1:0] data_bias_19,
      input [DATA_WIDTH-1:0] data_bias_20,
      input [DATA_WIDTH-1:0] data_bias_21,
      input [DATA_WIDTH-1:0] data_bias_22,
      input [DATA_WIDTH-1:0] data_bias_23,
      input [DATA_WIDTH-1:0] data_bias_24,
      input [DATA_WIDTH-1:0] data_bias_25,
      input [DATA_WIDTH-1:0] data_bias_26,
      input [DATA_WIDTH-1:0] data_bias_27,
      input [DATA_WIDTH-1:0] data_bias_28,
      input [DATA_WIDTH-1:0] data_bias_29,
      input [DATA_WIDTH-1:0] data_bias_30,
      input [DATA_WIDTH-1:0] data_bias_31,
      input [DATA_WIDTH-1:0] data_bias_32,
      input [DATA_WIDTH-1:0] data_bias_33,
      input [DATA_WIDTH-1:0] data_bias_34,
      input [DATA_WIDTH-1:0] data_bias_35,
      input [DATA_WIDTH-1:0] data_bias_36,
      input [DATA_WIDTH-1:0] data_bias_37,
      input [DATA_WIDTH-1:0] data_bias_38,
      input [DATA_WIDTH-1:0] data_bias_39,
      input [DATA_WIDTH-1:0] data_bias_40,
      input [DATA_WIDTH-1:0] data_bias_41,
      input [DATA_WIDTH-1:0] data_bias_42,
      input [DATA_WIDTH-1:0] data_bias_43,
      input [DATA_WIDTH-1:0] data_bias_44,
      input [DATA_WIDTH-1:0] data_bias_45,
      input [DATA_WIDTH-1:0] data_bias_46,
      input [DATA_WIDTH-1:0] data_bias_47,
      input [DATA_WIDTH-1:0] data_bias_48,
      input [DATA_WIDTH-1:0] data_bias_49,
      input [DATA_WIDTH-1:0] data_bias_50,
      input [DATA_WIDTH-1:0] data_bias_51,
      input [DATA_WIDTH-1:0] data_bias_52,
      input [DATA_WIDTH-1:0] data_bias_53,
      input [DATA_WIDTH-1:0] data_bias_54,
      input [DATA_WIDTH-1:0] data_bias_55,
      input [DATA_WIDTH-1:0] data_bias_56,
      input [DATA_WIDTH-1:0] data_bias_57,
      input [DATA_WIDTH-1:0] data_bias_58,
      input [DATA_WIDTH-1:0] data_bias_59,
      input [DATA_WIDTH-1:0] data_bias_60,
      input [DATA_WIDTH-1:0] data_bias_61,
      input [DATA_WIDTH-1:0] data_bias_62,
      input [DATA_WIDTH-1:0] data_bias_63,
      input [DATA_WIDTH-1:0] data_bias_64,
      input [DATA_WIDTH-1:0] data_bias_65,
      input [DATA_WIDTH-1:0] data_bias_66,
      input [DATA_WIDTH-1:0] data_bias_67,
      input [DATA_WIDTH-1:0] data_bias_68,
      input [DATA_WIDTH-1:0] data_bias_69,
      input [DATA_WIDTH-1:0] data_bias_70,
      input [DATA_WIDTH-1:0] data_bias_71,
      input [DATA_WIDTH-1:0] data_bias_72,
      input [DATA_WIDTH-1:0] data_bias_73,
      input [DATA_WIDTH-1:0] data_bias_74,
      input [DATA_WIDTH-1:0] data_bias_75,
      input [DATA_WIDTH-1:0] data_bias_76,
      input [DATA_WIDTH-1:0] data_bias_77,
      input [DATA_WIDTH-1:0] data_bias_78,
      input [DATA_WIDTH-1:0] data_bias_79,
      input [DATA_WIDTH-1:0] data_bias_80,
      input [DATA_WIDTH-1:0] data_bias_81,
      input [DATA_WIDTH-1:0] data_bias_82,
      input [DATA_WIDTH-1:0] data_bias_83,
      input [DATA_WIDTH-1:0] data_bias_84,      
      output [DATA_WIDTH - 1 : 0] Data_out_FC_1  ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_2  ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_3  ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_4  ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_5  ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_6  ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_7  ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_8  ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_9  ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_10 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_11 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_12 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_13 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_14 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_15 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_16 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_17 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_18 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_19 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_20 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_21 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_22 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_23 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_24 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_25 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_26 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_27 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_28 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_29 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_30 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_31 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_32 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_33 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_34 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_35 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_36 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_37 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_38 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_39 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_40 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_41 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_42 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_43 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_44 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_45 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_46 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_47 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_48 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_49 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_50 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_51 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_52 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_53 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_54 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_55 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_56 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_57 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_58 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_59 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_60 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_61 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_62 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_63 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_64 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_65 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_66 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_67 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_68 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_69 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_70 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_71 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_72 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_73 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_74 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_75 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_76 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_77 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_78 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_79 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_80 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_81 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_82 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_83 ,
      output [DATA_WIDTH - 1 : 0] Data_out_FC_84 
      
    );
    
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC1(.clk(clk),.reset(reset),.data_in_from_previous( Data_in_1  ),.data_bias(data_bias_1),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_1));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC2(.clk(clk),.reset(reset),.data_in_from_previous( Data_in_2  ),.data_bias(data_bias_2),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_2));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC3(.clk(clk),.reset(reset),.data_in_from_previous( Data_in_3  ),.data_bias(data_bias_3),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_3));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC4(.clk(clk),.reset(reset),.data_in_from_previous( Data_in_4  ),.data_bias(data_bias_4),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_4));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC5(.clk(clk),.reset(reset),.data_in_from_previous( Data_in_5  ),.data_bias(data_bias_5),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_5));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC6(.clk(clk),.reset(reset),.data_in_from_previous( Data_in_6  ),.data_bias(data_bias_6),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_6));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC7(.clk(clk),.reset(reset),.data_in_from_previous( Data_in_7  ),.data_bias(data_bias_7),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_7));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC8(.clk(clk),.reset(reset),.data_in_from_previous( Data_in_8  ),.data_bias(data_bias_8),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_8));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC9(.clk(clk),.reset(reset),.data_in_from_previous( Data_in_9  ),.data_bias(data_bias_9),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_9));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC10(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_10),.data_bias(data_bias_10),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_10));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC11(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_11),.data_bias(data_bias_11),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_11));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC12(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_12),.data_bias(data_bias_12),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_12));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC13(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_13),.data_bias(data_bias_13),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_13));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC14(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_14),.data_bias(data_bias_14),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_14));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC15(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_15),.data_bias(data_bias_15),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_15));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC16(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_16),.data_bias(data_bias_16),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_16));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC17(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_17),.data_bias(data_bias_17),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_17));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC18(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_18),.data_bias(data_bias_18),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_18));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC19(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_19),.data_bias(data_bias_19),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_19));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC20(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_20),.data_bias(data_bias_20),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_20));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC21(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_21),.data_bias(data_bias_21),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_21));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC22(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_22),.data_bias(data_bias_22),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_22));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC23(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_23),.data_bias(data_bias_23),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_23));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC24(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_24),.data_bias(data_bias_24),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_24));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC25(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_25),.data_bias(data_bias_25),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_25));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC26(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_26),.data_bias(data_bias_26),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_26));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC27(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_27),.data_bias(data_bias_27),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_27));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC28(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_28),.data_bias(data_bias_28),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_28));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC29(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_29),.data_bias(data_bias_29),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_29));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC30(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_30),.data_bias(data_bias_30),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_30));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC31(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_31),.data_bias(data_bias_31),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_31));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC32(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_32),.data_bias(data_bias_32),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_32));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC33(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_33),.data_bias(data_bias_33),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_33));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC34(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_34),.data_bias(data_bias_34),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_34));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC35(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_35),.data_bias(data_bias_35),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_35));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC36(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_36),.data_bias(data_bias_36),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_36));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC37(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_37),.data_bias(data_bias_37),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_37));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC38(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_38),.data_bias(data_bias_38),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_38));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC39(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_39),.data_bias(data_bias_39),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_39));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC40(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_40),.data_bias(data_bias_40),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_40));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC41(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_41),.data_bias(data_bias_41),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_41));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC42(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_42),.data_bias(data_bias_42),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_42));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC43(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_43),.data_bias(data_bias_43),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_43));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC44(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_44),.data_bias(data_bias_44),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_44));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC45(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_45),.data_bias(data_bias_45),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_45));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC46(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_46),.data_bias(data_bias_46),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_46));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC47(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_47),.data_bias(data_bias_47),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_47));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC48(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_48),.data_bias(data_bias_48),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_48));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC49(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_49),.data_bias(data_bias_49),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_49));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC50(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_50),.data_bias(data_bias_50),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_50));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC51(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_51),.data_bias(data_bias_51),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_51));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC52(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_52),.data_bias(data_bias_52),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_52));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC53(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_53),.data_bias(data_bias_53),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_53));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC54(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_54),.data_bias(data_bias_54),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_54));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC55(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_55),.data_bias(data_bias_55),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_55));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC56(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_56),.data_bias(data_bias_56),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_56));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC57(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_57),.data_bias(data_bias_57),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_57));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC58(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_58),.data_bias(data_bias_58),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_58));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC59(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_59),.data_bias(data_bias_59),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_59));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC60(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_60),.data_bias(data_bias_60),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_60));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC61(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_61),.data_bias(data_bias_61),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_61));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC62(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_62),.data_bias(data_bias_62),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_62));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC63(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_63),.data_bias(data_bias_63),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_63));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC64(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_64),.data_bias(data_bias_64),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_64));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC65(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_65),.data_bias(data_bias_65),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_65));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC66(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_66),.data_bias(data_bias_66),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_66));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC67(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_67),.data_bias(data_bias_67),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_67));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC68(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_68),.data_bias(data_bias_68),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_68));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC69(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_69),.data_bias(data_bias_69),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_69));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC70(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_70),.data_bias(data_bias_70),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_70));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC71(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_71),.data_bias(data_bias_71),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_71));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC72(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_72),.data_bias(data_bias_72),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_72));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC73(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_73),.data_bias(data_bias_73),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_73));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC74(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_74),.data_bias(data_bias_74),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_74));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC75(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_75),.data_bias(data_bias_75),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_75));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC76(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_76),.data_bias(data_bias_76),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_76));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC77(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_77),.data_bias(data_bias_77),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_77));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC78(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_78),.data_bias(data_bias_78),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_78));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC79(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_79),.data_bias(data_bias_79),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_79));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC80(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_80),.data_bias(data_bias_80),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_80));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC81(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_81),.data_bias(data_bias_81),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_81));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC82(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_82),.data_bias(data_bias_82),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_82));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC83(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_83),.data_bias(data_bias_83),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_83));
    Reg_Accmulator #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) R_ACC84(.clk(clk),.reset(reset),.data_in_from_previous(Data_in_84),.data_bias(data_bias_84),.bias_sel(bias_sel),.Enable(enable_write | bias_sel),.reg_accu_data_out( Data_out_FC_84));
    
endmodule
