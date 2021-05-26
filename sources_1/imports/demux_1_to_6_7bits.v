`timescale 1ns / 1ps



module 
 demux_1_to_6_7bits 
(
	input  [6:0] din,
	input  [2:0] sel,
	output [6:0] dout_1,
	output [6:0] dout_2,
	output [6:0] dout_3,
	output [6:0] dout_4,
	output [6:0] dout_5,
	output [6:0] dout_6
);

	demux_1_to_6 dm_0	 (.din(din[0]), 	 .sel(sel),	 .dout_1(dout_1[0]),	 .dout_2(dout_2[0]),	 .dout_3(dout_3[0]),	 .dout_4(dout_4[0]),	 .dout_5(dout_5[0]),	 .dout_6(dout_6[0]));
	demux_1_to_6 dm_1	 (.din(din[1]), 	 .sel(sel),	 .dout_1(dout_1[1]),	 .dout_2(dout_2[1]),	 .dout_3(dout_3[1]),	 .dout_4(dout_4[1]),	 .dout_5(dout_5[1]),	 .dout_6(dout_6[1]));
	demux_1_to_6 dm_2	 (.din(din[2]), 	 .sel(sel),	 .dout_1(dout_1[2]),	 .dout_2(dout_2[2]),	 .dout_3(dout_3[2]),	 .dout_4(dout_4[2]),	 .dout_5(dout_5[2]),	 .dout_6(dout_6[2]));
	demux_1_to_6 dm_3	 (.din(din[3]), 	 .sel(sel),	 .dout_1(dout_1[3]),	 .dout_2(dout_2[3]),	 .dout_3(dout_3[3]),	 .dout_4(dout_4[3]),	 .dout_5(dout_5[3]),	 .dout_6(dout_6[3]));
	demux_1_to_6 dm_4	 (.din(din[4]), 	 .sel(sel),	 .dout_1(dout_1[4]),	 .dout_2(dout_2[4]),	 .dout_3(dout_3[4]),	 .dout_4(dout_4[4]),	 .dout_5(dout_5[4]),	 .dout_6(dout_6[4]));
	demux_1_to_6 dm_5	 (.din(din[5]), 	 .sel(sel),	 .dout_1(dout_1[5]),	 .dout_2(dout_2[5]),	 .dout_3(dout_3[5]),	 .dout_4(dout_4[5]),	 .dout_5(dout_5[5]),	 .dout_6(dout_6[5]));
	demux_1_to_6 dm_6	 (.din(din[6]), 	 .sel(sel),	 .dout_1(dout_1[6]),	 .dout_2(dout_2[6]),	 .dout_3(dout_3[6]),	 .dout_4(dout_4[6]),	 .dout_5(dout_5[6]),	 .dout_6(dout_6[6]));
	
endmodule
