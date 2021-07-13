`timescale 1ns / 1ps

module  TOP_Pool1 #(parameter ARITH_TYPE = 1, DATA_WIDTH          = 32,
                             /////////////////////////////////////
	                         IFM_SIZE              = 28,                                                
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
	 
	 input  start_from_previous,
	 input  [DATA_WIDTH-1:0]       data_in_A,
	 input  [DATA_WIDTH-1:0]       data_in_B,
	 output                        ifm_enable_read_A_current,
     output                        ifm_enable_read_B_current,
	 output [ADDRESS_SIZE_IFM-1:0] ifm_address_read_A_current,
	 output [ADDRESS_SIZE_IFM-1:0] ifm_address_read_B_current,
     output end_to_previous,
     
     input  end_from_next,
     output                             ifm_enable_write_next,
     output [ADDRESS_SIZE_NEXT_IFM-1:0] ifm_address_write_next,
     output [DATA_WIDTH-1:0]            data_out,
     output start_to_next,
     output ifm_sel_next
    );

    wire fifo_enable;
    wire pool_enable;
    
    Pool1_CU #(.DATA_WIDTH(DATA_WIDTH), .IFM_SIZE(IFM_SIZE), .IFM_DEPTH(IFM_DEPTH), .KERNAL_SIZE(KERNAL_SIZE))
    CU
    (
    .clk(clk),
    .reset(reset),
    .start_from_previous(start_from_previous),
    .end_from_next(end_from_next),
    .end_to_previous(end_to_previous),
    .ifm_enable_read_A_current(ifm_enable_read_A_current), 
    .ifm_enable_read_B_current(ifm_enable_read_B_current), 
    .ifm_address_read_A_current(ifm_address_read_A_current),
    .ifm_address_read_B_current(ifm_address_read_B_current),
    .fifo_enable (fifo_enable),
    .pool_enable (pool_enable),
    .ifm_enable_write_next(ifm_enable_write_next),
    .ifm_address_write_next (ifm_address_write_next),
    .start_to_next(start_to_next),
    .ifm_sel_next (ifm_sel_next)
   );
   
    Pool1_DP #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE), .IFM_SIZE(IFM_SIZE), .IFM_DEPTH(IFM_DEPTH), .KERNAL_SIZE(KERNAL_SIZE)) 
    DP
	(
	.clk(clk),
	.reset(reset),
	.fifo_enable(fifo_enable),
	.pool_enable(pool_enable),
	.data_in_A(data_in_A),
	.data_in_B(data_in_B),
    .data_out (data_out)
    );
	
endmodule
