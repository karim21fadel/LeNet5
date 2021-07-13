`timescale 1ns / 1ps


module Fully_Connected #(parameter ARITH_TYPE = 1, DATA_WIDTH          = 32,
                             ADDRESS_BUS         = 19,
                             ADDRESS_ENABLE_BITS = 8,
                             ADDRESS_BITS        = 11,
							 
                             ////////////////////////////////////
                             IFM_DEPTH             = 120,
                             IFM_SIZE              = 1,
                             ADDRESS_SIZE_WM         = $clog2(IFM_DEPTH),      
                             NUMBER_OF_WM            = 84
                                                  )
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
    input [DATA_WIDTH-1:0] Data_Weight_11,
    input [DATA_WIDTH-1:0] Data_Weight_12,
    input [DATA_WIDTH-1:0] Data_Weight_13,
    input [DATA_WIDTH-1:0] Data_Weight_14,
    input [DATA_WIDTH-1:0] Data_Weight_15,
    input [DATA_WIDTH-1:0] Data_Weight_16,
    input [DATA_WIDTH-1:0] Data_Weight_17,
    input [DATA_WIDTH-1:0] Data_Weight_18,
    input [DATA_WIDTH-1:0] Data_Weight_19,
    input [DATA_WIDTH-1:0] Data_Weight_20,
    input [DATA_WIDTH-1:0] Data_Weight_21,
    input [DATA_WIDTH-1:0] Data_Weight_22,
    input [DATA_WIDTH-1:0] Data_Weight_23,
    input [DATA_WIDTH-1:0] Data_Weight_24,
    input [DATA_WIDTH-1:0] Data_Weight_25,
    input [DATA_WIDTH-1:0] Data_Weight_26,
    input [DATA_WIDTH-1:0] Data_Weight_27,
    input [DATA_WIDTH-1:0] Data_Weight_28,
    input [DATA_WIDTH-1:0] Data_Weight_29,
    input [DATA_WIDTH-1:0] Data_Weight_30,
    input [DATA_WIDTH-1:0] Data_Weight_31,
    input [DATA_WIDTH-1:0] Data_Weight_32,
    input [DATA_WIDTH-1:0] Data_Weight_33,
    input [DATA_WIDTH-1:0] Data_Weight_34,
    input [DATA_WIDTH-1:0] Data_Weight_35,
    input [DATA_WIDTH-1:0] Data_Weight_36,
    input [DATA_WIDTH-1:0] Data_Weight_37,
    input [DATA_WIDTH-1:0] Data_Weight_38,
    input [DATA_WIDTH-1:0] Data_Weight_39,
    input [DATA_WIDTH-1:0] Data_Weight_40,
    input [DATA_WIDTH-1:0] Data_Weight_41,
    input [DATA_WIDTH-1:0] Data_Weight_42,
    input [DATA_WIDTH-1:0] Data_Weight_43,
    input [DATA_WIDTH-1:0] Data_Weight_44,
    input [DATA_WIDTH-1:0] Data_Weight_45,
    input [DATA_WIDTH-1:0] Data_Weight_46,
    input [DATA_WIDTH-1:0] Data_Weight_47,
    input [DATA_WIDTH-1:0] Data_Weight_48,
    input [DATA_WIDTH-1:0] Data_Weight_49,
    input [DATA_WIDTH-1:0] Data_Weight_50,
    input [DATA_WIDTH-1:0] Data_Weight_51,
    input [DATA_WIDTH-1:0] Data_Weight_52,
    input [DATA_WIDTH-1:0] Data_Weight_53,
    input [DATA_WIDTH-1:0] Data_Weight_54,
    input [DATA_WIDTH-1:0] Data_Weight_55,
    input [DATA_WIDTH-1:0] Data_Weight_56,
    input [DATA_WIDTH-1:0] Data_Weight_57,
    input [DATA_WIDTH-1:0] Data_Weight_58,
    input [DATA_WIDTH-1:0] Data_Weight_59,
    input [DATA_WIDTH-1:0] Data_Weight_60,
    input [DATA_WIDTH-1:0] Data_Weight_61,
    input [DATA_WIDTH-1:0] Data_Weight_62,
    input [DATA_WIDTH-1:0] Data_Weight_63,
    input [DATA_WIDTH-1:0] Data_Weight_64,
    input [DATA_WIDTH-1:0] Data_Weight_65,
    input [DATA_WIDTH-1:0] Data_Weight_66,
    input [DATA_WIDTH-1:0] Data_Weight_67,
    input [DATA_WIDTH-1:0] Data_Weight_68,
    input [DATA_WIDTH-1:0] Data_Weight_69,
    input [DATA_WIDTH-1:0] Data_Weight_70,
    input [DATA_WIDTH-1:0] Data_Weight_71,
    input [DATA_WIDTH-1:0] Data_Weight_72,
    input [DATA_WIDTH-1:0] Data_Weight_73,
    input [DATA_WIDTH-1:0] Data_Weight_74,
    input [DATA_WIDTH-1:0] Data_Weight_75,
    input [DATA_WIDTH-1:0] Data_Weight_76,
    input [DATA_WIDTH-1:0] Data_Weight_77,
    input [DATA_WIDTH-1:0] Data_Weight_78,
    input [DATA_WIDTH-1:0] Data_Weight_79,
    input [DATA_WIDTH-1:0] Data_Weight_80,
    input [DATA_WIDTH-1:0] Data_Weight_81,
    input [DATA_WIDTH-1:0] Data_Weight_82,
    input [DATA_WIDTH-1:0] Data_Weight_83,
    input [DATA_WIDTH-1:0] Data_Weight_84,
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
    output [DATA_WIDTH-1:0] Data_out_FC_84
    );
    
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M1 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_1),.FP_out(Data_out_FC_1));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M2 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_2),.FP_out(Data_out_FC_2));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M3 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_3),.FP_out(Data_out_FC_3));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M4 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_4),.FP_out(Data_out_FC_4));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M5 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_5),.FP_out(Data_out_FC_5));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M6 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_6),.FP_out(Data_out_FC_6));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M7 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_7),.FP_out(Data_out_FC_7));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M8 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_8),.FP_out(Data_out_FC_8));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M9 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_9),.FP_out(Data_out_FC_9));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M10 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_10),.FP_out(Data_out_FC_10));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M11 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_11),.FP_out(Data_out_FC_11));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M12 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_12),.FP_out(Data_out_FC_12));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M13 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_13),.FP_out(Data_out_FC_13));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M14 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_14),.FP_out(Data_out_FC_14));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M15 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_15),.FP_out(Data_out_FC_15));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M16 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_16),.FP_out(Data_out_FC_16));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M17 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_17),.FP_out(Data_out_FC_17));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M18 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_18),.FP_out(Data_out_FC_18));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M19 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_19),.FP_out(Data_out_FC_19));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M20 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_20),.FP_out(Data_out_FC_20));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M21 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_21),.FP_out(Data_out_FC_21));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M22 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_22),.FP_out(Data_out_FC_22));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M23 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_23),.FP_out(Data_out_FC_23));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M24 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_24),.FP_out(Data_out_FC_24));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M25 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_25),.FP_out(Data_out_FC_25));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M26 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_26),.FP_out(Data_out_FC_26));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M27 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_27),.FP_out(Data_out_FC_27));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M28 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_28),.FP_out(Data_out_FC_28));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M29 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_29),.FP_out(Data_out_FC_29));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M30 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_30),.FP_out(Data_out_FC_30));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M31 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_31),.FP_out(Data_out_FC_31));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M32 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_32),.FP_out(Data_out_FC_32));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M33 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_33),.FP_out(Data_out_FC_33));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M34 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_34),.FP_out(Data_out_FC_34));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M35 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_35),.FP_out(Data_out_FC_35));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M36 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_36),.FP_out(Data_out_FC_36));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M37 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_37),.FP_out(Data_out_FC_37));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M38 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_38),.FP_out(Data_out_FC_38));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M39 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_39),.FP_out(Data_out_FC_39));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M40 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_40),.FP_out(Data_out_FC_40));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M41 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_41),.FP_out(Data_out_FC_41));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M42 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_42),.FP_out(Data_out_FC_42));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M43 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_43),.FP_out(Data_out_FC_43));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M44 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_44),.FP_out(Data_out_FC_44));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M45 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_45),.FP_out(Data_out_FC_45));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M46 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_46),.FP_out(Data_out_FC_46));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M47 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_47),.FP_out(Data_out_FC_47));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M48 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_48),.FP_out(Data_out_FC_48));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M49 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_49),.FP_out(Data_out_FC_49));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M50 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_50),.FP_out(Data_out_FC_50));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M51 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_51),.FP_out(Data_out_FC_51));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M52 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_52),.FP_out(Data_out_FC_52));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M53 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_53),.FP_out(Data_out_FC_53));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M54 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_54),.FP_out(Data_out_FC_54));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M55 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_55),.FP_out(Data_out_FC_55));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M56 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_56),.FP_out(Data_out_FC_56));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M57 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_57),.FP_out(Data_out_FC_57));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M58 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_58),.FP_out(Data_out_FC_58));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M59 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_59),.FP_out(Data_out_FC_59));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M60 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_60),.FP_out(Data_out_FC_60));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M61 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_61),.FP_out(Data_out_FC_61));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M62 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_62),.FP_out(Data_out_FC_62));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M63 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_63),.FP_out(Data_out_FC_63));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M64 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_64),.FP_out(Data_out_FC_64));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M65 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_65),.FP_out(Data_out_FC_65));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M66 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_66),.FP_out(Data_out_FC_66));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M67 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_67),.FP_out(Data_out_FC_67));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M68 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_68),.FP_out(Data_out_FC_68));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M69 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_69),.FP_out(Data_out_FC_69));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M70 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_70),.FP_out(Data_out_FC_70));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M71 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_71),.FP_out(Data_out_FC_71));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M72 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_72),.FP_out(Data_out_FC_72));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M73 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_73),.FP_out(Data_out_FC_73));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M74 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_74),.FP_out(Data_out_FC_74));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M75 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_75),.FP_out(Data_out_FC_75));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M76 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_76),.FP_out(Data_out_FC_76));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M77 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_77),.FP_out(Data_out_FC_77));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M78 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_78),.FP_out(Data_out_FC_78));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M79 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_79),.FP_out(Data_out_FC_79));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M80 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_80),.FP_out(Data_out_FC_80));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M81 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_81),.FP_out(Data_out_FC_81));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M82 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_82),.FP_out(Data_out_FC_82));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M83 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_83),.FP_out(Data_out_FC_83));
    Multiplier #(.DATA_WIDTH(DATA_WIDTH) , .ARITH_TYPE(ARITH_TYPE)) M84 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_84),.FP_out(Data_out_FC_84));
endmodule
