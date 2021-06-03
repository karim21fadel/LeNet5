module mem_unit #(parameter DATA_WIDTH            = 32,
                              /////////////////////////////////////
	                          IFM_SIZE              = 14,                                                
                              ADDRESS_SIZE_IFM      = $clog2(IFM_SIZE*IFM_SIZE))
(
   input clk,
   input [DATA_WIDTH-1:0]           Data_Input_A_Mem1,
   input [DATA_WIDTH-1:0]           Data_Input_B_Mem1,
   input [DATA_WIDTH-1:0]           Data_Input_A_Mem2,
   input [DATA_WIDTH-1:0]           Data_Input_B_Mem2,
   input [DATA_WIDTH-1:0]           Data_Input_A_Mem3,
   input [DATA_WIDTH-1:0]           Data_Input_B_Mem3,
   input [ADDRESS_SIZE_IFM-1:0]     Address_A,
   input [ADDRESS_SIZE_IFM-1:0]     Address_B,
   input Enable_Write_A_Mem,Enable_Read_A_Mem,
   input Enable_Write_B_Mem,Enable_Read_B_Mem,
   output [DATA_WIDTH-1:0]    Data_Output_A_Mem1 ,
   output [DATA_WIDTH-1:0]    Data_Output_B_Mem1 ,
   output [DATA_WIDTH-1:0]    Data_Output_A_Mem2 ,
   output [DATA_WIDTH-1:0]    Data_Output_B_Mem2 ,
   output [DATA_WIDTH-1:0]    Data_Output_A_Mem3 ,
   output [DATA_WIDTH-1:0]    Data_Output_B_Mem3 
   );
   

TrueDualPort_Memory #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_SIZE*IFM_SIZE)) 
	convA2_IFM1 (
    .clk(clk),
    
    .Data_Input_A(Data_Input_A_Mem1),
    .Address_A(Address_A),
    .Enable_Write_A(Enable_Write_A_Mem),
    .Enable_Read_A(Enable_Read_A_Mem), 
  
    .Data_Input_B(Data_Input_B_Mem1),
    .Address_B(Address_B),
    .Enable_Write_B(Enable_Write_B_Mem),
    .Enable_Read_B(Enable_Read_B_Mem), 
  
    .Data_Output_A(Data_Output_A_Mem1),
    .Data_Output_B(Data_Output_B_Mem1)
	);
	
	TrueDualPort_Memory #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_SIZE*IFM_SIZE)) 
	convA2_IFM2 (
    .clk(clk),
    
    .Data_Input_A(Data_Input_A_Mem2),
    .Address_A(Address_A),
    .Enable_Write_A(Enable_Write_A_Mem),
    .Enable_Read_A(Enable_Read_A_Mem), 
  
    .Data_Input_B(Data_Input_B_Mem2),
    .Address_B(Address_B),
    .Enable_Write_B(Enable_Write_B_Mem),
    .Enable_Read_B(Enable_Read_B_Mem), 
  
    .Data_Output_A(Data_Output_A_Mem2),
    .Data_Output_B(Data_Output_B_Mem2)
	);
	
	TrueDualPort_Memory #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_SIZE*IFM_SIZE)) 
	convA2_IFM3 (
    .clk(clk),
    
    .Data_Input_A(Data_Input_A_Mem3),
    .Address_A(Address_A),
    .Enable_Write_A(Enable_Write_A_Mem),
    .Enable_Read_A(Enable_Read_A_Mem), 
  
    .Data_Input_B(Data_Input_B_Mem3),
    .Address_B(Address_B),
    .Enable_Write_B(Enable_Write_B_Mem),
    .Enable_Read_B(Enable_Read_B_Mem), 
  
    .Data_Output_A(Data_Output_A_Mem3),
    .Data_Output_B(Data_Output_B_Mem3)
	);
	
endmodule 