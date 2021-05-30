`timescale 1ns / 1ps


module Fully_Connected #(parameter DATA_WIDTH          = 32,
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
    FP_Multiplier M11 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_11),.FP_out(Data_out_FC_11));
    FP_Multiplier M12 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_12),.FP_out(Data_out_FC_12));
    FP_Multiplier M13 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_13),.FP_out(Data_out_FC_13));
    FP_Multiplier M14 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_14),.FP_out(Data_out_FC_14));
    FP_Multiplier M15 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_15),.FP_out(Data_out_FC_15));
    FP_Multiplier M16 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_16),.FP_out(Data_out_FC_16));
    FP_Multiplier M17 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_17),.FP_out(Data_out_FC_17));
    FP_Multiplier M18 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_18),.FP_out(Data_out_FC_18));
    FP_Multiplier M19 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_19),.FP_out(Data_out_FC_19));
    FP_Multiplier M20 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_20),.FP_out(Data_out_FC_20));
    FP_Multiplier M21 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_21),.FP_out(Data_out_FC_21));
    FP_Multiplier M22 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_22),.FP_out(Data_out_FC_22));
    FP_Multiplier M23 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_23),.FP_out(Data_out_FC_23));
    FP_Multiplier M24 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_24),.FP_out(Data_out_FC_24));
    FP_Multiplier M25 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_25),.FP_out(Data_out_FC_25));
    FP_Multiplier M26 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_26),.FP_out(Data_out_FC_26));
    FP_Multiplier M27 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_27),.FP_out(Data_out_FC_27));
    FP_Multiplier M28 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_28),.FP_out(Data_out_FC_28));
    FP_Multiplier M29 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_29),.FP_out(Data_out_FC_29));
    FP_Multiplier M30 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_30),.FP_out(Data_out_FC_30));
    FP_Multiplier M31 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_31),.FP_out(Data_out_FC_31));
    FP_Multiplier M32 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_32),.FP_out(Data_out_FC_32));
    FP_Multiplier M33 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_33),.FP_out(Data_out_FC_33));
    FP_Multiplier M34 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_34),.FP_out(Data_out_FC_34));
    FP_Multiplier M35 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_35),.FP_out(Data_out_FC_35));
    FP_Multiplier M36 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_36),.FP_out(Data_out_FC_36));
    FP_Multiplier M37 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_37),.FP_out(Data_out_FC_37));
    FP_Multiplier M38 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_38),.FP_out(Data_out_FC_38));
    FP_Multiplier M39 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_39),.FP_out(Data_out_FC_39));
    FP_Multiplier M40 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_40),.FP_out(Data_out_FC_40));
    FP_Multiplier M41 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_41),.FP_out(Data_out_FC_41));
    FP_Multiplier M42 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_42),.FP_out(Data_out_FC_42));
    FP_Multiplier M43 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_43),.FP_out(Data_out_FC_43));
    FP_Multiplier M44 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_44),.FP_out(Data_out_FC_44));
    FP_Multiplier M45 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_45),.FP_out(Data_out_FC_45));
    FP_Multiplier M46 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_46),.FP_out(Data_out_FC_46));
    FP_Multiplier M47 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_47),.FP_out(Data_out_FC_47));
    FP_Multiplier M48 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_48),.FP_out(Data_out_FC_48));
    FP_Multiplier M49 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_49),.FP_out(Data_out_FC_49));
    FP_Multiplier M50 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_50),.FP_out(Data_out_FC_50));
    FP_Multiplier M51 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_51),.FP_out(Data_out_FC_51));
    FP_Multiplier M52 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_52),.FP_out(Data_out_FC_52));
    FP_Multiplier M53 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_53),.FP_out(Data_out_FC_53));
    FP_Multiplier M54 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_54),.FP_out(Data_out_FC_54));
    FP_Multiplier M55 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_55),.FP_out(Data_out_FC_55));
    FP_Multiplier M56 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_56),.FP_out(Data_out_FC_56));
    FP_Multiplier M57 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_57),.FP_out(Data_out_FC_57));
    FP_Multiplier M58 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_58),.FP_out(Data_out_FC_58));
    FP_Multiplier M59 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_59),.FP_out(Data_out_FC_59));
    FP_Multiplier M60 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_60),.FP_out(Data_out_FC_60));
    FP_Multiplier M61 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_61),.FP_out(Data_out_FC_61));
    FP_Multiplier M62 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_62),.FP_out(Data_out_FC_62));
    FP_Multiplier M63 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_63),.FP_out(Data_out_FC_63));
    FP_Multiplier M64 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_64),.FP_out(Data_out_FC_64));
    FP_Multiplier M65 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_65),.FP_out(Data_out_FC_65));
    FP_Multiplier M66 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_66),.FP_out(Data_out_FC_66));
    FP_Multiplier M67 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_67),.FP_out(Data_out_FC_67));
    FP_Multiplier M68 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_68),.FP_out(Data_out_FC_68));
    FP_Multiplier M69 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_69),.FP_out(Data_out_FC_69));
    FP_Multiplier M70 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_70),.FP_out(Data_out_FC_70));
    FP_Multiplier M71 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_71),.FP_out(Data_out_FC_71));
    FP_Multiplier M72 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_72),.FP_out(Data_out_FC_72));
    FP_Multiplier M73 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_73),.FP_out(Data_out_FC_73));
    FP_Multiplier M74 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_74),.FP_out(Data_out_FC_74));
    FP_Multiplier M75 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_75),.FP_out(Data_out_FC_75));
    FP_Multiplier M76 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_76),.FP_out(Data_out_FC_76));
    FP_Multiplier M77 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_77),.FP_out(Data_out_FC_77));
    FP_Multiplier M78 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_78),.FP_out(Data_out_FC_78));
    FP_Multiplier M79 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_79),.FP_out(Data_out_FC_79));
    FP_Multiplier M80 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_80),.FP_out(Data_out_FC_80));
    FP_Multiplier M81 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_81),.FP_out(Data_out_FC_81));
    FP_Multiplier M82 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_82),.FP_out(Data_out_FC_82));
    FP_Multiplier M83 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_83),.FP_out(Data_out_FC_83));
    FP_Multiplier M84 (.FP_in1 (Data_in) ,.FP_in2 (Data_Weight_84),.FP_out(Data_out_FC_84));
endmodule
