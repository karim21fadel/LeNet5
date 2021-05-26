`timescale 1ns / 1ps



module 
 demux_1_to_2_10bits 
(
	input  [9:0] din,
	input  sel,
	output [9:0] dout_1,
	output [9:0] dout_2
);

	demux_1_to_2 dm_0	 (.din(din[0]),	 .sel(sel),	 .dout_1(dout_1[0]),	 .dout_2(dout_2[0]) );
	demux_1_to_2 dm_1	 (.din(din[1]),	 .sel(sel),	 .dout_1(dout_1[1]),	 .dout_2(dout_2[1]) );
	demux_1_to_2 dm_2	 (.din(din[2]),	 .sel(sel),	 .dout_1(dout_1[2]),	 .dout_2(dout_2[2]) );
	demux_1_to_2 dm_3	 (.din(din[3]),	 .sel(sel),	 .dout_1(dout_1[3]),	 .dout_2(dout_2[3]) );
	demux_1_to_2 dm_4	 (.din(din[4]),	 .sel(sel),	 .dout_1(dout_1[4]),	 .dout_2(dout_2[4]) );
	demux_1_to_2 dm_5	 (.din(din[5]),	 .sel(sel),	 .dout_1(dout_1[5]),	 .dout_2(dout_2[5]) );
	demux_1_to_2 dm_6	 (.din(din[6]),	 .sel(sel),	 .dout_1(dout_1[6]),	 .dout_2(dout_2[6]) );
	demux_1_to_2 dm_7	 (.din(din[7]),	 .sel(sel),	 .dout_1(dout_1[7]),	 .dout_2(dout_2[7]) );
	demux_1_to_2 dm_8	 (.din(din[8]),	 .sel(sel),	 .dout_1(dout_1[8]),	 .dout_2(dout_2[8]) );
	demux_1_to_2 dm_9	 (.din(din[9]),	 .sel(sel),	 .dout_1(dout_1[9]),	 .dout_2(dout_2[9]) );

endmodule
