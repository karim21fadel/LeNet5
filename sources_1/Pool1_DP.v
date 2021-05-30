`timescale 1ns / 1ps

module  Pool1_DP #(parameter DATA_WIDTH            = 32,
                             /////////////////////////////////////
	                         IFM_SIZE              = 14,                                                
                             IFM_DEPTH             = 3,
							 KERNAL_SIZE           = 2,
		                     //////////////////////////////////////
		                     NUMBER_OF_IFM           = 2,
							 IFM_SIZE_NEXT           = (IFM_SIZE - KERNAL_SIZE)/2 + 1,
                             ADDRESS_SIZE_IFM        = $clog2(IFM_SIZE*IFM_SIZE),
                             ADDRESS_SIZE_NEXT_IFM   = $clog2(IFM_SIZE_NEXT*IFM_SIZE_NEXT),     
                             FIFO_SIZE               = (KERNAL_SIZE-1)*IFM_SIZE + KERNAL_SIZE)
	(
	input clk,
	input reset,
	
	input fifo_enable,
	input pool_enable,
    
    input [DATA_WIDTH-1:0]  data_in_A,
	input [DATA_WIDTH-1:0]  data_in_B,
	
	output [DATA_WIDTH-1:0] data_out
    );
////////////////////////Signal declaration/////////////////
	
	wire [DATA_WIDTH-1:0] signal_if1;
	wire [DATA_WIDTH-1:0] signal_if2;
	wire [DATA_WIDTH-1:0] signal_if3;
	wire [DATA_WIDTH-1:0] signal_if4;
	
	
	FIFO_4outputs #(.DATA_WIDTH(DATA_WIDTH), .IFM_SIZE(IFM_SIZE), .IFM_DEPTH(IFM_DEPTH), .KERNAL_SIZE(KERNAL_SIZE))
	FIFO1 (
	 .clk(clk),
	 .reset(reset),
	 .fifo_data_in_A(data_in_A),
	 .fifo_data_in_B(data_in_B),
	 .fifo_enable(fifo_enable),
	 .fifo_data_out_1(signal_if1),
	 .fifo_data_out_2(signal_if2),
	 .fifo_data_out_3(signal_if3),
	 .fifo_data_out_4(signal_if4) 
	);

	Average_Pooling #(.DATA_WIDTH(DATA_WIDTH), .IFM_SIZE(IFM_SIZE), .IFM_DEPTH(IFM_DEPTH), .KERNAL_SIZE(KERNAL_SIZE))
	pool_1 (
	.clk(clk),
    .reset(reset),
    .pool_enable(pool_enable),
    .pool_data_in_1(signal_if1),
    .pool_data_in_2(signal_if2),
    .pool_data_in_3(signal_if3),
    .pool_data_in_4(signal_if4),
    .pool_data_out_reg(data_out)
	);
	
endmodule