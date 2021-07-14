`timescale 1ns / 1ps



module  FC2_DP  #(parameter ARITH_TYPE = 1, DATA_WIDTH      = 32,
                                ADDRESS_BITS    = 15,
                                ////////////////////////////////////
                                IFM_DEPTH       = 84,
                                IFM_SIZE        = 1,
                                ADDRESS_SIZE_WM = $clog2(IFM_DEPTH),      
                                NUMBER_OF_WM    = 10
                                )
	(
	 input clk,
     input reset,
	 /////////////////////////////////////////////////////
     input [DATA_WIDTH-1:0]   riscv_data,
	 input [ADDRESS_BITS-1:0] riscv_address,
	 /////////////////////////////////////////////////////
	 input wm_addr_sel,
     input wm_enable_read,
     input [NUMBER_OF_WM - 1:0] wm_enable_write,
	 input [ADDRESS_SIZE_WM-1:0] wm_address_read_current,
	 /////////////////////////////////////////////////////
     input bm_enable_write,
	 /////////////////////////////////////////////////////
	 input enable_read_current,
	 input [ ADDRESS_SIZE_WM-1 :  0 ] sel_ifm,
	 
	 input fc_output_ready,
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
  
      output [DATA_WIDTH-1:0]  data_bias_1  ,
      output [DATA_WIDTH-1:0]  data_bias_2  ,
      output [DATA_WIDTH-1:0]  data_bias_3  ,
      output [DATA_WIDTH-1:0]  data_bias_4  ,
      output [DATA_WIDTH-1:0]  data_bias_5  ,
      output [DATA_WIDTH-1:0]  data_bias_6  ,
      output [DATA_WIDTH-1:0]  data_bias_7  ,
      output [DATA_WIDTH-1:0]  data_bias_8  ,
      output [DATA_WIDTH-1:0]  data_bias_9  ,
      output [DATA_WIDTH-1:0]  data_bias_10 ,

     //////////////////////////for next
	 output reg [DATA_WIDTH-1:0] reg_out_FC_1,
     output reg [DATA_WIDTH-1:0] reg_out_FC_2,
     output reg [DATA_WIDTH-1:0] reg_out_FC_3,
     output reg [DATA_WIDTH-1:0] reg_out_FC_4,
     output reg [DATA_WIDTH-1:0] reg_out_FC_5,
     output reg [DATA_WIDTH-1:0] reg_out_FC_6,
     output reg [DATA_WIDTH-1:0] reg_out_FC_7,
     output reg [DATA_WIDTH-1:0] reg_out_FC_8,
     output reg [DATA_WIDTH-1:0] reg_out_FC_9,
     output reg [DATA_WIDTH-1:0] reg_out_FC_10
    );
////////////////////////Signal declaration/////////////////
	wire [DATA_WIDTH - 1 : 0] s_Data_out_FC_1  ;
	wire [DATA_WIDTH - 1 : 0] s_Data_out_FC_2  ;
	wire [DATA_WIDTH - 1 : 0] s_Data_out_FC_3  ;
	wire [DATA_WIDTH - 1 : 0] s_Data_out_FC_4  ;
	wire [DATA_WIDTH - 1 : 0] s_Data_out_FC_5  ;
	wire [DATA_WIDTH - 1 : 0] s_Data_out_FC_6  ;
	wire [DATA_WIDTH - 1 : 0] s_Data_out_FC_7  ;
	wire [DATA_WIDTH - 1 : 0] s_Data_out_FC_8  ;
	wire [DATA_WIDTH - 1 : 0] s_Data_out_FC_9  ;
	wire [DATA_WIDTH - 1 : 0] s_Data_out_FC_10 ;
	
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
	
    reg  [DATA_WIDTH - 1 : 0] Data_Read_mux;
	
	wire [ADDRESS_SIZE_WM-1:0] wm_address;
    assign wm_address = wm_addr_sel ? wm_address_read_current : riscv_address;
	
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

    always @(*)
    begin
        case (sel_ifm)
        7'b0000000 : Data_Read_mux =  Data_in_1 ;
        7'b0000001 : Data_Read_mux =  Data_in_2 ;
        7'b0000010 : Data_Read_mux =  Data_in_3 ;
        7'b0000011 : Data_Read_mux =  Data_in_4 ;
        7'b0000100 : Data_Read_mux =  Data_in_5 ;
        7'b0000101 : Data_Read_mux =  Data_in_6 ;
        7'b0000110 : Data_Read_mux =  Data_in_7 ;
        7'b0000111 : Data_Read_mux =  Data_in_8 ;
        7'b0001000 : Data_Read_mux =  Data_in_9 ;
        7'b0001001 : Data_Read_mux =  Data_in_10;
        7'b0001010 : Data_Read_mux =  Data_in_11;
        7'b0001011 : Data_Read_mux =  Data_in_12;
        7'b0001100 : Data_Read_mux =  Data_in_13;
        7'b0001101 : Data_Read_mux =  Data_in_14;
        7'b0001110 : Data_Read_mux =  Data_in_15;
        7'b0001111 : Data_Read_mux =  Data_in_16;
        7'b0010000 : Data_Read_mux =  Data_in_17;
        7'b0010001 : Data_Read_mux =  Data_in_18;
        7'b0010010 : Data_Read_mux =  Data_in_19;
        7'b0010011 : Data_Read_mux =  Data_in_20;
        7'b0010100 : Data_Read_mux =  Data_in_21;
        7'b0010101 : Data_Read_mux =  Data_in_22;
        7'b0010110 : Data_Read_mux =  Data_in_23;
        7'b0010111 : Data_Read_mux =  Data_in_24;
        7'b0011000 : Data_Read_mux =  Data_in_25;
        7'b0011001 : Data_Read_mux =  Data_in_26;
        7'b0011010 : Data_Read_mux =  Data_in_27;
        7'b0011011 : Data_Read_mux =  Data_in_28;
        7'b0011100 : Data_Read_mux =  Data_in_29;
        7'b0011101 : Data_Read_mux =  Data_in_30;
        7'b0011110 : Data_Read_mux =  Data_in_31;
        7'b0011111 : Data_Read_mux =  Data_in_32;
        7'b0100000 : Data_Read_mux =  Data_in_33;
        7'b0100001 : Data_Read_mux =  Data_in_34;
        7'b0100010 : Data_Read_mux =  Data_in_35;
        7'b0100011 : Data_Read_mux =  Data_in_36;
        7'b0100100 : Data_Read_mux =  Data_in_37;
        7'b0100101 : Data_Read_mux =  Data_in_38;
        7'b0100110 : Data_Read_mux =  Data_in_39;
        7'b0100111 : Data_Read_mux =  Data_in_40;
        7'b0101000 : Data_Read_mux =  Data_in_41;
        7'b0101001 : Data_Read_mux =  Data_in_42;
        7'b0101010 : Data_Read_mux =  Data_in_43;
        7'b0101011 : Data_Read_mux =  Data_in_44;
        7'b0101100 : Data_Read_mux =  Data_in_45;
        7'b0101101 : Data_Read_mux =  Data_in_46;
        7'b0101110 : Data_Read_mux =  Data_in_47;
        7'b0101111 : Data_Read_mux =  Data_in_48;
        7'b0110000 : Data_Read_mux =  Data_in_49;
        7'b0110001 : Data_Read_mux =  Data_in_50;
        7'b0110010 : Data_Read_mux =  Data_in_51;
        7'b0110011 : Data_Read_mux =  Data_in_52;
        7'b0110100 : Data_Read_mux =  Data_in_53;
        7'b0110101 : Data_Read_mux =  Data_in_54;
        7'b0110110 : Data_Read_mux =  Data_in_55;
        7'b0110111 : Data_Read_mux =  Data_in_56;
        7'b0111000 : Data_Read_mux =  Data_in_57;
        7'b0111001 : Data_Read_mux =  Data_in_58;
        7'b0111010 : Data_Read_mux =  Data_in_59;
        7'b0111011 : Data_Read_mux =  Data_in_60;
        7'b0111100 : Data_Read_mux =  Data_in_61;
        7'b0111101 : Data_Read_mux =  Data_in_62;
        7'b0111110 : Data_Read_mux =  Data_in_63;
        7'b0111111 : Data_Read_mux =  Data_in_64;
        7'b1000000 : Data_Read_mux =  Data_in_65;
        7'b1000001 : Data_Read_mux =  Data_in_66;
        7'b1000010 : Data_Read_mux =  Data_in_67;
        7'b1000011 : Data_Read_mux =  Data_in_68;
        7'b1000100 : Data_Read_mux =  Data_in_69;
        7'b1000101 : Data_Read_mux =  Data_in_70;
        7'b1000110 : Data_Read_mux =  Data_in_71;
        7'b1000111 : Data_Read_mux =  Data_in_72;
        7'b1001000 : Data_Read_mux =  Data_in_73;
        7'b1001001 : Data_Read_mux =  Data_in_74;
        7'b1001010 : Data_Read_mux =  Data_in_75;
        7'b1001011 : Data_Read_mux =  Data_in_76;
        7'b1001100 : Data_Read_mux =  Data_in_77;
        7'b1001101 : Data_Read_mux =  Data_in_78;
        7'b1001110 : Data_Read_mux =  Data_in_79;
        7'b1001111 : Data_Read_mux =  Data_in_80;
        7'b1010000 : Data_Read_mux =  Data_in_81;
        7'b1010001 : Data_Read_mux =  Data_in_82;
        7'b1010010 : Data_Read_mux =  Data_in_83;
        7'b1010011 : Data_Read_mux =  Data_in_84;
        default :  Data_Read_mux ={DATA_WIDTH {1'b0}} ;
        endcase
    end
    
    wire [DATA_WIDTH-1:0] Data_for_FC;
    wire [DATA_WIDTH-1:0] relu_out ;

    Relu #(.DATA_WIDTH(DATA_WIDTH)) Active (.in(Data_Read_mux),.out (relu_out),.relu_enable(1'b1));
    
	Register #(.DATA_WIDTH(DATA_WIDTH)) 
	R (
	   .clk(clk),
	   .reset(reset),
	   .Enable(enable_read_current),
	   .Data_in(relu_out),
	   .Data_out(Data_for_FC)
	   ); 
 

   
	Fully_Connected_2  #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) F2 (.Data_in(Data_for_FC),.Data_Weight_1(Data_Weight_1) ,.Data_Weight_2(Data_Weight_2) ,.Data_Weight_3(Data_Weight_3) ,.Data_Weight_4(Data_Weight_4) ,.Data_Weight_5(Data_Weight_5) ,.Data_Weight_6(Data_Weight_6) ,.Data_Weight_7(Data_Weight_7) ,.Data_Weight_8(Data_Weight_8) ,.Data_Weight_9(Data_Weight_9) ,.Data_Weight_10(Data_Weight_10) ,.Data_out_FC_1(s_Data_out_FC_1) ,.Data_out_FC_2(s_Data_out_FC_2) ,.Data_out_FC_3(s_Data_out_FC_3) ,.Data_out_FC_4(s_Data_out_FC_4) ,.Data_out_FC_5(s_Data_out_FC_5) ,.Data_out_FC_6(s_Data_out_FC_6) ,.Data_out_FC_7(s_Data_out_FC_7) ,.Data_out_FC_8(s_Data_out_FC_8) ,.Data_out_FC_9(s_Data_out_FC_9) ,.Data_out_FC_10(s_Data_out_FC_10));

	FIFO_10outputs_FC2  #(.DATA_WIDTH(DATA_WIDTH)) 
	FIFO1 (
	        .clk(clk), 
            .fifo_data_in(riscv_data), 
            .fifo_enable(bm_enable_write),
            .fifo_data_out_1 ( data_bias_1 ),
            .fifo_data_out_2 ( data_bias_2 ),
            .fifo_data_out_3 ( data_bias_3 ),
            .fifo_data_out_4 ( data_bias_4 ),
            .fifo_data_out_5 ( data_bias_5 ),
            .fifo_data_out_6 ( data_bias_6 ),
            .fifo_data_out_7 ( data_bias_7 ),
            .fifo_data_out_8 ( data_bias_8 ),
            .fifo_data_out_9 ( data_bias_9 ),
            .fifo_data_out_10( data_bias_10)
           );
		   
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
           end
         else if (fc_output_ready)
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
           
           end
        end
		
    


endmodule