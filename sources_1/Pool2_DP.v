`timescale 1ns / 1ps

module Pool2_DP #(parameter DATA_WIDTH          = 32,
                             /////////////////////////////////////
	                         IFM_SIZE              = 14,                                                
                             IFM_DEPTH             = 3,
							 KERNAL_SIZE           = 2,
							 NUMBER_OF_UNITS       = 3,
		                     //////////////////////////////////////
		                     NUMBER_OF_IFM           = IFM_DEPTH,
							 IFM_SIZE_NEXT           = (IFM_SIZE - KERNAL_SIZE)/2 + 1,
                             ADDRESS_SIZE_IFM        = $clog2(IFM_SIZE*IFM_SIZE),
                             ADDRESS_SIZE_NEXT_IFM   = $clog2(IFM_SIZE_NEXT*IFM_SIZE_NEXT),     
                             FIFO_SIZE               = (KERNAL_SIZE-1)*IFM_SIZE + KERNAL_SIZE)
	(
	input clk,
	input reset,
	
	input fifo_enable,
	input pool_enable,
	
	input [DATA_WIDTH-1:0] data_in_A_unit1,
	input [DATA_WIDTH-1:0] data_in_B_unit1,
	input [DATA_WIDTH-1:0] data_in_A_unit2,
	input [DATA_WIDTH-1:0] data_in_B_unit2,
	input [DATA_WIDTH-1:0] data_in_A_unit3,
	input [DATA_WIDTH-1:0] data_in_B_unit3,
	
	output [DATA_WIDTH-1:0] data_out_1,
	output [DATA_WIDTH-1:0] data_out_2,
	output [DATA_WIDTH-1:0] data_out_3
    );
////////////////////////Signal declaration/////////////////
		

    Pool2_unit #(.DATA_WIDTH(DATA_WIDTH), .IFM_SIZE(IFM_SIZE), .IFM_DEPTH(IFM_DEPTH))
    unit1(
    .clk(clk),
	.reset(reset),
	.unit_data_in_A(data_in_A_unit1),
	.unit_data_in_B(data_in_B_unit1),
	.fifo_enable(fifo_enable),
	.pool_enable(pool_enable),
    .unit_data_out(data_out_1)
    );
	
	Pool2_unit #(.DATA_WIDTH(DATA_WIDTH), .IFM_SIZE(IFM_SIZE), .IFM_DEPTH(IFM_DEPTH))
    unit2(
    .clk(clk),
	.reset(reset),
	.unit_data_in_A(data_in_A_unit2),
	.unit_data_in_B(data_in_B_unit2),
	.fifo_enable(fifo_enable),
	.pool_enable(pool_enable),
    .unit_data_out(data_out_2)
    );
    
    Pool2_unit #(.DATA_WIDTH(DATA_WIDTH), .IFM_SIZE(IFM_SIZE), .IFM_DEPTH(IFM_DEPTH))
    unit3(
    .clk(clk),
	.reset(reset),
	.unit_data_in_A(data_in_A_unit3),
	.unit_data_in_B(data_in_B_unit3),
	.fifo_enable(fifo_enable),
	.pool_enable(pool_enable),
    .unit_data_out(data_out_3)
    );
    
endmodule
