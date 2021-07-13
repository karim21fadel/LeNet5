`timescale 1ns / 1ps



module 
 demux_1_to_2 
(
	input  din,
	input  sel,
	output dout_1,
	output dout_2
);

	assign dout_1	= din & ( ~sel );
	assign dout_2	= din & (  sel );

	
endmodule
