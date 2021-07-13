`timescale 1ns / 1ps


module  FC1_DP #(parameter ARITH_TYPE = 1, DATA_WIDTH       = 32,
                               ADDRESS_BITS     = 15,
                               ////////////////////////////////////
                               IFM_DEPTH        = 120,
                               IFM_SIZE         = 1,
                               ADDRESS_SIZE_WM  = $clog2(IFM_DEPTH),      
                               NUMBER_OF_WM     = 84
                               )
(
    input clk,
	input reset,
	/////////////////////////////////////////////////////
	input    [DATA_WIDTH-1:0] riscv_data,
	input    [ADDRESS_BITS-1:0] riscv_address,
	/////////////////////////////////////////////////////
    input    wm_addr_sel,
    input    wm_enable_read,
    input    [NUMBER_OF_WM - 1:0]    wm_enable_write,
	input    [ADDRESS_SIZE_WM-1:0]   wm_address_read_current,
    /////////////////////////////////////////////////////
    input bm_enable_write,
	 /////////////////////////////////////////////////////
	input fc_output_ready,
	input [DATA_WIDTH-1:0] data_in_from_previous,
	 /////////////////////////////////////////////////////
	output reg  [DATA_WIDTH-1:0] reg_out_FC_1,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_2,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_3,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_4,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_5,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_6,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_7,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_8,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_9,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_10,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_11,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_12,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_13,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_14,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_15,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_16,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_17,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_18,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_19,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_20,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_21,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_22,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_23,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_24,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_25,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_26,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_27,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_28,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_29,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_30,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_31,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_32,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_33,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_34,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_35,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_36,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_37,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_38,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_39,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_40,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_41,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_42,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_43,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_44,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_45,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_46,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_47,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_48,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_49,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_50,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_51,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_52,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_53,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_54,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_55,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_56,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_57,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_58,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_59,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_60,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_61,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_62,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_63,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_64,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_65,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_66,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_67,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_68,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_69,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_70,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_71,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_72,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_73,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_74,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_75,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_76,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_77,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_78,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_79,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_80,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_81,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_82,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_83,
    output reg  [DATA_WIDTH-1:0] reg_out_FC_84,
    output      [DATA_WIDTH-1:0] data_bias_1   ,
    output      [DATA_WIDTH-1:0] data_bias_2   ,
    output      [DATA_WIDTH-1:0] data_bias_3   ,
    output      [DATA_WIDTH-1:0] data_bias_4   ,
    output      [DATA_WIDTH-1:0] data_bias_5   ,
    output      [DATA_WIDTH-1:0] data_bias_6   ,
    output      [DATA_WIDTH-1:0] data_bias_7   ,
    output      [DATA_WIDTH-1:0] data_bias_8   ,
    output      [DATA_WIDTH-1:0] data_bias_9   ,
    output      [DATA_WIDTH-1:0] data_bias_10  ,
    output      [DATA_WIDTH-1:0] data_bias_11  ,
    output      [DATA_WIDTH-1:0] data_bias_12  ,
    output      [DATA_WIDTH-1:0] data_bias_13  ,
    output      [DATA_WIDTH-1:0] data_bias_14  ,
    output      [DATA_WIDTH-1:0] data_bias_15  ,
    output      [DATA_WIDTH-1:0] data_bias_16  ,
    output      [DATA_WIDTH-1:0] data_bias_17  ,
    output      [DATA_WIDTH-1:0] data_bias_18  ,
    output      [DATA_WIDTH-1:0] data_bias_19  ,
    output      [DATA_WIDTH-1:0] data_bias_20  ,
    output      [DATA_WIDTH-1:0] data_bias_21  ,
    output      [DATA_WIDTH-1:0] data_bias_22  ,
    output      [DATA_WIDTH-1:0] data_bias_23   ,
    output      [DATA_WIDTH-1:0] data_bias_24   ,
    output      [DATA_WIDTH-1:0] data_bias_25   ,
    output      [DATA_WIDTH-1:0] data_bias_26   ,
    output      [DATA_WIDTH-1:0] data_bias_27   ,
    output      [DATA_WIDTH-1:0] data_bias_28   ,
    output      [DATA_WIDTH-1:0] data_bias_29   ,
    output      [DATA_WIDTH-1:0] data_bias_30   ,
    output      [DATA_WIDTH-1:0] data_bias_31   ,
    output      [DATA_WIDTH-1:0] data_bias_32   ,
    output      [DATA_WIDTH-1:0] data_bias_33   ,
    output      [DATA_WIDTH-1:0] data_bias_34   ,
    output      [DATA_WIDTH-1:0] data_bias_35   ,
    output      [DATA_WIDTH-1:0] data_bias_36   ,
    output      [DATA_WIDTH-1:0] data_bias_37   ,
    output      [DATA_WIDTH-1:0] data_bias_38   ,
    output      [DATA_WIDTH-1:0] data_bias_39   ,
    output      [DATA_WIDTH-1:0] data_bias_40   ,
    output      [DATA_WIDTH-1:0] data_bias_41   ,
    output      [DATA_WIDTH-1:0] data_bias_42   ,
    output      [DATA_WIDTH-1:0] data_bias_43   ,
    output      [DATA_WIDTH-1:0] data_bias_44   ,
    output      [DATA_WIDTH-1:0] data_bias_45   ,
    output      [DATA_WIDTH-1:0] data_bias_46   ,
    output      [DATA_WIDTH-1:0] data_bias_47   ,
    output      [DATA_WIDTH-1:0] data_bias_48   ,
    output      [DATA_WIDTH-1:0] data_bias_49   ,
    output      [DATA_WIDTH-1:0] data_bias_50   ,
    output      [DATA_WIDTH-1:0] data_bias_51   ,
    output      [DATA_WIDTH-1:0] data_bias_52   ,
    output      [DATA_WIDTH-1:0] data_bias_53   ,
    output      [DATA_WIDTH-1:0] data_bias_54   ,
    output      [DATA_WIDTH-1:0] data_bias_55   ,
    output      [DATA_WIDTH-1:0] data_bias_56   ,
    output      [DATA_WIDTH-1:0] data_bias_57   ,
    output      [DATA_WIDTH-1:0] data_bias_58   ,
    output      [DATA_WIDTH-1:0] data_bias_59   ,
    output      [DATA_WIDTH-1:0] data_bias_60   ,
    output      [DATA_WIDTH-1:0] data_bias_61   ,
    output      [DATA_WIDTH-1:0] data_bias_62   ,
    output      [DATA_WIDTH-1:0] data_bias_63   ,
    output      [DATA_WIDTH-1:0] data_bias_64   ,
    output      [DATA_WIDTH-1:0] data_bias_65   ,
    output      [DATA_WIDTH-1:0] data_bias_66   ,
    output      [DATA_WIDTH-1:0] data_bias_67   ,
    output      [DATA_WIDTH-1:0] data_bias_68   ,
    output      [DATA_WIDTH-1:0] data_bias_69   ,
    output      [DATA_WIDTH-1:0] data_bias_70   ,
    output      [DATA_WIDTH-1:0] data_bias_71   ,
    output      [DATA_WIDTH-1:0] data_bias_72   ,
    output      [DATA_WIDTH-1:0] data_bias_73   ,
    output      [DATA_WIDTH-1:0] data_bias_74   ,
    output      [DATA_WIDTH-1:0] data_bias_75   ,
    output      [DATA_WIDTH-1:0] data_bias_76   ,
    output      [DATA_WIDTH-1:0] data_bias_77   ,
    output      [DATA_WIDTH-1:0] data_bias_78   ,
    output      [DATA_WIDTH-1:0] data_bias_79   ,
    output      [DATA_WIDTH-1:0] data_bias_80   ,
    output      [DATA_WIDTH-1:0] data_bias_81   ,
    output      [DATA_WIDTH-1:0] data_bias_82   ,
    output      [DATA_WIDTH-1:0] data_bias_83   ,
    output      [DATA_WIDTH-1:0] data_bias_84
    );
    
    wire [DATA_WIDTH-1:0] s_Data_out_FC_1;    
    wire [DATA_WIDTH-1:0] s_Data_out_FC_2;    
    wire [DATA_WIDTH-1:0] s_Data_out_FC_3;    
    wire [DATA_WIDTH-1:0] s_Data_out_FC_4;    
    wire [DATA_WIDTH-1:0] s_Data_out_FC_5;    
    wire [DATA_WIDTH-1:0] s_Data_out_FC_6;    
    wire [DATA_WIDTH-1:0] s_Data_out_FC_7;    
    wire [DATA_WIDTH-1:0] s_Data_out_FC_8;    
    wire [DATA_WIDTH-1:0] s_Data_out_FC_9;    
    wire [DATA_WIDTH-1:0] s_Data_out_FC_10;   
    wire [DATA_WIDTH-1:0] s_Data_out_FC_11;   
    wire [DATA_WIDTH-1:0] s_Data_out_FC_12;   
    wire [DATA_WIDTH-1:0] s_Data_out_FC_13;   
    wire [DATA_WIDTH-1:0] s_Data_out_FC_14;   
    wire [DATA_WIDTH-1:0] s_Data_out_FC_15;   
    wire [DATA_WIDTH-1:0] s_Data_out_FC_16;   
    wire [DATA_WIDTH-1:0] s_Data_out_FC_17;   
    wire [DATA_WIDTH-1:0] s_Data_out_FC_18;   
    wire [DATA_WIDTH-1:0] s_Data_out_FC_19;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_20;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_21;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_22;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_23;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_24;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_25;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_26;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_27;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_28;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_29;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_30;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_31;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_32;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_33;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_34;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_35;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_36;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_37;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_38;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_39;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_40;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_41;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_42;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_43;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_44;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_45;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_46;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_47;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_48;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_49;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_50;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_51;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_52;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_53;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_54;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_55;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_56;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_57;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_58;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_59;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_60;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_61;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_62;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_63;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_64;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_65;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_66;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_67;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_68;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_69;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_70;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_71;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_72;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_73;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_74;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_75;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_76;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_77;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_78;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_79;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_80;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_81;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_82;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_83;
    wire [DATA_WIDTH-1:0] s_Data_out_FC_84;
    
    
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
    wire [DATA_WIDTH-1:0] Data_Weight_11;
    wire [DATA_WIDTH-1:0] Data_Weight_12;
    wire [DATA_WIDTH-1:0] Data_Weight_13;
    wire [DATA_WIDTH-1:0] Data_Weight_14;
    wire [DATA_WIDTH-1:0] Data_Weight_15;
    wire [DATA_WIDTH-1:0] Data_Weight_16;
    wire [DATA_WIDTH-1:0] Data_Weight_17;
    wire [DATA_WIDTH-1:0] Data_Weight_18;
    wire [DATA_WIDTH-1:0] Data_Weight_19;
    wire [DATA_WIDTH-1:0] Data_Weight_20;
    wire [DATA_WIDTH-1:0] Data_Weight_21;
    wire [DATA_WIDTH-1:0] Data_Weight_22;
    wire [DATA_WIDTH-1:0] Data_Weight_23;
    wire [DATA_WIDTH-1:0] Data_Weight_24;
    wire [DATA_WIDTH-1:0] Data_Weight_25;
    wire [DATA_WIDTH-1:0] Data_Weight_26;
    wire [DATA_WIDTH-1:0] Data_Weight_27;
    wire [DATA_WIDTH-1:0] Data_Weight_28;
    wire [DATA_WIDTH-1:0] Data_Weight_29;
    wire [DATA_WIDTH-1:0] Data_Weight_30;
    wire [DATA_WIDTH-1:0] Data_Weight_31;
    wire [DATA_WIDTH-1:0] Data_Weight_32;
    wire [DATA_WIDTH-1:0] Data_Weight_33;
    wire [DATA_WIDTH-1:0] Data_Weight_34;
    wire [DATA_WIDTH-1:0] Data_Weight_35;
    wire [DATA_WIDTH-1:0] Data_Weight_36;
    wire [DATA_WIDTH-1:0] Data_Weight_37;
    wire [DATA_WIDTH-1:0] Data_Weight_38;
    wire [DATA_WIDTH-1:0] Data_Weight_39;
    wire [DATA_WIDTH-1:0] Data_Weight_40;
    wire [DATA_WIDTH-1:0] Data_Weight_41;
    wire [DATA_WIDTH-1:0] Data_Weight_42;
    wire [DATA_WIDTH-1:0] Data_Weight_43;
    wire [DATA_WIDTH-1:0] Data_Weight_44;
    wire [DATA_WIDTH-1:0] Data_Weight_45;
    wire [DATA_WIDTH-1:0] Data_Weight_46;
    wire [DATA_WIDTH-1:0] Data_Weight_47;
    wire [DATA_WIDTH-1:0] Data_Weight_48;
    wire [DATA_WIDTH-1:0] Data_Weight_49;
    wire [DATA_WIDTH-1:0] Data_Weight_50;
    wire [DATA_WIDTH-1:0] Data_Weight_51;
    wire [DATA_WIDTH-1:0] Data_Weight_52;
    wire [DATA_WIDTH-1:0] Data_Weight_53;
    wire [DATA_WIDTH-1:0] Data_Weight_54;
    wire [DATA_WIDTH-1:0] Data_Weight_55;
    wire [DATA_WIDTH-1:0] Data_Weight_56;
    wire [DATA_WIDTH-1:0] Data_Weight_57;
    wire [DATA_WIDTH-1:0] Data_Weight_58;
    wire [DATA_WIDTH-1:0] Data_Weight_59;
    wire [DATA_WIDTH-1:0] Data_Weight_60;
    wire [DATA_WIDTH-1:0] Data_Weight_61;
    wire [DATA_WIDTH-1:0] Data_Weight_62;
    wire [DATA_WIDTH-1:0] Data_Weight_63;
    wire [DATA_WIDTH-1:0] Data_Weight_64;
    wire [DATA_WIDTH-1:0] Data_Weight_65;
    wire [DATA_WIDTH-1:0] Data_Weight_66;
    wire [DATA_WIDTH-1:0] Data_Weight_67;
    wire [DATA_WIDTH-1:0] Data_Weight_68;
    wire [DATA_WIDTH-1:0] Data_Weight_69;
    wire [DATA_WIDTH-1:0] Data_Weight_70;
    wire [DATA_WIDTH-1:0] Data_Weight_71;
    wire [DATA_WIDTH-1:0] Data_Weight_72;
    wire [DATA_WIDTH-1:0] Data_Weight_73;
    wire [DATA_WIDTH-1:0] Data_Weight_74;
    wire [DATA_WIDTH-1:0] Data_Weight_75;
    wire [DATA_WIDTH-1:0] Data_Weight_76;
    wire [DATA_WIDTH-1:0] Data_Weight_77;
    wire [DATA_WIDTH-1:0] Data_Weight_78;
    wire [DATA_WIDTH-1:0] Data_Weight_79;
    wire [DATA_WIDTH-1:0] Data_Weight_80;
    wire [DATA_WIDTH-1:0] Data_Weight_81;
    wire [DATA_WIDTH-1:0] Data_Weight_82;
    wire [DATA_WIDTH-1:0] Data_Weight_83;
    wire [DATA_WIDTH-1:0] Data_Weight_84;
    
    
    
    wire [ADDRESS_SIZE_WM-1:0] wm_address;
    
    assign wm_address = wm_addr_sel ? wm_address_read_current : riscv_address[ADDRESS_SIZE_WM-1:0];
    
    	
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
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W11(.clk(clk),.Enable_Write(wm_enable_write[10]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_11));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W12(.clk(clk),.Enable_Write(wm_enable_write[11]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_12));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W13(.clk(clk),.Enable_Write(wm_enable_write[12]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_13));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W14(.clk(clk),.Enable_Write(wm_enable_write[13]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_14));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W15(.clk(clk),.Enable_Write(wm_enable_write[14]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_15));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W16(.clk(clk),.Enable_Write(wm_enable_write[15]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_16));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W17(.clk(clk),.Enable_Write(wm_enable_write[16]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_17));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W18(.clk(clk),.Enable_Write(wm_enable_write[17]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_18));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W19(.clk(clk),.Enable_Write(wm_enable_write[18]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_19));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W20(.clk(clk),.Enable_Write(wm_enable_write[19]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_20));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W21(.clk(clk),.Enable_Write(wm_enable_write[20]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_21));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W22(.clk(clk),.Enable_Write(wm_enable_write[21]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_22));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W23(.clk(clk),.Enable_Write(wm_enable_write[22]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_23));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W24(.clk(clk),.Enable_Write(wm_enable_write[23]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_24));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W25(.clk(clk),.Enable_Write(wm_enable_write[24]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_25));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W26(.clk(clk),.Enable_Write(wm_enable_write[25]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_26));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W27(.clk(clk),.Enable_Write(wm_enable_write[26]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_27));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W28(.clk(clk),.Enable_Write(wm_enable_write[27]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_28));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W29(.clk(clk),.Enable_Write(wm_enable_write[28]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_29));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W30(.clk(clk),.Enable_Write(wm_enable_write[29]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_30));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W31(.clk(clk),.Enable_Write(wm_enable_write[30]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_31));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W32(.clk(clk),.Enable_Write(wm_enable_write[31]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_32));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W33(.clk(clk),.Enable_Write(wm_enable_write[32]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_33));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W34(.clk(clk),.Enable_Write(wm_enable_write[33]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_34));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W35(.clk(clk),.Enable_Write(wm_enable_write[34]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_35));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W36(.clk(clk),.Enable_Write(wm_enable_write[35]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_36));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W37(.clk(clk),.Enable_Write(wm_enable_write[36]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_37));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W38(.clk(clk),.Enable_Write(wm_enable_write[37]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_38));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W39(.clk(clk),.Enable_Write(wm_enable_write[38]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_39));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W40(.clk(clk),.Enable_Write(wm_enable_write[39]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_40));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W41(.clk(clk),.Enable_Write(wm_enable_write[40]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_41));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W42(.clk(clk),.Enable_Write(wm_enable_write[41]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_42));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W43(.clk(clk),.Enable_Write(wm_enable_write[42]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_43));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W44(.clk(clk),.Enable_Write(wm_enable_write[43]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_44));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W45(.clk(clk),.Enable_Write(wm_enable_write[44]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_45));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W46(.clk(clk),.Enable_Write(wm_enable_write[45]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_46));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W47(.clk(clk),.Enable_Write(wm_enable_write[46]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_47));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W48(.clk(clk),.Enable_Write(wm_enable_write[47]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_48));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W49(.clk(clk),.Enable_Write(wm_enable_write[48]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_49));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W50(.clk(clk),.Enable_Write(wm_enable_write[49]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_50));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W51(.clk(clk),.Enable_Write(wm_enable_write[50]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_51));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W52(.clk(clk),.Enable_Write(wm_enable_write[51]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_52));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W53(.clk(clk),.Enable_Write(wm_enable_write[52]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_53));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W54(.clk(clk),.Enable_Write(wm_enable_write[53]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_54));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W55(.clk(clk),.Enable_Write(wm_enable_write[54]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_55));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W56(.clk(clk),.Enable_Write(wm_enable_write[55]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_56));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W57(.clk(clk),.Enable_Write(wm_enable_write[56]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_57));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W58(.clk(clk),.Enable_Write(wm_enable_write[57]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_58));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W59(.clk(clk),.Enable_Write(wm_enable_write[58]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_59));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W60(.clk(clk),.Enable_Write(wm_enable_write[59]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_60));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W61(.clk(clk),.Enable_Write(wm_enable_write[60]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_61));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W62(.clk(clk),.Enable_Write(wm_enable_write[61]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_62));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W63(.clk(clk),.Enable_Write(wm_enable_write[62]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_63));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W64(.clk(clk),.Enable_Write(wm_enable_write[63]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_64));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W65(.clk(clk),.Enable_Write(wm_enable_write[64]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_65));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W66(.clk(clk),.Enable_Write(wm_enable_write[65]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_66));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W67(.clk(clk),.Enable_Write(wm_enable_write[66]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_67));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W68(.clk(clk),.Enable_Write(wm_enable_write[67]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_68));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W69(.clk(clk),.Enable_Write(wm_enable_write[68]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_69));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W70(.clk(clk),.Enable_Write(wm_enable_write[69]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_70));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W71(.clk(clk),.Enable_Write(wm_enable_write[70]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_71));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W72(.clk(clk),.Enable_Write(wm_enable_write[71]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_72));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W73(.clk(clk),.Enable_Write(wm_enable_write[72]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_73));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W74(.clk(clk),.Enable_Write(wm_enable_write[73]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_74));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W75(.clk(clk),.Enable_Write(wm_enable_write[74]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_75));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W76(.clk(clk),.Enable_Write(wm_enable_write[75]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_76));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W77(.clk(clk),.Enable_Write(wm_enable_write[76]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_77));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W78(.clk(clk),.Enable_Write(wm_enable_write[77]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_78));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W79(.clk(clk),.Enable_Write(wm_enable_write[78]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_79));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W80(.clk(clk),.Enable_Write(wm_enable_write[79]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_80));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W81(.clk(clk),.Enable_Write(wm_enable_write[80]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_81));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W82(.clk(clk),.Enable_Write(wm_enable_write[81]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_82));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W83(.clk(clk),.Enable_Write(wm_enable_write[82]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_83));
    SinglePort_Memory  #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_DEPTH)) W84(.clk(clk),.Enable_Write(wm_enable_write[83]),.Enable_Read(wm_enable_read),.Address(wm_address),.Data_Input(riscv_data),.Data_Output(Data_Weight_84));
    
    FIFO_84outputs_FC1 #(.DATA_WIDTH(DATA_WIDTH))
    FIFO1 
    (
       .clk(clk), 
       .fifo_data_in(riscv_data), 
       .fifo_enable(bm_enable_write),
       .fifo_data_out_1 (data_bias_1 ),
       .fifo_data_out_2 (data_bias_2 ),
       .fifo_data_out_3 (data_bias_3 ),
       .fifo_data_out_4 (data_bias_4 ),
       .fifo_data_out_5 (data_bias_5 ),
       .fifo_data_out_6 (data_bias_6 ),
       .fifo_data_out_7 (data_bias_7 ),
       .fifo_data_out_8 (data_bias_8 ),
       .fifo_data_out_9 (data_bias_9 ),
       .fifo_data_out_10(data_bias_10),
       .fifo_data_out_11(data_bias_11),
       .fifo_data_out_12(data_bias_12),
       .fifo_data_out_13(data_bias_13),
       .fifo_data_out_14(data_bias_14),
       .fifo_data_out_15(data_bias_15),
       .fifo_data_out_16(data_bias_16),
       .fifo_data_out_17(data_bias_17),
       .fifo_data_out_18(data_bias_18),
       .fifo_data_out_19(data_bias_19),
       .fifo_data_out_20(data_bias_20),
       .fifo_data_out_21(data_bias_21),
       .fifo_data_out_22(data_bias_22),
       .fifo_data_out_23(data_bias_23),
       .fifo_data_out_24(data_bias_24),
       .fifo_data_out_25(data_bias_25),
       .fifo_data_out_26(data_bias_26),
       .fifo_data_out_27(data_bias_27),
       .fifo_data_out_28(data_bias_28),
       .fifo_data_out_29(data_bias_29),
       .fifo_data_out_30(data_bias_30),
       .fifo_data_out_31(data_bias_31),
       .fifo_data_out_32(data_bias_32),
       .fifo_data_out_33(data_bias_33),
       .fifo_data_out_34(data_bias_34),
       .fifo_data_out_35(data_bias_35),
       .fifo_data_out_36(data_bias_36),
       .fifo_data_out_37(data_bias_37),
       .fifo_data_out_38(data_bias_38),
       .fifo_data_out_39(data_bias_39),
       .fifo_data_out_40(data_bias_40),
       .fifo_data_out_41(data_bias_41),
       .fifo_data_out_42(data_bias_42),
       .fifo_data_out_43(data_bias_43),
       .fifo_data_out_44(data_bias_44),
       .fifo_data_out_45(data_bias_45),
       .fifo_data_out_46(data_bias_46),
       .fifo_data_out_47(data_bias_47),
       .fifo_data_out_48(data_bias_48),
       .fifo_data_out_49(data_bias_49),
       .fifo_data_out_50(data_bias_50),
       .fifo_data_out_51(data_bias_51),
       .fifo_data_out_52(data_bias_52),
       .fifo_data_out_53(data_bias_53),
       .fifo_data_out_54(data_bias_54),
       .fifo_data_out_55(data_bias_55),
       .fifo_data_out_56(data_bias_56),
       .fifo_data_out_57(data_bias_57),
       .fifo_data_out_58(data_bias_58),
       .fifo_data_out_59(data_bias_59),
       .fifo_data_out_60(data_bias_60),
       .fifo_data_out_61(data_bias_61),
       .fifo_data_out_62(data_bias_62),
       .fifo_data_out_63(data_bias_63),
       .fifo_data_out_64(data_bias_64),
       .fifo_data_out_65(data_bias_65),
       .fifo_data_out_66(data_bias_66),
       .fifo_data_out_67(data_bias_67),
       .fifo_data_out_68(data_bias_68),
       .fifo_data_out_69(data_bias_69),
       .fifo_data_out_70(data_bias_70),
       .fifo_data_out_71(data_bias_71),
       .fifo_data_out_72(data_bias_72),
       .fifo_data_out_73(data_bias_73),
       .fifo_data_out_74(data_bias_74),
       .fifo_data_out_75(data_bias_75),
       .fifo_data_out_76(data_bias_76),
       .fifo_data_out_77(data_bias_77),
       .fifo_data_out_78(data_bias_78),
       .fifo_data_out_79(data_bias_79),
       .fifo_data_out_80(data_bias_80),
       .fifo_data_out_81(data_bias_81),
       .fifo_data_out_82(data_bias_82),
       .fifo_data_out_83(data_bias_83),
       .fifo_data_out_84(data_bias_84)
       );

  Fully_Connected #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) 
  F1 (.Data_in(data_in_from_previous),.Data_Weight_1(Data_Weight_1) ,.Data_Weight_2(Data_Weight_2) ,.Data_Weight_3(Data_Weight_3) ,.Data_Weight_4(Data_Weight_4) ,.Data_Weight_5(Data_Weight_5) ,.Data_Weight_6(Data_Weight_6) ,.Data_Weight_7(Data_Weight_7) ,.Data_Weight_8(Data_Weight_8) ,.Data_Weight_9(Data_Weight_9) ,.Data_Weight_10(Data_Weight_10) ,.Data_Weight_11(Data_Weight_11) ,.Data_Weight_12(Data_Weight_12) ,.Data_Weight_13(Data_Weight_13) ,.Data_Weight_14(Data_Weight_14) ,.Data_Weight_15(Data_Weight_15) ,.Data_Weight_16(Data_Weight_16) ,.Data_Weight_17(Data_Weight_17) ,.Data_Weight_18(Data_Weight_18) ,.Data_Weight_19(Data_Weight_19) ,.Data_Weight_20(Data_Weight_20) ,.Data_Weight_21(Data_Weight_21) ,.Data_Weight_22(Data_Weight_22) ,.Data_Weight_23(Data_Weight_23) ,.Data_Weight_24(Data_Weight_24) ,.Data_Weight_25(Data_Weight_25) ,.Data_Weight_26(Data_Weight_26) ,.Data_Weight_27(Data_Weight_27) ,.Data_Weight_28(Data_Weight_28) ,.Data_Weight_29(Data_Weight_29) ,.Data_Weight_30(Data_Weight_30) ,.Data_Weight_31(Data_Weight_31) ,.Data_Weight_32(Data_Weight_32) ,.Data_Weight_33(Data_Weight_33) ,.Data_Weight_34(Data_Weight_34) ,.Data_Weight_35(Data_Weight_35) ,.Data_Weight_36(Data_Weight_36) ,.Data_Weight_37(Data_Weight_37) ,.Data_Weight_38(Data_Weight_38) ,.Data_Weight_39(Data_Weight_39) ,.Data_Weight_40(Data_Weight_40) ,.Data_Weight_41(Data_Weight_41) ,.Data_Weight_42(Data_Weight_42) ,.Data_Weight_43(Data_Weight_43) ,.Data_Weight_44(Data_Weight_44) ,.Data_Weight_45(Data_Weight_45) ,.Data_Weight_46(Data_Weight_46) ,.Data_Weight_47(Data_Weight_47) ,.Data_Weight_48(Data_Weight_48) ,.Data_Weight_49(Data_Weight_49) ,.Data_Weight_50(Data_Weight_50) ,.Data_Weight_51(Data_Weight_51) ,.Data_Weight_52(Data_Weight_52) ,.Data_Weight_53(Data_Weight_53) ,.Data_Weight_54(Data_Weight_54) ,.Data_Weight_55(Data_Weight_55) ,.Data_Weight_56(Data_Weight_56) ,.Data_Weight_57(Data_Weight_57) ,.Data_Weight_58(Data_Weight_58) ,.Data_Weight_59(Data_Weight_59) ,.Data_Weight_60(Data_Weight_60) ,.Data_Weight_61(Data_Weight_61) ,.Data_Weight_62(Data_Weight_62) ,.Data_Weight_63(Data_Weight_63) ,.Data_Weight_64(Data_Weight_64) ,.Data_Weight_65(Data_Weight_65) ,.Data_Weight_66(Data_Weight_66) ,.Data_Weight_67(Data_Weight_67) ,.Data_Weight_68(Data_Weight_68) ,.Data_Weight_69(Data_Weight_69) ,.Data_Weight_70(Data_Weight_70) ,.Data_Weight_71(Data_Weight_71) ,.Data_Weight_72(Data_Weight_72) ,.Data_Weight_73(Data_Weight_73) ,.Data_Weight_74(Data_Weight_74) ,.Data_Weight_75(Data_Weight_75) ,.Data_Weight_76(Data_Weight_76) ,.Data_Weight_77(Data_Weight_77) ,.Data_Weight_78(Data_Weight_78) ,.Data_Weight_79(Data_Weight_79) ,.Data_Weight_80(Data_Weight_80) ,.Data_Weight_81(Data_Weight_81) ,.Data_Weight_82(Data_Weight_82) ,.Data_Weight_83(Data_Weight_83) ,.Data_Weight_84(Data_Weight_84),.Data_out_FC_1(s_Data_out_FC_1) ,.Data_out_FC_2(s_Data_out_FC_2) ,.Data_out_FC_3(s_Data_out_FC_3) ,.Data_out_FC_4(s_Data_out_FC_4) ,.Data_out_FC_5(s_Data_out_FC_5) ,.Data_out_FC_6(s_Data_out_FC_6) ,.Data_out_FC_7(s_Data_out_FC_7) ,.Data_out_FC_8(s_Data_out_FC_8) ,.Data_out_FC_9(s_Data_out_FC_9) ,.Data_out_FC_10(s_Data_out_FC_10) ,.Data_out_FC_11(s_Data_out_FC_11) ,.Data_out_FC_12(s_Data_out_FC_12) ,.Data_out_FC_13(s_Data_out_FC_13) ,.Data_out_FC_14(s_Data_out_FC_14) ,.Data_out_FC_15(s_Data_out_FC_15) ,.Data_out_FC_16(s_Data_out_FC_16) ,.Data_out_FC_17(s_Data_out_FC_17) ,.Data_out_FC_18(s_Data_out_FC_18) ,.Data_out_FC_19(s_Data_out_FC_19) ,.Data_out_FC_20(s_Data_out_FC_20) ,.Data_out_FC_21(s_Data_out_FC_21) ,.Data_out_FC_22(s_Data_out_FC_22) ,.Data_out_FC_23(s_Data_out_FC_23) ,.Data_out_FC_24(s_Data_out_FC_24) ,.Data_out_FC_25(s_Data_out_FC_25) ,.Data_out_FC_26(s_Data_out_FC_26) ,.Data_out_FC_27(s_Data_out_FC_27) ,.Data_out_FC_28(s_Data_out_FC_28) ,.Data_out_FC_29(s_Data_out_FC_29) ,.Data_out_FC_30(s_Data_out_FC_30) ,.Data_out_FC_31(s_Data_out_FC_31) ,.Data_out_FC_32(s_Data_out_FC_32) ,.Data_out_FC_33(s_Data_out_FC_33) ,.Data_out_FC_34(s_Data_out_FC_34) ,.Data_out_FC_35(s_Data_out_FC_35) ,.Data_out_FC_36(s_Data_out_FC_36) ,.Data_out_FC_37(s_Data_out_FC_37) ,.Data_out_FC_38(s_Data_out_FC_38) ,.Data_out_FC_39(s_Data_out_FC_39) ,.Data_out_FC_40(s_Data_out_FC_40) ,.Data_out_FC_41(s_Data_out_FC_41) ,.Data_out_FC_42(s_Data_out_FC_42) ,.Data_out_FC_43(s_Data_out_FC_43) ,.Data_out_FC_44(s_Data_out_FC_44) ,.Data_out_FC_45(s_Data_out_FC_45) ,.Data_out_FC_46(s_Data_out_FC_46) ,.Data_out_FC_47(s_Data_out_FC_47) ,.Data_out_FC_48(s_Data_out_FC_48) ,.Data_out_FC_49(s_Data_out_FC_49) ,.Data_out_FC_50(s_Data_out_FC_50) ,.Data_out_FC_51(s_Data_out_FC_51) ,.Data_out_FC_52(s_Data_out_FC_52) ,.Data_out_FC_53(s_Data_out_FC_53) ,.Data_out_FC_54(s_Data_out_FC_54) ,.Data_out_FC_55(s_Data_out_FC_55) ,.Data_out_FC_56(s_Data_out_FC_56) ,.Data_out_FC_57(s_Data_out_FC_57) ,.Data_out_FC_58(s_Data_out_FC_58) ,.Data_out_FC_59(s_Data_out_FC_59) ,.Data_out_FC_60(s_Data_out_FC_60) ,.Data_out_FC_61(s_Data_out_FC_61) ,.Data_out_FC_62(s_Data_out_FC_62) ,.Data_out_FC_63(s_Data_out_FC_63) ,.Data_out_FC_64(s_Data_out_FC_64) ,.Data_out_FC_65(s_Data_out_FC_65) ,.Data_out_FC_66(s_Data_out_FC_66) ,.Data_out_FC_67(s_Data_out_FC_67) ,.Data_out_FC_68(s_Data_out_FC_68) ,.Data_out_FC_69(s_Data_out_FC_69) ,.Data_out_FC_70(s_Data_out_FC_70) ,.Data_out_FC_71(s_Data_out_FC_71) ,.Data_out_FC_72(s_Data_out_FC_72) ,.Data_out_FC_73(s_Data_out_FC_73) ,.Data_out_FC_74(s_Data_out_FC_74) ,.Data_out_FC_75(s_Data_out_FC_75) ,.Data_out_FC_76(s_Data_out_FC_76) ,.Data_out_FC_77(s_Data_out_FC_77) ,.Data_out_FC_78(s_Data_out_FC_78) ,.Data_out_FC_79(s_Data_out_FC_79) ,.Data_out_FC_80(s_Data_out_FC_80) ,.Data_out_FC_81(s_Data_out_FC_81) ,.Data_out_FC_82(s_Data_out_FC_82) ,.Data_out_FC_83(s_Data_out_FC_83) ,.Data_out_FC_84(s_Data_out_FC_84));
     
   always @ (posedge clk , posedge reset )
        begin 
         if (reset)
           begin 
           reg_out_FC_1  <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_2  <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_3  <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_4  <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_5  <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_6  <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_7  <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_8  <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_9  <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_10 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_11 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_12 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_13 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_14 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_15 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_16 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_17 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_18 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_19 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_20 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_21 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_22 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_23 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_24 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_25 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_26 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_27 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_28 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_29 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_30 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_31 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_32 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_33 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_34 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_35 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_36 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_37 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_38 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_39 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_40 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_41 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_42 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_43 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_44 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_45 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_46 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_47 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_48 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_49 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_50 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_51 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_52 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_53 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_54 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_55 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_56 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_57 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_58 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_59 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_60 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_61 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_62 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_63 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_64 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_65 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_66 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_67 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_68 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_69 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_70 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_71 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_72 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_73 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_74 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_75 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_76 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_77 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_78 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_79 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_80 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_81 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_82 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_83 <= {DATA_WIDTH{1'b0}} ;
           reg_out_FC_84 <= {DATA_WIDTH{1'b0}} ;       
           end
         else if (fc_output_ready )
            begin 
            reg_out_FC_1  <=s_Data_out_FC_1   ;
            reg_out_FC_2  <=s_Data_out_FC_2   ;
            reg_out_FC_3  <=s_Data_out_FC_3   ;
            reg_out_FC_4  <=s_Data_out_FC_4   ;
            reg_out_FC_5  <=s_Data_out_FC_5   ;
            reg_out_FC_6  <=s_Data_out_FC_6   ;
            reg_out_FC_7  <=s_Data_out_FC_7   ;
            reg_out_FC_8  <=s_Data_out_FC_8   ;
            reg_out_FC_9  <=s_Data_out_FC_9   ;
            reg_out_FC_10 <=s_Data_out_FC_10  ;
            reg_out_FC_11 <=s_Data_out_FC_11  ;
            reg_out_FC_12 <=s_Data_out_FC_12  ;
            reg_out_FC_13 <=s_Data_out_FC_13  ;
            reg_out_FC_14 <=s_Data_out_FC_14  ;
            reg_out_FC_15 <=s_Data_out_FC_15  ;
            reg_out_FC_16 <=s_Data_out_FC_16  ;
            reg_out_FC_17 <=s_Data_out_FC_17  ;
            reg_out_FC_18 <=s_Data_out_FC_18  ;
            reg_out_FC_19 <=s_Data_out_FC_19  ;
            reg_out_FC_20 <=s_Data_out_FC_20  ;
            reg_out_FC_21 <=s_Data_out_FC_21  ;
            reg_out_FC_22 <=s_Data_out_FC_22  ;
            reg_out_FC_23 <=s_Data_out_FC_23  ;
            reg_out_FC_24 <=s_Data_out_FC_24  ;
            reg_out_FC_25 <=s_Data_out_FC_25  ;
            reg_out_FC_26 <=s_Data_out_FC_26  ;
            reg_out_FC_27 <=s_Data_out_FC_27  ;
            reg_out_FC_28 <=s_Data_out_FC_28  ;
            reg_out_FC_29 <=s_Data_out_FC_29  ;
            reg_out_FC_30 <=s_Data_out_FC_30  ;
            reg_out_FC_31 <=s_Data_out_FC_31  ;
            reg_out_FC_32 <=s_Data_out_FC_32  ;
            reg_out_FC_33 <=s_Data_out_FC_33  ;
            reg_out_FC_34 <=s_Data_out_FC_34  ;
            reg_out_FC_35 <=s_Data_out_FC_35  ;
            reg_out_FC_36 <=s_Data_out_FC_36  ;
            reg_out_FC_37 <=s_Data_out_FC_37  ;
            reg_out_FC_38 <=s_Data_out_FC_38  ;
            reg_out_FC_39 <=s_Data_out_FC_39  ;
            reg_out_FC_40 <=s_Data_out_FC_40  ;
            reg_out_FC_41 <=s_Data_out_FC_41  ;
            reg_out_FC_42 <=s_Data_out_FC_42  ;
            reg_out_FC_43 <=s_Data_out_FC_43  ;
            reg_out_FC_44 <=s_Data_out_FC_44  ;
            reg_out_FC_45 <=s_Data_out_FC_45  ;
            reg_out_FC_46 <=s_Data_out_FC_46  ;
            reg_out_FC_47 <=s_Data_out_FC_47  ;
            reg_out_FC_48 <=s_Data_out_FC_48  ;
            reg_out_FC_49 <=s_Data_out_FC_49  ;
            reg_out_FC_50 <=s_Data_out_FC_50  ;
            reg_out_FC_51 <=s_Data_out_FC_51  ;
            reg_out_FC_52 <=s_Data_out_FC_52  ;
            reg_out_FC_53 <=s_Data_out_FC_53  ;
            reg_out_FC_54 <=s_Data_out_FC_54  ;
            reg_out_FC_55 <=s_Data_out_FC_55  ;
            reg_out_FC_56 <=s_Data_out_FC_56  ;
            reg_out_FC_57 <=s_Data_out_FC_57  ;
            reg_out_FC_58 <=s_Data_out_FC_58  ;
            reg_out_FC_59 <=s_Data_out_FC_59  ;
            reg_out_FC_60 <=s_Data_out_FC_60  ;
            reg_out_FC_61 <=s_Data_out_FC_61  ;
            reg_out_FC_62 <=s_Data_out_FC_62  ;
            reg_out_FC_63 <=s_Data_out_FC_63  ;
            reg_out_FC_64 <=s_Data_out_FC_64  ;
            reg_out_FC_65 <=s_Data_out_FC_65  ;
            reg_out_FC_66 <=s_Data_out_FC_66  ;
            reg_out_FC_67 <=s_Data_out_FC_67  ;
            reg_out_FC_68 <=s_Data_out_FC_68  ;
            reg_out_FC_69 <=s_Data_out_FC_69  ;
            reg_out_FC_70 <=s_Data_out_FC_70  ;
            reg_out_FC_71 <=s_Data_out_FC_71  ;
            reg_out_FC_72 <=s_Data_out_FC_72  ;
            reg_out_FC_73 <=s_Data_out_FC_73  ;
            reg_out_FC_74 <=s_Data_out_FC_74  ;
            reg_out_FC_75 <=s_Data_out_FC_75  ;
            reg_out_FC_76 <=s_Data_out_FC_76  ;
            reg_out_FC_77 <=s_Data_out_FC_77  ;
            reg_out_FC_78 <=s_Data_out_FC_78  ;
            reg_out_FC_79 <=s_Data_out_FC_79  ;
            reg_out_FC_80 <=s_Data_out_FC_80  ;
            reg_out_FC_81 <=s_Data_out_FC_81  ;
            reg_out_FC_82 <=s_Data_out_FC_82  ;
            reg_out_FC_83 <=s_Data_out_FC_83  ;
            reg_out_FC_84 <=s_Data_out_FC_84  ;
           end
        end
		
    
endmodule     