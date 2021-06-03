`timescale 1ns / 1ps


module  TOP_FC1 #(parameter DATA_WIDTH      = 32,
                            ADDRESS_BITS    = 15,
                            ////////////////////////////////////
                            IFM_DEPTH       = 120,
                            IFM_SIZE        = 1,
                            ADDRESS_SIZE_WM = $clog2(IFM_DEPTH),      
                            NUMBER_OF_WM    = 84
                            )
     (
     input clk,
	 input reset,
     /////////////Initialzation Weight Mmeory part ricsv
     input [DATA_WIDTH-1:0]   riscv_data,
	 input [ADDRESS_BITS-1:0] riscv_address,
	 input [NUMBER_OF_WM-1:0] wm_enable_write,
	 input  bm_enable_write,
     /////////////////////////////////////////////////////	 
	 // previous
	 input  [DATA_WIDTH-1 : 0] data_in_from_previous,
	 output [DATA_WIDTH-1:0] data_out_for_previous,
	 input  ifm_enable_write_previous,
	 input  ifm_enable_read_previous,
	 input  start_from_previous,  
     output end_to_previous,
     output fc1_bias_sel,
     ////////////////////////////////////////// for next
    output [DATA_WIDTH-1:0] Data_out_FC_1,
    output [DATA_WIDTH-1:0] Data_out_FC_2,
    output [DATA_WIDTH-1:0] Data_out_FC_3,
    output [DATA_WIDTH-1:0] Data_out_FC_4,
    output [DATA_WIDTH-1:0] Data_out_FC_5,
    output [DATA_WIDTH-1:0] Data_out_FC_6,
    output [DATA_WIDTH-1:0] Data_out_FC_7,
    output [DATA_WIDTH-1:0] Data_out_FC_8,
    output [DATA_WIDTH-1:0] Data_out_FC_9,
    output [DATA_WIDTH-1:0] Data_out_FC_10,
    output [DATA_WIDTH-1:0] Data_out_FC_11,
    output [DATA_WIDTH-1:0] Data_out_FC_12,
    output [DATA_WIDTH-1:0] Data_out_FC_13,
    output [DATA_WIDTH-1:0] Data_out_FC_14,
    output [DATA_WIDTH-1:0] Data_out_FC_15,
    output [DATA_WIDTH-1:0] Data_out_FC_16,
    output [DATA_WIDTH-1:0] Data_out_FC_17,
    output [DATA_WIDTH-1:0] Data_out_FC_18,
    output [DATA_WIDTH-1:0] Data_out_FC_19,
    output [DATA_WIDTH-1:0] Data_out_FC_20,
    output [DATA_WIDTH-1:0] Data_out_FC_21,
    output [DATA_WIDTH-1:0] Data_out_FC_22,
    output [DATA_WIDTH-1:0] Data_out_FC_23,
    output [DATA_WIDTH-1:0] Data_out_FC_24,
    output [DATA_WIDTH-1:0] Data_out_FC_25,
    output [DATA_WIDTH-1:0] Data_out_FC_26,
    output [DATA_WIDTH-1:0] Data_out_FC_27,
    output [DATA_WIDTH-1:0] Data_out_FC_28,
    output [DATA_WIDTH-1:0] Data_out_FC_29,
    output [DATA_WIDTH-1:0] Data_out_FC_30,
    output [DATA_WIDTH-1:0] Data_out_FC_31,
    output [DATA_WIDTH-1:0] Data_out_FC_32,
    output [DATA_WIDTH-1:0] Data_out_FC_33,
    output [DATA_WIDTH-1:0] Data_out_FC_34,
    output [DATA_WIDTH-1:0] Data_out_FC_35,
    output [DATA_WIDTH-1:0] Data_out_FC_36,
    output [DATA_WIDTH-1:0] Data_out_FC_37,
    output [DATA_WIDTH-1:0] Data_out_FC_38,
    output [DATA_WIDTH-1:0] Data_out_FC_39,
    output [DATA_WIDTH-1:0] Data_out_FC_40,
    output [DATA_WIDTH-1:0] Data_out_FC_41,
    output [DATA_WIDTH-1:0] Data_out_FC_42,
    output [DATA_WIDTH-1:0] Data_out_FC_43,
    output [DATA_WIDTH-1:0] Data_out_FC_44,
    output [DATA_WIDTH-1:0] Data_out_FC_45,
    output [DATA_WIDTH-1:0] Data_out_FC_46,
    output [DATA_WIDTH-1:0] Data_out_FC_47,
    output [DATA_WIDTH-1:0] Data_out_FC_48,
    output [DATA_WIDTH-1:0] Data_out_FC_49,
    output [DATA_WIDTH-1:0] Data_out_FC_50,
    output [DATA_WIDTH-1:0] Data_out_FC_51,
    output [DATA_WIDTH-1:0] Data_out_FC_52,
    output [DATA_WIDTH-1:0] Data_out_FC_53,
    output [DATA_WIDTH-1:0] Data_out_FC_54,
    output [DATA_WIDTH-1:0] Data_out_FC_55,
    output [DATA_WIDTH-1:0] Data_out_FC_56,
    output [DATA_WIDTH-1:0] Data_out_FC_57,
    output [DATA_WIDTH-1:0] Data_out_FC_58,
    output [DATA_WIDTH-1:0] Data_out_FC_59,
    output [DATA_WIDTH-1:0] Data_out_FC_60,
    output [DATA_WIDTH-1:0] Data_out_FC_61,
    output [DATA_WIDTH-1:0] Data_out_FC_62,
    output [DATA_WIDTH-1:0] Data_out_FC_63,
    output [DATA_WIDTH-1:0] Data_out_FC_64,
    output [DATA_WIDTH-1:0] Data_out_FC_65,
    output [DATA_WIDTH-1:0] Data_out_FC_66,
    output [DATA_WIDTH-1:0] Data_out_FC_67,
    output [DATA_WIDTH-1:0] Data_out_FC_68,
    output [DATA_WIDTH-1:0] Data_out_FC_69,
    output [DATA_WIDTH-1:0] Data_out_FC_70,
    output [DATA_WIDTH-1:0] Data_out_FC_71,
    output [DATA_WIDTH-1:0] Data_out_FC_72,
    output [DATA_WIDTH-1:0] Data_out_FC_73,
    output [DATA_WIDTH-1:0] Data_out_FC_74,
    output [DATA_WIDTH-1:0] Data_out_FC_75,
    output [DATA_WIDTH-1:0] Data_out_FC_76,
    output [DATA_WIDTH-1:0] Data_out_FC_77,
    output [DATA_WIDTH-1:0] Data_out_FC_78,
    output [DATA_WIDTH-1:0] Data_out_FC_79,
    output [DATA_WIDTH-1:0] Data_out_FC_80,
    output [DATA_WIDTH-1:0] Data_out_FC_81,
    output [DATA_WIDTH-1:0] Data_out_FC_82,
    output [DATA_WIDTH-1:0] Data_out_FC_83,
    output [DATA_WIDTH-1:0] Data_out_FC_84,
    
    output [DATA_WIDTH-1:0] data_bias_1, 
    output [DATA_WIDTH-1:0] data_bias_2, 
    output [DATA_WIDTH-1:0] data_bias_3, 
    output [DATA_WIDTH-1:0] data_bias_4, 
    output [DATA_WIDTH-1:0] data_bias_5, 
    output [DATA_WIDTH-1:0] data_bias_6, 
    output [DATA_WIDTH-1:0] data_bias_7, 
    output [DATA_WIDTH-1:0] data_bias_8, 
    output [DATA_WIDTH-1:0] data_bias_9, 
    output [DATA_WIDTH-1:0] data_bias_10,
    output [DATA_WIDTH-1:0] data_bias_11,
    output [DATA_WIDTH-1:0] data_bias_12,
    output [DATA_WIDTH-1:0] data_bias_13,
    output [DATA_WIDTH-1:0] data_bias_14,
    output [DATA_WIDTH-1:0] data_bias_15,
    output [DATA_WIDTH-1:0] data_bias_16,
    output [DATA_WIDTH-1:0] data_bias_17,
    output [DATA_WIDTH-1:0] data_bias_18,
    output [DATA_WIDTH-1:0] data_bias_19,
    output [DATA_WIDTH-1:0] data_bias_20,
    output [DATA_WIDTH-1:0] data_bias_21,
    output [DATA_WIDTH-1:0] data_bias_22,
    output [DATA_WIDTH-1:0] data_bias_23,
    output [DATA_WIDTH-1:0] data_bias_24,
    output [DATA_WIDTH-1:0] data_bias_25,
    output [DATA_WIDTH-1:0] data_bias_26,
    output [DATA_WIDTH-1:0] data_bias_27,
    output [DATA_WIDTH-1:0] data_bias_28,
    output [DATA_WIDTH-1:0] data_bias_29,
    output [DATA_WIDTH-1:0] data_bias_30,
    output [DATA_WIDTH-1:0] data_bias_31,
    output [DATA_WIDTH-1:0] data_bias_32,
    output [DATA_WIDTH-1:0] data_bias_33,
    output [DATA_WIDTH-1:0] data_bias_34,
    output [DATA_WIDTH-1:0] data_bias_35,
    output [DATA_WIDTH-1:0] data_bias_36,
    output [DATA_WIDTH-1:0] data_bias_37,
    output [DATA_WIDTH-1:0] data_bias_38,
    output [DATA_WIDTH-1:0] data_bias_39,
    output [DATA_WIDTH-1:0] data_bias_40,
    output [DATA_WIDTH-1:0] data_bias_41,
    output [DATA_WIDTH-1:0] data_bias_42,
    output [DATA_WIDTH-1:0] data_bias_43,
    output [DATA_WIDTH-1:0] data_bias_44,
    output [DATA_WIDTH-1:0] data_bias_45,
    output [DATA_WIDTH-1:0] data_bias_46,
    output [DATA_WIDTH-1:0] data_bias_47,
    output [DATA_WIDTH-1:0] data_bias_48,
    output [DATA_WIDTH-1:0] data_bias_49,
    output [DATA_WIDTH-1:0] data_bias_50,
    output [DATA_WIDTH-1:0] data_bias_51,
    output [DATA_WIDTH-1:0] data_bias_52,
    output [DATA_WIDTH-1:0] data_bias_53,
    output [DATA_WIDTH-1:0] data_bias_54,
    output [DATA_WIDTH-1:0] data_bias_55,
    output [DATA_WIDTH-1:0] data_bias_56,
    output [DATA_WIDTH-1:0] data_bias_57,
    output [DATA_WIDTH-1:0] data_bias_58,
    output [DATA_WIDTH-1:0] data_bias_59,
    output [DATA_WIDTH-1:0] data_bias_60,
    output [DATA_WIDTH-1:0] data_bias_61,
    output [DATA_WIDTH-1:0] data_bias_62,
    output [DATA_WIDTH-1:0] data_bias_63,
    output [DATA_WIDTH-1:0] data_bias_64,
    output [DATA_WIDTH-1:0] data_bias_65,
    output [DATA_WIDTH-1:0] data_bias_66,
    output [DATA_WIDTH-1:0] data_bias_67,
    output [DATA_WIDTH-1:0] data_bias_68,
    output [DATA_WIDTH-1:0] data_bias_69,
    output [DATA_WIDTH-1:0] data_bias_70,
    output [DATA_WIDTH-1:0] data_bias_71,
    output [DATA_WIDTH-1:0] data_bias_72,
    output [DATA_WIDTH-1:0] data_bias_73,
    output [DATA_WIDTH-1:0] data_bias_74,
    output [DATA_WIDTH-1:0] data_bias_75,
    output [DATA_WIDTH-1:0] data_bias_76,
    output [DATA_WIDTH-1:0] data_bias_77,
    output [DATA_WIDTH-1:0] data_bias_78,
    output [DATA_WIDTH-1:0] data_bias_79,
    output [DATA_WIDTH-1:0] data_bias_80,
    output [DATA_WIDTH-1:0] data_bias_81,
    output [DATA_WIDTH-1:0] data_bias_82,
    output [DATA_WIDTH-1:0] data_bias_83,
    output [DATA_WIDTH-1:0] data_bias_84,
    output ifm_enable_write_next,
    output start_to_next,
    input  end_from_next
    );
	
  
    wire  wm_addr_sel;
    wire  enable_read_fc;  
    wire  [ADDRESS_SIZE_WM-1:0] wm_address_read_current;
    wire  wm_enable_read;
    wire  ifm_sel;
    
   

     TOP_FC1_CU  FC1_CU
    (
    .clk(clk),
    .reset(reset),
    //////////////////////////////
    .wm_addr_sel(wm_addr_sel),
    .wm_address_read_current(wm_address_read_current),  
    .wm_enable_read (wm_enable_read),
    .fc1_bias_sel (fc1_bias_sel),
    ///////////////////////////////////////
    .enable_read_fc(enable_read_fc),
    .start_from_previous(start_from_previous), 
    .ifm_sel (ifm_sel),
    .end_to_previous (end_to_previous),
    .end_from_next(end_from_next) ,
    .ifm_enable_write_next(ifm_enable_write_next),
    .start_to_next (start_to_next)  
   );
    
   
    TOP_FC1_DP  FC1_DP
	(
	.clk(clk),
	.reset(reset),	
	.riscv_data(riscv_data),
	.riscv_address(riscv_address),
	/////////////////////////////////
    .wm_enable_write (wm_enable_write),
    .wm_address_read_current (wm_address_read_current),
    .wm_enable_read (wm_enable_read),
    .wm_addr_sel (wm_addr_sel) , 
    .bm_enable_write(bm_enable_write),
    
    ///from control unit
    ///////////////////////////////////
	.data_in_from_previous(data_in_from_previous),
	.ifm_enable_write_previous(ifm_enable_write_previous),// from control unit
	.ifm_enable_read_previous (ifm_enable_read_previous),
	.data_out_for_previous(data_out_for_previous),
	.enable_read_fc(enable_read_fc), //from control unit
	 //from control unit
		/////////////////////////////////////
	.ifm_sel(ifm_sel),
    .Data_out_FC_1(Data_out_FC_1) ,.Data_out_FC_2(Data_out_FC_2) ,.Data_out_FC_3(Data_out_FC_3) ,.Data_out_FC_4(Data_out_FC_4) ,.Data_out_FC_5(Data_out_FC_5) ,.Data_out_FC_6(Data_out_FC_6) ,.Data_out_FC_7(Data_out_FC_7) ,.Data_out_FC_8(Data_out_FC_8) ,.Data_out_FC_9(Data_out_FC_9) ,.Data_out_FC_10(Data_out_FC_10) ,.Data_out_FC_11(Data_out_FC_11) ,.Data_out_FC_12(Data_out_FC_12) ,.Data_out_FC_13(Data_out_FC_13) ,.Data_out_FC_14(Data_out_FC_14) ,.Data_out_FC_15(Data_out_FC_15) ,.Data_out_FC_16(Data_out_FC_16) ,.Data_out_FC_17(Data_out_FC_17) ,.Data_out_FC_18(Data_out_FC_18) ,.Data_out_FC_19(Data_out_FC_19) ,.Data_out_FC_20(Data_out_FC_20) ,.Data_out_FC_21(Data_out_FC_21) ,.Data_out_FC_22(Data_out_FC_22) ,.Data_out_FC_23(Data_out_FC_23) ,.Data_out_FC_24(Data_out_FC_24) ,.Data_out_FC_25(Data_out_FC_25) ,.Data_out_FC_26(Data_out_FC_26) ,.Data_out_FC_27(Data_out_FC_27) ,.Data_out_FC_28(Data_out_FC_28) ,.Data_out_FC_29(Data_out_FC_29) ,.Data_out_FC_30(Data_out_FC_30) ,.Data_out_FC_31(Data_out_FC_31) ,.Data_out_FC_32(Data_out_FC_32) ,.Data_out_FC_33(Data_out_FC_33) ,.Data_out_FC_34(Data_out_FC_34) ,.Data_out_FC_35(Data_out_FC_35) ,.Data_out_FC_36(Data_out_FC_36) ,.Data_out_FC_37(Data_out_FC_37) ,.Data_out_FC_38(Data_out_FC_38) ,.Data_out_FC_39(Data_out_FC_39) ,.Data_out_FC_40(Data_out_FC_40) ,.Data_out_FC_41(Data_out_FC_41) ,.Data_out_FC_42(Data_out_FC_42) ,.Data_out_FC_43(Data_out_FC_43) ,.Data_out_FC_44(Data_out_FC_44) ,.Data_out_FC_45(Data_out_FC_45) ,.Data_out_FC_46(Data_out_FC_46) ,.Data_out_FC_47(Data_out_FC_47) ,.Data_out_FC_48(Data_out_FC_48) ,.Data_out_FC_49(Data_out_FC_49) ,.Data_out_FC_50(Data_out_FC_50) ,.Data_out_FC_51(Data_out_FC_51) ,.Data_out_FC_52(Data_out_FC_52) ,.Data_out_FC_53(Data_out_FC_53) ,.Data_out_FC_54(Data_out_FC_54) ,.Data_out_FC_55(Data_out_FC_55) ,.Data_out_FC_56(Data_out_FC_56) ,.Data_out_FC_57(Data_out_FC_57) ,.Data_out_FC_58(Data_out_FC_58) ,.Data_out_FC_59(Data_out_FC_59) ,.Data_out_FC_60(Data_out_FC_60) ,.Data_out_FC_61(Data_out_FC_61) ,.Data_out_FC_62(Data_out_FC_62) ,.Data_out_FC_63(Data_out_FC_63) ,.Data_out_FC_64(Data_out_FC_64) ,.Data_out_FC_65(Data_out_FC_65) ,.Data_out_FC_66(Data_out_FC_66) ,.Data_out_FC_67(Data_out_FC_67) ,.Data_out_FC_68(Data_out_FC_68) ,.Data_out_FC_69(Data_out_FC_69) ,.Data_out_FC_70(Data_out_FC_70) ,.Data_out_FC_71(Data_out_FC_71) ,.Data_out_FC_72(Data_out_FC_72) ,.Data_out_FC_73(Data_out_FC_73) ,.Data_out_FC_74(Data_out_FC_74) ,.Data_out_FC_75(Data_out_FC_75) ,.Data_out_FC_76(Data_out_FC_76) ,.Data_out_FC_77(Data_out_FC_77) ,.Data_out_FC_78(Data_out_FC_78) ,.Data_out_FC_79(Data_out_FC_79) ,.Data_out_FC_80(Data_out_FC_80) ,.Data_out_FC_81(Data_out_FC_81) ,.Data_out_FC_82(Data_out_FC_82) ,.Data_out_FC_83(Data_out_FC_83) ,.Data_out_FC_84(Data_out_FC_84),
    .data_bias_1 (data_bias_1 ),
    .data_bias_2 (data_bias_2 ),
    .data_bias_3 (data_bias_3 ),
    .data_bias_4 (data_bias_4 ),
    .data_bias_5 (data_bias_5 ),
    .data_bias_6 (data_bias_6 ),
    .data_bias_7 (data_bias_7 ),
    .data_bias_8 (data_bias_8 ),
    .data_bias_9 (data_bias_9 ),
    .data_bias_10(data_bias_10),
    .data_bias_11(data_bias_11),
    .data_bias_12(data_bias_12),
    .data_bias_13(data_bias_13),
    .data_bias_14(data_bias_14),
    .data_bias_15(data_bias_15),
    .data_bias_16(data_bias_16),
    .data_bias_17(data_bias_17),
    .data_bias_18(data_bias_18),
    .data_bias_19(data_bias_19),
    .data_bias_20(data_bias_20),
    .data_bias_21(data_bias_21),
    .data_bias_22(data_bias_22),
    .data_bias_23(data_bias_23),
    .data_bias_24(data_bias_24),
    .data_bias_25(data_bias_25),
    .data_bias_26(data_bias_26),
    .data_bias_27(data_bias_27),
    .data_bias_28(data_bias_28),
    .data_bias_29(data_bias_29),
    .data_bias_30(data_bias_30),
    .data_bias_31(data_bias_31),
    .data_bias_32(data_bias_32),
    .data_bias_33(data_bias_33),
    .data_bias_34(data_bias_34),
    .data_bias_35(data_bias_35),
    .data_bias_36(data_bias_36),
    .data_bias_37(data_bias_37),
    .data_bias_38(data_bias_38),
    .data_bias_39(data_bias_39),
    .data_bias_40(data_bias_40),
    .data_bias_41(data_bias_41),
    .data_bias_42(data_bias_42),
    .data_bias_43(data_bias_43),
    .data_bias_44(data_bias_44),
    .data_bias_45(data_bias_45),
    .data_bias_46(data_bias_46),
    .data_bias_47(data_bias_47),
    .data_bias_48(data_bias_48),
    .data_bias_49(data_bias_49),
    .data_bias_50(data_bias_50),
    .data_bias_51(data_bias_51),
    .data_bias_52(data_bias_52),
    .data_bias_53(data_bias_53),
    .data_bias_54(data_bias_54),
    .data_bias_55(data_bias_55),
    .data_bias_56(data_bias_56),
    .data_bias_57(data_bias_57),
    .data_bias_58(data_bias_58),
    .data_bias_59(data_bias_59),
    .data_bias_60(data_bias_60),
    .data_bias_61(data_bias_61),
    .data_bias_62(data_bias_62),
    .data_bias_63(data_bias_63),
    .data_bias_64(data_bias_64),
    .data_bias_65(data_bias_65),
    .data_bias_66(data_bias_66),
    .data_bias_67(data_bias_67),
    .data_bias_68(data_bias_68),
    .data_bias_69(data_bias_69),
    .data_bias_70(data_bias_70),
    .data_bias_71(data_bias_71),
    .data_bias_72(data_bias_72),
    .data_bias_73(data_bias_73),
    .data_bias_74(data_bias_74),
    .data_bias_75(data_bias_75),
    .data_bias_76(data_bias_76),
    .data_bias_77(data_bias_77),
    .data_bias_78(data_bias_78),
    .data_bias_79(data_bias_79),
    .data_bias_80(data_bias_80),
    .data_bias_81(data_bias_81),
    .data_bias_82(data_bias_82),
    .data_bias_83(data_bias_83),
    .data_bias_84(data_bias_84)
    );

endmodule
