`timescale 1ns / 1ps

module fixed_point_divider #(parameter DATA_WIDTH = 20 , INTEGER = 8, FRACTION = 12 )
    (
    input  [DATA_WIDTH-1:0] FP_in1,
    output  [DATA_WIDTH-1:0] FP_out
    );
 
  assign    FP_out = {FP_in1 [DATA_WIDTH-1],FP_in1 [DATA_WIDTH-1],FP_in1 [DATA_WIDTH-1:2]};
  
endmodule