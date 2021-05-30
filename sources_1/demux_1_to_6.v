`timescale 1ns / 1ps



module 
 demux_1_to_6 
(
	input  din,
	input  [2:0] sel,
	output dout_1,
	output dout_2,
	output dout_3,
	output dout_4,
	output dout_5,
	output dout_6
);

	assign dout_1	= din & ( ~sel[0] ) & ( ~sel[1] ) & ( ~sel[2] );
	assign dout_2	= din & (  sel[0] ) & ( ~sel[1] ) & ( ~sel[2] );
	assign dout_3	= din & ( ~sel[0] ) & (  sel[1] ) & ( ~sel[2] );
	assign dout_4	= din & (  sel[0] ) & (  sel[1] ) & ( ~sel[2] );
	assign dout_5	= din & ( ~sel[0] ) & ( ~sel[1] ) & (  sel[2] );
	assign dout_6	= din & (  sel[0] ) & ( ~sel[1] ) & (  sel[2] );
	
endmodule
