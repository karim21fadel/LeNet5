`timescale 1ns / 1ps

/*********************************************************************************
* Create Date: 01/19/2021 08:53:06 PM                                            *
* Module Name: Multiplier                                                        *
* N : Number of bits 16 - 32 - 64                                                *
* E : Exponent Width 5  - 8  - 11                                                *
* M : Mantissa Width 10 - 23 - 52                                                *
* Bias: 2**(E-1)-1                                                               *
**********************************************************************************/

module Multiplier #(parameter ARITH_TYPE = 1, DATA_WIDTH = 32 , E=8, M=23 )
    (
    input [DATA_WIDTH-1:0] FP_in1,
    input [DATA_WIDTH-1:0] FP_in2,
    output [DATA_WIDTH-1:0] FP_out
    );
    
    generate
		if (ARITH_TYPE)
			fixed_point_mul    add (.FP_in1(FP_in1), .FP_in2(FP_in2), .FP_out(FP_out));
		else
			floating_point_mul add (.FP_in1(FP_in1), .FP_in2(FP_in2), .FP_out(FP_out));
    endgenerate
    
endmodule
