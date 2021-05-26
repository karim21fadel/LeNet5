`timescale 1ns / 1ps

module Relu #(parameter Data_Width = 32)
    (
    input relu_enable,
    input [Data_Width-1:0] in,
    output [Data_Width-1:0] out
    );
   
   assign out = ( (in[Data_Width-1]) & relu_enable ) ?  8'h00000000 : in ;
    //assign out = in;
endmodule 