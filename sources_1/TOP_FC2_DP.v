`timescale 1ns / 1ps



module  TOP_FC2_DP  #(parameter DATA_WIDTH      = 32,
                                ADDRESS_BITS    = 11,
                                ////////////////////////////////////
                                IFM_DEPTH       = 84,
                                IFM_SIZE        = 1,
                                ADDRESS_SIZE_WM = $clog2(IFM_DEPTH),      
                                NUMBER_OF_WM    = 10
                                )
	(
	 input clk,
     input reset,
	 //intialization for weight memory
     input [DATA_WIDTH-1:0]   riscv_data,
	 input [ADDRESS_BITS-1:0] riscv_address,
	 /////////////////////////////////////////
	 input fc1_bias_sel,
	 input fc2_bias_sel,
	 input wm_addr_sel,
	 input [ADDRESS_SIZE_WM-1:0] wm_address_read_current,
     input [NUMBER_OF_WM - 1:0] wm_enable_write,
     input wm_enable_read,
     input bm_enable_write,
     /////////////////////////////////////////
	 input enable_read_fc,
	 input [ ADDRESS_SIZE_WM-1 :  0 ] sel_ifm,
	 input ifm_enable_write_previous,
	 input ifm_enable_write_next,
     input [DATA_WIDTH - 1 : 0] Data_in_1,
     input [DATA_WIDTH - 1 : 0] Data_in_2,
     input [DATA_WIDTH - 1 : 0] Data_in_3,
     input [DATA_WIDTH - 1 : 0] Data_in_4,
     input [DATA_WIDTH - 1 : 0] Data_in_5,
     input [DATA_WIDTH - 1 : 0] Data_in_6,
     input [DATA_WIDTH - 1 : 0] Data_in_7,
     input [DATA_WIDTH - 1 : 0] Data_in_8,
     input [DATA_WIDTH - 1 : 0] Data_in_9,
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
     
     //////////////////////////for next
	 output [DATA_WIDTH-1:0] Data_out_FC_1_final,
     output [DATA_WIDTH-1:0] Data_out_FC_2_final,
     output [DATA_WIDTH-1:0] Data_out_FC_3_final,
     output [DATA_WIDTH-1:0] Data_out_FC_4_final,
     output [DATA_WIDTH-1:0] Data_out_FC_5_final,
     output [DATA_WIDTH-1:0] Data_out_FC_6_final,
     output [DATA_WIDTH-1:0] Data_out_FC_7_final,
     output [DATA_WIDTH-1:0] Data_out_FC_8_final,
     output [DATA_WIDTH-1:0] Data_out_FC_9_final,
     output [DATA_WIDTH-1:0] Data_out_FC_10_final
    );
////////////////////////Signal declaration/////////////////

    wire[DATA_WIDTH - 1 : 0] Data_out_FC_1;
    wire[DATA_WIDTH - 1 : 0] Data_out_FC_2;
    wire[DATA_WIDTH - 1 : 0] Data_out_FC_3;
    wire[DATA_WIDTH - 1 : 0] Data_out_FC_4;
    wire[DATA_WIDTH - 1 : 0] Data_out_FC_5;
    wire[DATA_WIDTH - 1 : 0] Data_out_FC_6;
    wire[DATA_WIDTH - 1 : 0] Data_out_FC_7;
    wire[DATA_WIDTH - 1 : 0] Data_out_FC_8;
    wire[DATA_WIDTH - 1 : 0] Data_out_FC_9;
    wire[DATA_WIDTH - 1 : 0] Data_out_FC_10;
    
    
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem1;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem2;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem3;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem4;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem5;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem6;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem7;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem8;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem9;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem10;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem11;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem12;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem13;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem14;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem15;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem16;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem17;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem18;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem19;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem20;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem21;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem22;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem23;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem24;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem25;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem26;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem27;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem28;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem29;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem30;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem31;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem32;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem33;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem34;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem35;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem36;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem37;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem38;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem39;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem40;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem41;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem42;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem43;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem44;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem45;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem46;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem47;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem48;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem49;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem50;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem51;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem52;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem53;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem54;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem55;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem56;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem57;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem58;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem59;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem60;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem61;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem62;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem63;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem64;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem65;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem66;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem67;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem68;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem69;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem70;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem71;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem72;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem73;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem74;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem75;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem76;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem77;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem78;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem79;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem80;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem81;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem82;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem83;
    wire [DATA_WIDTH - 1 : 0] Data_Read_Mem84;
    
    
    Reg_Accmulator R_ACC1(.clk(clk),.reset(reset),.Data_in(Data_in_1),.data_bias(data_bias_1),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem1));
    Reg_Accmulator R_ACC2(.clk(clk),.reset(reset),.Data_in(Data_in_2),.data_bias(data_bias_2),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem2));
    Reg_Accmulator R_ACC3(.clk(clk),.reset(reset),.Data_in(Data_in_3),.data_bias(data_bias_3),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem3));
    Reg_Accmulator R_ACC4(.clk(clk),.reset(reset),.Data_in(Data_in_4),.data_bias(data_bias_4),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem4));
    Reg_Accmulator R_ACC5(.clk(clk),.reset(reset),.Data_in(Data_in_5),.data_bias(data_bias_5),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem5));
    Reg_Accmulator R_ACC6(.clk(clk),.reset(reset),.Data_in(Data_in_6),.data_bias(data_bias_6),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem6));
    Reg_Accmulator R_ACC7(.clk(clk),.reset(reset),.Data_in(Data_in_7),.data_bias(data_bias_7),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem7));
    Reg_Accmulator R_ACC8(.clk(clk),.reset(reset),.Data_in(Data_in_8),.data_bias(data_bias_8),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem8));
    Reg_Accmulator R_ACC9(.clk(clk),.reset(reset),.Data_in(Data_in_9),.data_bias(data_bias_9),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem9));
    Reg_Accmulator R_ACC10(.clk(clk),.reset(reset),.Data_in(Data_in_10),.data_bias(data_bias_10),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem10));
    Reg_Accmulator R_ACC11(.clk(clk),.reset(reset),.Data_in(Data_in_11),.data_bias(data_bias_11),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem11));
    Reg_Accmulator R_ACC12(.clk(clk),.reset(reset),.Data_in(Data_in_12),.data_bias(data_bias_12),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem12));
    Reg_Accmulator R_ACC13(.clk(clk),.reset(reset),.Data_in(Data_in_13),.data_bias(data_bias_13),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem13));
    Reg_Accmulator R_ACC14(.clk(clk),.reset(reset),.Data_in(Data_in_14),.data_bias(data_bias_14),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem14));
    Reg_Accmulator R_ACC15(.clk(clk),.reset(reset),.Data_in(Data_in_15),.data_bias(data_bias_15),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem15));
    Reg_Accmulator R_ACC16(.clk(clk),.reset(reset),.Data_in(Data_in_16),.data_bias(data_bias_16),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem16));
    Reg_Accmulator R_ACC17(.clk(clk),.reset(reset),.Data_in(Data_in_17),.data_bias(data_bias_17),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem17));
    Reg_Accmulator R_ACC18(.clk(clk),.reset(reset),.Data_in(Data_in_18),.data_bias(data_bias_18),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem18));
    Reg_Accmulator R_ACC19(.clk(clk),.reset(reset),.Data_in(Data_in_19),.data_bias(data_bias_19),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem19));
    Reg_Accmulator R_ACC20(.clk(clk),.reset(reset),.Data_in(Data_in_20),.data_bias(data_bias_20),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem20));
    Reg_Accmulator R_ACC21(.clk(clk),.reset(reset),.Data_in(Data_in_21),.data_bias(data_bias_21),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem21));
    Reg_Accmulator R_ACC22(.clk(clk),.reset(reset),.Data_in(Data_in_22),.data_bias(data_bias_22),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem22));
    Reg_Accmulator R_ACC23(.clk(clk),.reset(reset),.Data_in(Data_in_23),.data_bias(data_bias_23),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem23));
    Reg_Accmulator R_ACC24(.clk(clk),.reset(reset),.Data_in(Data_in_24),.data_bias(data_bias_24),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem24));
    Reg_Accmulator R_ACC25(.clk(clk),.reset(reset),.Data_in(Data_in_25),.data_bias(data_bias_25),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem25));
    Reg_Accmulator R_ACC26(.clk(clk),.reset(reset),.Data_in(Data_in_26),.data_bias(data_bias_26),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem26));
    Reg_Accmulator R_ACC27(.clk(clk),.reset(reset),.Data_in(Data_in_27),.data_bias(data_bias_27),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem27));
    Reg_Accmulator R_ACC28(.clk(clk),.reset(reset),.Data_in(Data_in_28),.data_bias(data_bias_28),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem28));
    Reg_Accmulator R_ACC29(.clk(clk),.reset(reset),.Data_in(Data_in_29),.data_bias(data_bias_29),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem29));
    Reg_Accmulator R_ACC30(.clk(clk),.reset(reset),.Data_in(Data_in_30),.data_bias(data_bias_30),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem30));
    Reg_Accmulator R_ACC31(.clk(clk),.reset(reset),.Data_in(Data_in_31),.data_bias(data_bias_31),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem31));
    Reg_Accmulator R_ACC32(.clk(clk),.reset(reset),.Data_in(Data_in_32),.data_bias(data_bias_32),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem32));
    Reg_Accmulator R_ACC33(.clk(clk),.reset(reset),.Data_in(Data_in_33),.data_bias(data_bias_33),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem33));
    Reg_Accmulator R_ACC34(.clk(clk),.reset(reset),.Data_in(Data_in_34),.data_bias(data_bias_34),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem34));
    Reg_Accmulator R_ACC35(.clk(clk),.reset(reset),.Data_in(Data_in_35),.data_bias(data_bias_35),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem35));
    Reg_Accmulator R_ACC36(.clk(clk),.reset(reset),.Data_in(Data_in_36),.data_bias(data_bias_36),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem36));
    Reg_Accmulator R_ACC37(.clk(clk),.reset(reset),.Data_in(Data_in_37),.data_bias(data_bias_37),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem37));
    Reg_Accmulator R_ACC38(.clk(clk),.reset(reset),.Data_in(Data_in_38),.data_bias(data_bias_38),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem38));
    Reg_Accmulator R_ACC39(.clk(clk),.reset(reset),.Data_in(Data_in_39),.data_bias(data_bias_39),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem39));
    Reg_Accmulator R_ACC40(.clk(clk),.reset(reset),.Data_in(Data_in_40),.data_bias(data_bias_40),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem40));
    Reg_Accmulator R_ACC41(.clk(clk),.reset(reset),.Data_in(Data_in_41),.data_bias(data_bias_41),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem41));
    Reg_Accmulator R_ACC42(.clk(clk),.reset(reset),.Data_in(Data_in_42),.data_bias(data_bias_42),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem42));
    Reg_Accmulator R_ACC43(.clk(clk),.reset(reset),.Data_in(Data_in_43),.data_bias(data_bias_43),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem43));
    Reg_Accmulator R_ACC44(.clk(clk),.reset(reset),.Data_in(Data_in_44),.data_bias(data_bias_44),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem44));
    Reg_Accmulator R_ACC45(.clk(clk),.reset(reset),.Data_in(Data_in_45),.data_bias(data_bias_45),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem45));
    Reg_Accmulator R_ACC46(.clk(clk),.reset(reset),.Data_in(Data_in_46),.data_bias(data_bias_46),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem46));
    Reg_Accmulator R_ACC47(.clk(clk),.reset(reset),.Data_in(Data_in_47),.data_bias(data_bias_47),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem47));
    Reg_Accmulator R_ACC48(.clk(clk),.reset(reset),.Data_in(Data_in_48),.data_bias(data_bias_48),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem48));
    Reg_Accmulator R_ACC49(.clk(clk),.reset(reset),.Data_in(Data_in_49),.data_bias(data_bias_49),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem49));
    Reg_Accmulator R_ACC50(.clk(clk),.reset(reset),.Data_in(Data_in_50),.data_bias(data_bias_50),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem50));
    Reg_Accmulator R_ACC51(.clk(clk),.reset(reset),.Data_in(Data_in_51),.data_bias(data_bias_51),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem51));
    Reg_Accmulator R_ACC52(.clk(clk),.reset(reset),.Data_in(Data_in_52),.data_bias(data_bias_52),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem52));
    Reg_Accmulator R_ACC53(.clk(clk),.reset(reset),.Data_in(Data_in_53),.data_bias(data_bias_53),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem53));
    Reg_Accmulator R_ACC54(.clk(clk),.reset(reset),.Data_in(Data_in_54),.data_bias(data_bias_54),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem54));
    Reg_Accmulator R_ACC55(.clk(clk),.reset(reset),.Data_in(Data_in_55),.data_bias(data_bias_55),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem55));
    Reg_Accmulator R_ACC56(.clk(clk),.reset(reset),.Data_in(Data_in_56),.data_bias(data_bias_56),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem56));
    Reg_Accmulator R_ACC57(.clk(clk),.reset(reset),.Data_in(Data_in_57),.data_bias(data_bias_57),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem57));
    Reg_Accmulator R_ACC58(.clk(clk),.reset(reset),.Data_in(Data_in_58),.data_bias(data_bias_58),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem58));
    Reg_Accmulator R_ACC59(.clk(clk),.reset(reset),.Data_in(Data_in_59),.data_bias(data_bias_59),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem59));
    Reg_Accmulator R_ACC60(.clk(clk),.reset(reset),.Data_in(Data_in_60),.data_bias(data_bias_60),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem60));
    Reg_Accmulator R_ACC61(.clk(clk),.reset(reset),.Data_in(Data_in_61),.data_bias(data_bias_61),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem61));
    Reg_Accmulator R_ACC62(.clk(clk),.reset(reset),.Data_in(Data_in_62),.data_bias(data_bias_62),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem62));
    Reg_Accmulator R_ACC63(.clk(clk),.reset(reset),.Data_in(Data_in_63),.data_bias(data_bias_63),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem63));
    Reg_Accmulator R_ACC64(.clk(clk),.reset(reset),.Data_in(Data_in_64),.data_bias(data_bias_64),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem64));
    Reg_Accmulator R_ACC65(.clk(clk),.reset(reset),.Data_in(Data_in_65),.data_bias(data_bias_65),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem65));
    Reg_Accmulator R_ACC66(.clk(clk),.reset(reset),.Data_in(Data_in_66),.data_bias(data_bias_66),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem66));
    Reg_Accmulator R_ACC67(.clk(clk),.reset(reset),.Data_in(Data_in_67),.data_bias(data_bias_67),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem67));
    Reg_Accmulator R_ACC68(.clk(clk),.reset(reset),.Data_in(Data_in_68),.data_bias(data_bias_68),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem68));
    Reg_Accmulator R_ACC69(.clk(clk),.reset(reset),.Data_in(Data_in_69),.data_bias(data_bias_69),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem69));
    Reg_Accmulator R_ACC70(.clk(clk),.reset(reset),.Data_in(Data_in_70),.data_bias(data_bias_70),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem70));
    Reg_Accmulator R_ACC71(.clk(clk),.reset(reset),.Data_in(Data_in_71),.data_bias(data_bias_71),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem71));
    Reg_Accmulator R_ACC72(.clk(clk),.reset(reset),.Data_in(Data_in_72),.data_bias(data_bias_72),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem72));
    Reg_Accmulator R_ACC73(.clk(clk),.reset(reset),.Data_in(Data_in_73),.data_bias(data_bias_73),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem73));
    Reg_Accmulator R_ACC74(.clk(clk),.reset(reset),.Data_in(Data_in_74),.data_bias(data_bias_74),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem74));
    Reg_Accmulator R_ACC75(.clk(clk),.reset(reset),.Data_in(Data_in_75),.data_bias(data_bias_75),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem75));
    Reg_Accmulator R_ACC76(.clk(clk),.reset(reset),.Data_in(Data_in_76),.data_bias(data_bias_76),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem76));
    Reg_Accmulator R_ACC77(.clk(clk),.reset(reset),.Data_in(Data_in_77),.data_bias(data_bias_77),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem77));
    Reg_Accmulator R_ACC78(.clk(clk),.reset(reset),.Data_in(Data_in_78),.data_bias(data_bias_78),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem78));
    Reg_Accmulator R_ACC79(.clk(clk),.reset(reset),.Data_in(Data_in_79),.data_bias(data_bias_79),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem79));
    Reg_Accmulator R_ACC80(.clk(clk),.reset(reset),.Data_in(Data_in_80),.data_bias(data_bias_80),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem80));
    Reg_Accmulator R_ACC81(.clk(clk),.reset(reset),.Data_in(Data_in_81),.data_bias(data_bias_81),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem81));
    Reg_Accmulator R_ACC82(.clk(clk),.reset(reset),.Data_in(Data_in_82),.data_bias(data_bias_82),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem82));
    Reg_Accmulator R_ACC83(.clk(clk),.reset(reset),.Data_in(Data_in_83),.data_bias(data_bias_83),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem83));
    Reg_Accmulator R_ACC84(.clk(clk),.reset(reset),.Data_in(Data_in_84),.data_bias(data_bias_84),.bias_sel(fc1_bias_sel),.Enable(ifm_enable_write_previous),.Data_out(Data_Read_Mem84));
    
    reg [DATA_WIDTH - 1 : 0] Data_Read_mux;

    always @(*)
    begin
        case (sel_ifm)
        7'b0000000 : Data_Read_mux = Data_Read_Mem1;
        7'b0000001 : Data_Read_mux = Data_Read_Mem2;
        7'b0000010 : Data_Read_mux = Data_Read_Mem3;
        7'b0000011 : Data_Read_mux = Data_Read_Mem4;
        7'b0000100 : Data_Read_mux = Data_Read_Mem5;
        7'b0000101 : Data_Read_mux = Data_Read_Mem6;
        7'b0000110 : Data_Read_mux = Data_Read_Mem7;
        7'b0000111 : Data_Read_mux = Data_Read_Mem8;
        7'b0001000 : Data_Read_mux = Data_Read_Mem9;
        7'b0001001 : Data_Read_mux = Data_Read_Mem10;
        7'b0001010 : Data_Read_mux = Data_Read_Mem11;
        7'b0001011 : Data_Read_mux = Data_Read_Mem12;
        7'b0001100 : Data_Read_mux = Data_Read_Mem13;
        7'b0001101 : Data_Read_mux = Data_Read_Mem14;
        7'b0001110 : Data_Read_mux = Data_Read_Mem15;
        7'b0001111 : Data_Read_mux = Data_Read_Mem16;
        7'b0010000 : Data_Read_mux = Data_Read_Mem17;
        7'b0010001 : Data_Read_mux = Data_Read_Mem18;
        7'b0010010 : Data_Read_mux = Data_Read_Mem19;
        7'b0010011 : Data_Read_mux = Data_Read_Mem20;
        7'b0010100 : Data_Read_mux = Data_Read_Mem21;
        7'b0010101 : Data_Read_mux = Data_Read_Mem22;
        7'b0010110 : Data_Read_mux = Data_Read_Mem23;
        7'b0010111 : Data_Read_mux = Data_Read_Mem24;
        7'b0011000 : Data_Read_mux = Data_Read_Mem25;
        7'b0011001 : Data_Read_mux = Data_Read_Mem26;
        7'b0011010 : Data_Read_mux = Data_Read_Mem27;
        7'b0011011 : Data_Read_mux = Data_Read_Mem28;
        7'b0011100 : Data_Read_mux = Data_Read_Mem29;
        7'b0011101 : Data_Read_mux = Data_Read_Mem30;
        7'b0011110 : Data_Read_mux = Data_Read_Mem31;
        7'b0011111 : Data_Read_mux = Data_Read_Mem32;
        7'b0100000 : Data_Read_mux = Data_Read_Mem33;
        7'b0100001 : Data_Read_mux = Data_Read_Mem34;
        7'b0100010 : Data_Read_mux = Data_Read_Mem35;
        7'b0100011 : Data_Read_mux = Data_Read_Mem36;
        7'b0100100 : Data_Read_mux = Data_Read_Mem37;
        7'b0100101 : Data_Read_mux = Data_Read_Mem38;
        7'b0100110 : Data_Read_mux = Data_Read_Mem39;
        7'b0100111 : Data_Read_mux = Data_Read_Mem40;
        7'b0101000 : Data_Read_mux = Data_Read_Mem41;
        7'b0101001 : Data_Read_mux = Data_Read_Mem42;
        7'b0101010 : Data_Read_mux = Data_Read_Mem43;
        7'b0101011 : Data_Read_mux = Data_Read_Mem44;
        7'b0101100 : Data_Read_mux = Data_Read_Mem45;
        7'b0101101 : Data_Read_mux = Data_Read_Mem46;
        7'b0101110 : Data_Read_mux = Data_Read_Mem47;
        7'b0101111 : Data_Read_mux = Data_Read_Mem48;
        7'b0110000 : Data_Read_mux = Data_Read_Mem49;
        7'b0110001 : Data_Read_mux = Data_Read_Mem50;
        7'b0110010 : Data_Read_mux = Data_Read_Mem51;
        7'b0110011 : Data_Read_mux = Data_Read_Mem52;
        7'b0110100 : Data_Read_mux = Data_Read_Mem53;
        7'b0110101 : Data_Read_mux = Data_Read_Mem54;
        7'b0110110 : Data_Read_mux = Data_Read_Mem55;
        7'b0110111 : Data_Read_mux = Data_Read_Mem56;
        7'b0111000 : Data_Read_mux = Data_Read_Mem57;
        7'b0111001 : Data_Read_mux = Data_Read_Mem58;
        7'b0111010 : Data_Read_mux = Data_Read_Mem59;
        7'b0111011 : Data_Read_mux = Data_Read_Mem60;
        7'b0111100 : Data_Read_mux = Data_Read_Mem61;
        7'b0111101 : Data_Read_mux = Data_Read_Mem62;
        7'b0111110 : Data_Read_mux = Data_Read_Mem63;
        7'b0111111 : Data_Read_mux = Data_Read_Mem64;
        7'b1000000 : Data_Read_mux = Data_Read_Mem65;
        7'b1000001 : Data_Read_mux = Data_Read_Mem66;
        7'b1000010 : Data_Read_mux = Data_Read_Mem67;
        7'b1000011 : Data_Read_mux = Data_Read_Mem68;
        7'b1000100 : Data_Read_mux = Data_Read_Mem69;
        7'b1000101 : Data_Read_mux = Data_Read_Mem70;
        7'b1000110 : Data_Read_mux = Data_Read_Mem71;
        7'b1000111 : Data_Read_mux = Data_Read_Mem72;
        7'b1001000 : Data_Read_mux = Data_Read_Mem73;
        7'b1001001 : Data_Read_mux = Data_Read_Mem74;
        7'b1001010 : Data_Read_mux = Data_Read_Mem75;
        7'b1001011 : Data_Read_mux = Data_Read_Mem76;
        7'b1001100 : Data_Read_mux = Data_Read_Mem77;
        7'b1001101 : Data_Read_mux = Data_Read_Mem78;
        7'b1001110 : Data_Read_mux = Data_Read_Mem79;
        7'b1001111 : Data_Read_mux = Data_Read_Mem80;
        7'b1010000 : Data_Read_mux = Data_Read_Mem81;
        7'b1010001 : Data_Read_mux = Data_Read_Mem82;
        7'b1010010 : Data_Read_mux = Data_Read_Mem83;
        7'b1010011 : Data_Read_mux = Data_Read_Mem84;
        default :  Data_Read_mux =0 ;
        endcase
    end
    
    wire [DATA_WIDTH-1:0] Data_for_FC;
    wire [DATA_WIDTH-1:0] relu_out ;

    Relu  Active (.in(Data_Read_mux),.out (relu_out),.relu_enable(1'b1));
    Register R (.clk(clk),.reset(reset),.Data_in(relu_out),.Enable(enable_read_fc),.Data_out(Data_for_FC)); 
 
    wire [ADDRESS_SIZE_WM-1:0] wm_address;
    assign wm_address = wm_addr_sel ? wm_address_read_current : riscv_address;
	
    wire [DATA_WIDTH-1:0] Data_Weight_1;
    wire [DATA_WIDTH-1:0] Data_Weight_2;
    wire [DATA_WIDTH-1:0] Data_Weight_3;
    wire [DATA_WIDTH-1:0] Data_Weight_4;
    wire [DATA_WIDTH-1:0] Data_Weight_5;
    wire [DATA_WIDTH-1:0] Data_Weight_6;
    wire [DATA_WIDTH-1:0] Data_Weight_7;
    wire [DATA_WIDTH-1:0] Data_Weight_8;
    wire [DATA_WIDTH-1:0] Data_Weight_9;
    wire [DATA_WIDTH-1:0] Data_Weight_10;
    
    wire [DATA_WIDTH-1:0] data_bias_fc2_1;
    wire [DATA_WIDTH-1:0] data_bias_fc2_2;
    wire [DATA_WIDTH-1:0] data_bias_fc2_3;
    wire [DATA_WIDTH-1:0] data_bias_fc2_4;
    wire [DATA_WIDTH-1:0] data_bias_fc2_5;
    wire [DATA_WIDTH-1:0] data_bias_fc2_6;
    wire [DATA_WIDTH-1:0] data_bias_fc2_7;
    wire [DATA_WIDTH-1:0] data_bias_fc2_8;
    wire [DATA_WIDTH-1:0] data_bias_fc2_9;
    wire [DATA_WIDTH-1:0] data_bias_fc2_10;


SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W1(.clk(clk),.Enable_Write(wm_enable_write[0]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_1));
SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W2(.clk(clk),.Enable_Write(wm_enable_write[1]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_2));
SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W3(.clk(clk),.Enable_Write(wm_enable_write[2]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_3));
SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W4(.clk(clk),.Enable_Write(wm_enable_write[3]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_4));
SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W5(.clk(clk),.Enable_Write(wm_enable_write[4]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_5));
SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W6(.clk(clk),.Enable_Write(wm_enable_write[5]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_6));
SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W7(.clk(clk),.Enable_Write(wm_enable_write[6]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_7));
SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W8(.clk(clk),.Enable_Write(wm_enable_write[7]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_8));
SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W9(.clk(clk),.Enable_Write(wm_enable_write[8]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_9));
SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W10(.clk(clk),.Enable_Write(wm_enable_write[9]), .Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_10));


Fully_Connected_2 F2 (.Data_in(Data_for_FC),.Data_Weight_1(Data_Weight_1) ,.Data_Weight_2(Data_Weight_2) ,.Data_Weight_3(Data_Weight_3) ,.Data_Weight_4(Data_Weight_4) ,.Data_Weight_5(Data_Weight_5) ,.Data_Weight_6(Data_Weight_6) ,.Data_Weight_7(Data_Weight_7) ,.Data_Weight_8(Data_Weight_8) ,.Data_Weight_9(Data_Weight_9) ,.Data_Weight_10(Data_Weight_10) ,.Data_out_FC_1(Data_out_FC_1) ,.Data_out_FC_2(Data_out_FC_2) ,.Data_out_FC_3(Data_out_FC_3) ,.Data_out_FC_4(Data_out_FC_4) ,.Data_out_FC_5(Data_out_FC_5) ,.Data_out_FC_6(Data_out_FC_6) ,.Data_out_FC_7(Data_out_FC_7) ,.Data_out_FC_8(Data_out_FC_8) ,.Data_out_FC_9(Data_out_FC_9) ,.Data_out_FC_10(Data_out_FC_10));

FIFO_10outputs_FC2 FIFO1 (.clk(clk), 
                          .fifo_data_in(riscv_data), 
                          .fifo_enable(bm_enable_write),
                          .fifo_data_out_1 (data_bias_fc2_1 ),
                          .fifo_data_out_2 (data_bias_fc2_2 ),
                          .fifo_data_out_3 (data_bias_fc2_3 ),
                          .fifo_data_out_4 (data_bias_fc2_4 ),
                          .fifo_data_out_5 (data_bias_fc2_5 ),
                          .fifo_data_out_6 (data_bias_fc2_6 ),
                          .fifo_data_out_7 (data_bias_fc2_7 ),
                          .fifo_data_out_8 (data_bias_fc2_8 ),
                          .fifo_data_out_9 (data_bias_fc2_9 ),
                          .fifo_data_out_10(data_bias_fc2_10)
                          );

Reg_Accmulator R_ACC1_out(.clk(clk),.reset(reset),.Data_in(Data_out_FC_1),.data_bias(data_bias_fc2_1),.bias_sel(fc2_bias_sel),.Enable(ifm_enable_write_next),.Data_out(Data_out_FC_1_final));
Reg_Accmulator R_ACC2_out(.clk(clk),.reset(reset),.Data_in(Data_out_FC_2),.data_bias(data_bias_fc2_2),.bias_sel(fc2_bias_sel),.Enable(ifm_enable_write_next),.Data_out(Data_out_FC_2_final));
Reg_Accmulator R_ACC3_out(.clk(clk),.reset(reset),.Data_in(Data_out_FC_3),.data_bias(data_bias_fc2_3),.bias_sel(fc2_bias_sel),.Enable(ifm_enable_write_next),.Data_out(Data_out_FC_3_final));
Reg_Accmulator R_ACC4_out(.clk(clk),.reset(reset),.Data_in(Data_out_FC_4),.data_bias(data_bias_fc2_4),.bias_sel(fc2_bias_sel),.Enable(ifm_enable_write_next),.Data_out(Data_out_FC_4_final));
Reg_Accmulator R_ACC5_out(.clk(clk),.reset(reset),.Data_in(Data_out_FC_5),.data_bias(data_bias_fc2_5),.bias_sel(fc2_bias_sel),.Enable(ifm_enable_write_next),.Data_out(Data_out_FC_5_final));
Reg_Accmulator R_ACC6_out(.clk(clk),.reset(reset),.Data_in(Data_out_FC_6),.data_bias(data_bias_fc2_6),.bias_sel(fc2_bias_sel),.Enable(ifm_enable_write_next),.Data_out(Data_out_FC_6_final));
Reg_Accmulator R_ACC7_out(.clk(clk),.reset(reset),.Data_in(Data_out_FC_7),.data_bias(data_bias_fc2_7),.bias_sel(fc2_bias_sel),.Enable(ifm_enable_write_next),.Data_out(Data_out_FC_7_final));
Reg_Accmulator R_ACC8_out(.clk(clk),.reset(reset),.Data_in(Data_out_FC_8),.data_bias(data_bias_fc2_8),.bias_sel(fc2_bias_sel),.Enable(ifm_enable_write_next),.Data_out(Data_out_FC_8_final));
Reg_Accmulator R_ACC9_out(.clk(clk),.reset(reset),.Data_in(Data_out_FC_9),.data_bias(data_bias_fc2_9),.bias_sel(fc2_bias_sel),.Enable(ifm_enable_write_next),.Data_out(Data_out_FC_9_final));
Reg_Accmulator R_ACC10_out(.clk(clk),.reset(reset),.Data_in(Data_out_FC_10),.data_bias(data_bias_fc2_10),.bias_sel(fc2_bias_sel),.Enable(ifm_enable_write_next),.Data_out(Data_out_FC_10_final));



endmodule