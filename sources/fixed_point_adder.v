`timescale 1ns / 1ps

module fixed_point_adder #(parameter DATA_WIDTH = 16 , INTEGER = 6, FRACTION = 10 )
    (
    input [DATA_WIDTH-1:0] FP_in1,
    input [DATA_WIDTH-1:0] FP_in2,
    output [DATA_WIDTH-1:0] FP_out
    );
   
	assign FP_out = FP_in1 + FP_in2;
  
endmodule
