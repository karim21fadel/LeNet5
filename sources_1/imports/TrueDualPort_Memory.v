`timescale 1ns / 1ps

module TrueDualPort_Memory#(parameter DATA_WIDTH = 32, MEM_SIZE   = 28*28)

    (
    input clk,
  
    input [DATA_WIDTH-1:0] Data_Input_A,
    input [$clog2(MEM_SIZE)-1:0] Address_A,
    input Enable_Write_A,
    input Enable_Read_A, 
  
    input [DATA_WIDTH-1:0] Data_Input_B,
    input [$clog2(MEM_SIZE)-1:0] Address_B,
    input Enable_Write_B,
    input Enable_Read_B, 
  
    output reg [DATA_WIDTH-1:0] Data_Output_A,
    output reg [DATA_WIDTH-1:0] Data_Output_B
    );
    
    reg [DATA_WIDTH-1:0] IFM_Memory [MEM_SIZE-1:0];

    always @(posedge clk)
    begin
        if(Enable_Write_A)
            IFM_Memory[Address_A] <= Data_Input_A;
        if(Enable_Read_A)    
            Data_Output_A <= IFM_Memory[Address_A];
    end
 
    always @(posedge clk)
    begin
        if(Enable_Write_B)
            IFM_Memory[Address_B] <= Data_Input_B;
        if(Enable_Read_B)    
            Data_Output_B <= IFM_Memory[Address_B];
    end

endmodule