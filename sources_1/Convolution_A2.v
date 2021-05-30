`timescale 1ns / 1ps

module Convolution_A2 #(parameter DATA_WIDTH          = 32,
                             ADDRESS_BITS        = 15,
                             /////////////////////////////////////
	                         IFM_SIZE              = 14,                                                
                             IFM_DEPTH             = 3,
							 KERNAL_SIZE           = 5,
		                     NUMBER_OF_FILTERS     = 2,
							 NUMBER_OF_UNITS       = 3,
		                     //////////////////////////////////////
							 IFM_SIZE_NEXT           = IFM_SIZE - KERNAL_SIZE + 1,
                             ADDRESS_SIZE_IFM        = $clog2(IFM_SIZE*IFM_SIZE),
                             ADDRESS_SIZE_NEXT_IFM   = $clog2(IFM_SIZE_NEXT*IFM_SIZE_NEXT),
                             ADDRESS_SIZE_WM         = $clog2( KERNAL_SIZE*KERNAL_SIZE*NUMBER_OF_FILTERS*(IFM_DEPTH/NUMBER_OF_UNITS+1) ),      
                             FIFO_SIZE               = (KERNAL_SIZE-1)*IFM_SIZE + KERNAL_SIZE,
                             NUMBER_OF_IFM           = IFM_DEPTH,
                             NUMBER_OF_IFM_NEXT      = NUMBER_OF_FILTERS,
                             NUMBER_OF_WM            = KERNAL_SIZE*KERNAL_SIZE,                              
                             NUMBER_OF_BITS_SEL_IFM_NEXT =$clog2(NUMBER_OF_IFM_NEXT))
    (
    input   wire                            clk,
    input   wire                            reset,
    input   wire                            conv_enable,
    input   wire    [DATA_WIDTH - 1 : 0]    w1,if1,
    input   wire    [DATA_WIDTH - 1 : 0]    w2,if2,
    input   wire    [DATA_WIDTH - 1 : 0]    w3,if3,
    input   wire    [DATA_WIDTH - 1 : 0]    w4,if4,
    input   wire    [DATA_WIDTH - 1 : 0]    w5,if5,
    input   wire    [DATA_WIDTH - 1 : 0]    w6,if6,
    input   wire    [DATA_WIDTH - 1 : 0]    w7,if7,
    input   wire    [DATA_WIDTH - 1 : 0]    w8,if8,
    input   wire    [DATA_WIDTH - 1 : 0]    w9,if9,
    input   wire    [DATA_WIDTH - 1 : 0]    w10,if10,
    input   wire    [DATA_WIDTH - 1 : 0]    w11,if11,
    input   wire    [DATA_WIDTH - 1 : 0]    w12,if12,
    input   wire    [DATA_WIDTH - 1 : 0]    w13,if13,
    input   wire    [DATA_WIDTH - 1 : 0]    w14,if14,
    input   wire    [DATA_WIDTH - 1 : 0]    w15,if15,
    input   wire    [DATA_WIDTH - 1 : 0]    w16,if16,
    input   wire    [DATA_WIDTH - 1 : 0]    w17,if17,
    input   wire    [DATA_WIDTH - 1 : 0]    w18,if18,
    input   wire    [DATA_WIDTH - 1 : 0]    w19,if19,
    input   wire    [DATA_WIDTH - 1 : 0]    w20,if20,
    input   wire    [DATA_WIDTH - 1 : 0]    w21,if21,
    input   wire    [DATA_WIDTH - 1 : 0]    w22,if22,
    input   wire    [DATA_WIDTH - 1 : 0]    w23,if23,
    input   wire    [DATA_WIDTH - 1 : 0]    w24,if24,
    input   wire    [DATA_WIDTH - 1 : 0]    w25,if25,
    output  wire    [DATA_WIDTH - 1 : 0]    conv_data_out  
    );
    
    wire    [DATA_WIDTH - 1 : 0]     mul_out_1,mul_out_2,mul_out_3,mul_out_4,mul_out_5,mul_out_6,mul_out_7,mul_out_8,mul_out_9,mul_out_10;
    wire    [DATA_WIDTH - 1 : 0]     mul_out_11,mul_out_12,mul_out_13,mul_out_14,mul_out_15,mul_out_16,mul_out_17,mul_out_18,mul_out_19,mul_out_20;
    wire    [DATA_WIDTH - 1 : 0]     mul_out_21,mul_out_22,mul_out_23,mul_out_24,mul_out_25;
    
    reg     [DATA_WIDTH - 1 : 0]     reg_mul_out_1,reg_mul_out_2,reg_mul_out_3,reg_mul_out_4,reg_mul_out_5,reg_mul_out_6,reg_mul_out_7,reg_mul_out_8,reg_mul_out_9,reg_mul_out_10;
    reg     [DATA_WIDTH - 1 : 0]     reg_mul_out_11,reg_mul_out_12,reg_mul_out_13,reg_mul_out_14,reg_mul_out_15,reg_mul_out_16,reg_mul_out_17,reg_mul_out_18,reg_mul_out_19,reg_mul_out_20;
    reg     [DATA_WIDTH - 1 : 0]     reg_mul_out_21,reg_mul_out_22,reg_mul_out_23,reg_mul_out_24,reg_mul_out_25;
    
    wire	[DATA_WIDTH - 1 : 0]	adder_out_12_1;
    reg		[DATA_WIDTH - 1 : 0]	reg_adder_out_12_1;
    wire	[DATA_WIDTH - 1 : 0]	adder_out_12_2;
    reg		[DATA_WIDTH - 1 : 0]	reg_adder_out_12_2;
    wire	[DATA_WIDTH - 1 : 0]	adder_out_12_3;
    reg		[DATA_WIDTH - 1 : 0]	reg_adder_out_12_3;
    wire	[DATA_WIDTH - 1 : 0]	adder_out_12_4;
    reg		[DATA_WIDTH - 1 : 0]	reg_adder_out_12_4;
    wire	[DATA_WIDTH - 1 : 0]	adder_out_12_5;
    reg		[DATA_WIDTH - 1 : 0]	reg_adder_out_12_5;
    wire	[DATA_WIDTH - 1 : 0]	adder_out_12_6;
    reg		[DATA_WIDTH - 1 : 0]	reg_adder_out_12_6;
    wire	[DATA_WIDTH - 1 : 0]	adder_out_12_7;
    reg		[DATA_WIDTH - 1 : 0]	reg_adder_out_12_7;
    wire	[DATA_WIDTH - 1 : 0]	adder_out_12_8;
    reg		[DATA_WIDTH - 1 : 0]	reg_adder_out_12_8;
    wire	[DATA_WIDTH - 1 : 0]	adder_out_12_9;
    reg		[DATA_WIDTH - 1 : 0]	reg_adder_out_12_9;
    wire	[DATA_WIDTH - 1 : 0]	adder_out_12_10;
    reg		[DATA_WIDTH - 1 : 0]	reg_adder_out_12_10;
    wire	[DATA_WIDTH - 1 : 0]	adder_out_12_11;
    reg		[DATA_WIDTH - 1 : 0]	reg_adder_out_12_11;
    wire	[DATA_WIDTH - 1 : 0]	adder_out_12_12;
    reg		[DATA_WIDTH - 1 : 0]	reg_adder_out_12_12;

    
    wire	[DATA_WIDTH - 1 : 0]	adder_out_3_1;
    reg		[DATA_WIDTH - 1 : 0]	reg_adder_out_3_1;
    wire	[DATA_WIDTH - 1 : 0]	adder_out_3_2;
    reg		[DATA_WIDTH - 1 : 0]	reg_adder_out_3_2;
    wire	[DATA_WIDTH - 1 : 0]	adder_out_3_3;
    reg		[DATA_WIDTH - 1 : 0]	reg_adder_out_3_3;
    wire	[DATA_WIDTH - 1 : 0]	adder_out_3_4;
    reg		[DATA_WIDTH - 1 : 0]	reg_adder_out_3_4;
    wire	[DATA_WIDTH - 1 : 0]	adder_out_3_5;
    reg		[DATA_WIDTH - 1 : 0]	reg_adder_out_3_5;
    wire	[DATA_WIDTH - 1 : 0]	adder_out_3_6;
    reg		[DATA_WIDTH - 1 : 0]	reg_adder_out_3_6;

    wire	[DATA_WIDTH - 1 : 0]	adder_out_4_1;
    reg		[DATA_WIDTH - 1 : 0]	reg_adder_out_4_1;
    wire	[DATA_WIDTH - 1 : 0]	adder_out_4_2;
    reg		[DATA_WIDTH - 1 : 0]	reg_adder_out_4_2;
    wire	[DATA_WIDTH - 1 : 0]	adder_out_4_3;
    reg		[DATA_WIDTH - 1 : 0]	reg_adder_out_4_3;

    wire	[DATA_WIDTH - 1 : 0]	adder_out_5_1;
    reg		[DATA_WIDTH - 1 : 0]	reg_adder_out_5_1;
    wire	[DATA_WIDTH - 1 : 0]	adder_out_5_2;
    reg		[DATA_WIDTH - 1 : 0]	reg_adder_out_5_2;

    wire	[DATA_WIDTH - 1 : 0]	adder_out_1_1;
    reg		[DATA_WIDTH - 1 : 0]	reg_adder_out_1_1;
    
    wire	[DATA_WIDTH - 1 : 0]	adder_out_4_4_Delay_Out;
    reg		[DATA_WIDTH - 1 : 0]	reg_adder_out_4_4_Delay_Out;
        
    always @(posedge clk , posedge reset)
    if (reset)
    begin
        reg_mul_out_1 <= 0;
        reg_mul_out_2 <= 0;
        reg_mul_out_3 <= 0;
        reg_mul_out_4 <= 0;
        reg_mul_out_5 <= 0;
        reg_mul_out_6 <= 0;
        reg_mul_out_7 <= 0;
        reg_mul_out_8 <= 0;
        reg_mul_out_9 <= 0;
        reg_mul_out_10 <= 0;
        reg_mul_out_11 <= 0;
        reg_mul_out_12 <= 0;
        reg_mul_out_13 <= 0;
        reg_mul_out_14 <= 0;
        reg_mul_out_15 <= 0;
        reg_mul_out_16 <= 0;
        reg_mul_out_17 <= 0;
        reg_mul_out_18 <= 0;
        reg_mul_out_19 <= 0;
        reg_mul_out_20 <= 0;
        reg_mul_out_21 <= 0;
        reg_mul_out_22 <= 0;
        reg_mul_out_23 <= 0;
        reg_mul_out_24 <= 0;
        reg_mul_out_25 <= 0;
    end
    
    else if(conv_enable)
    begin
        reg_mul_out_1 <= mul_out_1 ;
        reg_mul_out_2 <= mul_out_2 ;
        reg_mul_out_3 <= mul_out_3 ;
        reg_mul_out_4 <= mul_out_4 ;
        reg_mul_out_5 <= mul_out_5 ;
        reg_mul_out_6 <= mul_out_6 ;
        reg_mul_out_7 <= mul_out_7 ;
        reg_mul_out_8 <= mul_out_8 ;
        reg_mul_out_9 <= mul_out_9 ;
        reg_mul_out_10 <= mul_out_10 ;
        reg_mul_out_11 <= mul_out_11 ;
        reg_mul_out_12 <= mul_out_12 ;
        reg_mul_out_13 <= mul_out_13 ;
        reg_mul_out_14 <= mul_out_14 ;
        reg_mul_out_15 <= mul_out_15 ;
        reg_mul_out_16 <= mul_out_16 ;
        reg_mul_out_17 <= mul_out_17 ;
        reg_mul_out_18 <= mul_out_18 ;
        reg_mul_out_19 <= mul_out_19 ;
        reg_mul_out_20 <= mul_out_20 ;
        reg_mul_out_21 <= mul_out_21 ;
        reg_mul_out_22 <= mul_out_22 ;
        reg_mul_out_23 <= mul_out_23 ;
        reg_mul_out_24 <= mul_out_24 ;
        reg_mul_out_25 <= mul_out_25 ;             
    end
    
    always @(posedge clk, posedge reset)
    begin
        if(reset)
        begin
            reg_adder_out_12_1 <= 0;
            reg_adder_out_12_2 <= 0;
            reg_adder_out_12_3 <= 0;
            reg_adder_out_12_4 <= 0;
            reg_adder_out_12_5 <= 0;
            reg_adder_out_12_6 <= 0;
            reg_adder_out_12_7 <= 0;
            reg_adder_out_12_8 <= 0;
            reg_adder_out_12_9 <= 0;
            reg_adder_out_12_10 <= 0;
            reg_adder_out_12_11 <= 0;
            reg_adder_out_12_12 <= 0;
            
            
            reg_adder_out_3_1 <= 0;
            reg_adder_out_3_2 <= 0;
            reg_adder_out_3_3 <= 0;
            reg_adder_out_3_4 <= 0;
            reg_adder_out_3_5 <= 0;
            reg_adder_out_3_6 <= 0;
    
            reg_adder_out_4_1 <= 0;
            reg_adder_out_4_2 <= 0;
            reg_adder_out_4_3 <= 0;
            
            reg_adder_out_5_1 <= 0;
            reg_adder_out_5_2 <= 0;
                            
            reg_adder_out_1_1 <= 0;
        end
        
        else
        begin
            reg_adder_out_12_1 <= adder_out_12_1;
            reg_adder_out_12_2 <= adder_out_12_2;
            reg_adder_out_12_3 <= adder_out_12_3;
            reg_adder_out_12_4 <= adder_out_12_4;
            reg_adder_out_12_5 <= adder_out_12_5;
            reg_adder_out_12_6 <= adder_out_12_6;
            reg_adder_out_12_7 <= adder_out_12_7;
            reg_adder_out_12_8 <= adder_out_12_8;
            reg_adder_out_12_9 <= adder_out_12_9;
            reg_adder_out_12_10 <= adder_out_12_10;
            reg_adder_out_12_11 <= adder_out_12_11;
            reg_adder_out_12_12 <= adder_out_12_12;
            
            reg_adder_out_3_1 <= adder_out_3_1;
            reg_adder_out_3_2 <= adder_out_3_2;
            reg_adder_out_3_3 <= adder_out_3_3;
            reg_adder_out_3_4 <= adder_out_3_4;
            reg_adder_out_3_5 <= adder_out_3_5;
            reg_adder_out_3_6 <= adder_out_3_6;
            
            reg_adder_out_4_1 <= adder_out_4_1;
            reg_adder_out_4_2 <= adder_out_4_2;
            reg_adder_out_4_3 <= adder_out_4_3;
            
            reg_adder_out_5_1 <= adder_out_5_1;
            reg_adder_out_5_2 <= adder_out_5_2;
            
            reg_adder_out_1_1 <= adder_out_1_1;
        
            reg_adder_out_4_4_Delay_Out <= adder_out_4_4_Delay_Out;
        end
    end
    
    FP_Multiplier mul_1 (.FP_in1 (w1), .FP_in2 (if1), .FP_out (mul_out_1));
    FP_Multiplier mul_2 (.FP_in1 (w2), .FP_in2 (if2), .FP_out (mul_out_2));
    FP_Multiplier mul_3 (.FP_in1 (w3), .FP_in2 (if3), .FP_out (mul_out_3));
    FP_Multiplier mul_4 (.FP_in1 (w4), .FP_in2 (if4), .FP_out (mul_out_4));
    FP_Multiplier mul_5 (.FP_in1 (w5), .FP_in2 (if5), .FP_out (mul_out_5));
    FP_Multiplier mul_6 (.FP_in1 (w6), .FP_in2 (if6), .FP_out (mul_out_6));
    FP_Multiplier mul_7 (.FP_in1 (w7), .FP_in2 (if7), .FP_out (mul_out_7));
    FP_Multiplier mul_8 (.FP_in1 (w8), .FP_in2 (if8), .FP_out (mul_out_8));
    FP_Multiplier mul_9 (.FP_in1 (w9), .FP_in2 (if9), .FP_out (mul_out_9));
    FP_Multiplier mul_10 (.FP_in1 (w10), .FP_in2 (if10), .FP_out (mul_out_10));
    FP_Multiplier mul_11 (.FP_in1 (w11), .FP_in2 (if11), .FP_out (mul_out_11));
    FP_Multiplier mul_12 (.FP_in1 (w12), .FP_in2 (if12), .FP_out (mul_out_12));
    FP_Multiplier mul_13 (.FP_in1 (w13), .FP_in2 (if13), .FP_out (mul_out_13));
    FP_Multiplier mul_14 (.FP_in1 (w14), .FP_in2 (if14), .FP_out (mul_out_14));
    FP_Multiplier mul_15 (.FP_in1 (w15), .FP_in2 (if15), .FP_out (mul_out_15));
    FP_Multiplier mul_16 (.FP_in1 (w16), .FP_in2 (if16), .FP_out (mul_out_16));
    FP_Multiplier mul_17 (.FP_in1 (w17), .FP_in2 (if17), .FP_out (mul_out_17));
    FP_Multiplier mul_18 (.FP_in1 (w18), .FP_in2 (if18), .FP_out (mul_out_18));
    FP_Multiplier mul_19 (.FP_in1 (w19), .FP_in2 (if19), .FP_out (mul_out_19));
    FP_Multiplier mul_20 (.FP_in1 (w20), .FP_in2 (if20), .FP_out (mul_out_20));
    FP_Multiplier mul_21 (.FP_in1 (w21), .FP_in2 (if21), .FP_out (mul_out_21));
    FP_Multiplier mul_22 (.FP_in1 (w22), .FP_in2 (if22), .FP_out (mul_out_22));
    FP_Multiplier mul_23 (.FP_in1 (w23), .FP_in2 (if23), .FP_out (mul_out_23));
    FP_Multiplier mul_24 (.FP_in1 (w24), .FP_in2 (if24), .FP_out (mul_out_24));
    FP_Multiplier mul_25 (.FP_in1 (w25), .FP_in2 (if25), .FP_out (mul_out_25));
    
    FP_Adder adr_12_1 (.FP_in1 (reg_mul_out_1), .FP_in2 (reg_mul_out_2), .FP_out (adder_out_12_1));
    FP_Adder adr_12_2 (.FP_in1 (reg_mul_out_3), .FP_in2 (reg_mul_out_4), .FP_out (adder_out_12_2));
    FP_Adder adr_12_3 (.FP_in1 (reg_mul_out_5), .FP_in2 (reg_mul_out_6), .FP_out (adder_out_12_3));
    FP_Adder adr_12_4 (.FP_in1 (reg_mul_out_7), .FP_in2 (reg_mul_out_8), .FP_out (adder_out_12_4));
    FP_Adder adr_12_5 (.FP_in1 (reg_mul_out_9), .FP_in2 (reg_mul_out_10), .FP_out (adder_out_12_5));
    FP_Adder adr_12_6 (.FP_in1 (reg_mul_out_11), .FP_in2 (reg_mul_out_12), .FP_out (adder_out_12_6));
    FP_Adder adr_12_7 (.FP_in1 (reg_mul_out_13), .FP_in2 (reg_mul_out_14), .FP_out (adder_out_12_7));
    FP_Adder adr_12_8 (.FP_in1 (reg_mul_out_15), .FP_in2 (reg_mul_out_16), .FP_out (adder_out_12_8));
    FP_Adder adr_12_9 (.FP_in1 (reg_mul_out_17), .FP_in2 (reg_mul_out_18), .FP_out (adder_out_12_9));
    FP_Adder adr_12_10 (.FP_in1 (reg_mul_out_19), .FP_in2 (reg_mul_out_20), .FP_out (adder_out_12_10));
    FP_Adder adr_12_11 (.FP_in1 (reg_mul_out_21), .FP_in2 (reg_mul_out_22), .FP_out (adder_out_12_11));
    FP_Adder adr_12_12 (.FP_in1 (reg_mul_out_23), .FP_in2 (reg_mul_out_24), .FP_out (adder_out_12_12));
    
    //assign adder_out_12_9 = reg_mul_out_25;
    
    FP_Adder adr_6_1 (.FP_in1 (reg_adder_out_12_1), .FP_in2 (reg_adder_out_12_2), .FP_out (adder_out_3_1));
    FP_Adder adr_6_2 (.FP_in1 (reg_adder_out_12_3), .FP_in2 (reg_adder_out_12_4), .FP_out (adder_out_3_2));
    FP_Adder adr_6_3 (.FP_in1 (reg_adder_out_12_5), .FP_in2 (reg_adder_out_12_6), .FP_out (adder_out_3_3));
    FP_Adder adr_6_4 (.FP_in1 (reg_adder_out_12_7), .FP_in2 (reg_adder_out_12_8), .FP_out (adder_out_3_4));
    FP_Adder adr_6_5 (.FP_in1 (reg_adder_out_12_9), .FP_in2 (reg_adder_out_12_10), .FP_out (adder_out_3_5));
    FP_Adder adr_6_6 (.FP_in1 (reg_adder_out_12_11), .FP_in2 (reg_adder_out_12_12), .FP_out (adder_out_3_6));
    
    FP_Adder adr_3_1 (.FP_in1 (reg_adder_out_3_1), .FP_in2 (reg_adder_out_3_2), .FP_out (adder_out_4_1));
    FP_Adder adr_3_2 (.FP_in1 (reg_adder_out_3_3), .FP_in2 (reg_adder_out_3_4), .FP_out (adder_out_4_2));
    FP_Adder adr_3_3 (.FP_in1 (reg_adder_out_3_5), .FP_in2 (reg_adder_out_3_6), .FP_out (adder_out_4_3));
    
    FP_Adder adr_2_1 (.FP_in1 (reg_adder_out_4_1), .FP_in2 (reg_adder_out_4_2), .FP_out (adder_out_5_1));
    FP_Adder adr_2_2 (.FP_in1 (reg_adder_out_4_3), .FP_in2 (reg_adder_out_4_4_Delay_Out), .FP_out (adder_out_5_2));
    
    Delay #(.Delay_Data_Width(DATA_WIDTH), .delay_cycles(2)) d1 (.clk(clk),.reset(reset), .Data_In(reg_mul_out_25), .Data_Out(adder_out_4_4_Delay_Out));
    
    FP_Adder adr_1_1 (.FP_in1 (reg_adder_out_5_1), .FP_in2 (reg_adder_out_5_2), .FP_out (adder_out_1_1));
    
    assign conv_data_out = reg_adder_out_1_1;
    
endmodule

