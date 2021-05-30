`timescale 1ns / 1ps

module SinglePort_Memory #(parameter DATA_WIDTH = 32, MEM_SIZE   = 28*28 ) 
(
input clk,
input Enable_Write,
input Enable_Read,
input [$clog2(MEM_SIZE)-1:0] Address,
input [DATA_WIDTH-1:0] Data_Input,
output reg [DATA_WIDTH-1:0] Data_Output
);
reg [DATA_WIDTH-1:0] Memory[MEM_SIZE-1:0];

always @ (posedge clk)
begin
    if (Enable_Write) 
       Memory[Address] <= Data_Input; 
    if(Enable_Read)
       Data_Output<= Memory[Address];
   end
endmodule
