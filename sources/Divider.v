`timescale 1ns / 1ps

module Divider #(parameter ARITH_TYPE = 1, DATA_WIDTH = 32 , E=8, M=23 )
    (
    input [DATA_WIDTH-1:0] FP_in1,
    output  [DATA_WIDTH-1:0] FP_out
    );
	
	generate
		if (ARITH_TYPE)
			 fixed_point_divider div (.FP_in1(FP_in1), .FP_out(FP_out));
		else
			floating_point_mul mul (.FP_in1(FP_in1), .FP_in2(32'b00111110100000000000000000000000), .FP_out(FP_out));
	endgenerate
	
endmodule
