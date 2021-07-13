`timescale 1ns / 1ps

module fixed_point_mul #(parameter DATA_WIDTH = 16 , INTEGER = 6, FRACTION = 10 )
    (
    input signed [DATA_WIDTH-1:0] FP_in1,
    input signed [DATA_WIDTH-1:0] FP_in2,
    output signed [DATA_WIDTH-1:0] FP_out
    );
    
	wire signed [2*DATA_WIDTH-1:0] out_signal;
	
    assign out_signal = FP_in1 * FP_in2;
    assign FP_out =  {out_signal[(2*FRACTION)+INTEGER-1:2*FRACTION],out_signal[(2*FRACTION)-1:FRACTION]};
   
endmodule