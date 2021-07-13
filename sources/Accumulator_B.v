`timescale 1ns / 1ps

module Accumulator_B #(parameter ARITH_TYPE = 1, DATA_WIDTH      = 32,
                             ADDRESS_BITS        = 15,
                             /////////////////////////////////////
	                         IFM_SIZE              = 14,                                                
                             IFM_DEPTH             = 3,
							 KERNAL_SIZE           = 5,
		                     NUMBER_OF_FILTERS     = 16,
							 NUMBER_OF_UNITS       = 3,
		                     //////////////////////////////////////
							 IFM_SIZE_NEXT           = IFM_SIZE - KERNAL_SIZE + 1,
                             ADDRESS_SIZE_IFM        = $clog2(IFM_SIZE*IFM_SIZE),
                             ADDRESS_SIZE_NEXT_IFM   = $clog2(IFM_SIZE_NEXT*IFM_SIZE_NEXT),
                             ADDRESS_SIZE_WM         = $clog2(KERNAL_SIZE*KERNAL_SIZE*IFM_DEPTH*(NUMBER_OF_FILTERS/NUMBER_OF_UNITS+1)),      
                             FIFO_SIZE               = (KERNAL_SIZE-1)*IFM_SIZE + KERNAL_SIZE,
                             NUMBER_OF_IFM_NEXT      = NUMBER_OF_FILTERS,
                             NUMBER_OF_WM            = KERNAL_SIZE*KERNAL_SIZE,                              
                             NUMBER_OF_BITS_SEL_IFM_NEXT =$clog2(NUMBER_OF_IFM_NEXT),
							 NUMBER_OF_BITS_CHANNELS =$clog2(IFM_DEPTH)+1
                             )
    (
      input clk,
      input accu_enable,
	  input  [DATA_WIDTH-1:0] data_in_from_conv,
	  input  [DATA_WIDTH-1:0] data_bias,
      input  [DATA_WIDTH-1:0] data_in_from_next,
      output [DATA_WIDTH-1:0] accu_data_out
     );

    wire [DATA_WIDTH-1:0] data_out_mux;
    
	assign data_out_mux = accu_enable ? data_in_from_next : data_bias;

    Adder #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) add (.FP_in1 (data_in_from_conv), .FP_in2 (data_out_mux), .FP_out (accu_data_out));

endmodule
