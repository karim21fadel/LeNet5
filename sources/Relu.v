`timescale 1ns / 1ps

module Relu #(parameter DATA_WIDTH = 32)
    (
    input relu_enable,
    input [DATA_WIDTH-1:0] in,
    output [DATA_WIDTH-1:0] out
    );
   
   assign out = ( (in[DATA_WIDTH-1]) & relu_enable ) ?  {DATA_WIDTH{1'b0}} : in ;
    
endmodule 
