`timescale 1ns / 1ps

module ConvA1_DP #(parameter DATA_WIDTH          = 32,
                             ADDRESS_BITS        = 15,
                             /////////////////////////////////////
	                         IFM_SIZE              = 32,                                                
                             IFM_DEPTH             = 3,
							 KERNAL_SIZE           = 5,
		                     NUMBER_OF_FILTERS     = 6,
		                     NUMBER_OF_UNITS       = 3,
		                     //////////////////////////////////////
							 IFM_SIZE_NEXT           = IFM_SIZE - KERNAL_SIZE + 1,
                             ADDRESS_SIZE_IFM        = $clog2(IFM_SIZE*IFM_SIZE),
                             ADDRESS_SIZE_NEXT_IFM   = $clog2(IFM_SIZE_NEXT*IFM_SIZE_NEXT),
                             ADDRESS_SIZE_WM         = $clog2(KERNAL_SIZE*KERNAL_SIZE*NUMBER_OF_FILTERS),      
                             FIFO_SIZE               = (KERNAL_SIZE-1)*IFM_SIZE + KERNAL_SIZE,
                             NUMBER_OF_IFM           = IFM_DEPTH,
                             NUMBER_OF_IFM_NEXT      = NUMBER_OF_FILTERS,
                             NUMBER_OF_WM            = KERNAL_SIZE*KERNAL_SIZE,                              
                             NUMBER_OF_BITS_SEL_IFM_NEXT = $clog2(NUMBER_OF_IFM_NEXT))
(
	input clk,
	input reset,
	input [DATA_WIDTH-1:0] riscv_data,
	input [ADDRESS_BITS-1:0] riscv_address,
	
	input fifo_enable,
	input conv_enable,
    
	input [NUMBER_OF_IFM-1:0]    ifm_enable_write_previous,            
	input [ADDRESS_SIZE_IFM-1:0] ifm_address_read_current,
    input                        ifm_enable_read_current,
    
    input                       wm_addr_sel,
    input                       wm_enable_read,
    input [NUMBER_OF_UNITS-1:0] wm_enable_write,
    input [ADDRESS_SIZE_WM-1:0] wm_address_read_current,
    input                       wm_fifo_enable,
    
    input                                 bm_addr_sel,
    input                                 bm_enable_read,
    input                                 bm_enable_write,
    input [$clog2(NUMBER_OF_FILTERS)-1:0] bm_address_read_current,

    output [DATA_WIDTH-1:0] data_out_for_next
    );
////////////////////////Signal declaration/////////////////

	wire [DATA_WIDTH-1:0] data_read_for_unit1;
	wire [DATA_WIDTH-1:0] data_read_for_unit2;
	wire [DATA_WIDTH-1:0] data_read_for_unit3;

	wire [DATA_WIDTH-1:0] unit1_data_out;
	wire [DATA_WIDTH-1:0] unit2_data_out;
	wire [DATA_WIDTH-1:0] unit3_data_out;
	
	wire [DATA_WIDTH-1:0] data_bias;
	
	reg [DATA_WIDTH-1:0] partial_sum1;
	reg [DATA_WIDTH-1:0] partial_sum2;
	reg [DATA_WIDTH-1:0] full_sum;
	    
	wire [ADDRESS_SIZE_WM-1:0] wm_address;
	wire [$clog2(NUMBER_OF_FILTERS)-1:0] bm_address;
	
	assign wm_address = wm_addr_sel ? wm_address_read_current : riscv_address[ADDRESS_SIZE_WM-1:0];
	assign bm_address = bm_addr_sel ? bm_address_read_current : riscv_address[$clog2(NUMBER_OF_FILTERS)-1:0];
    
    SinglePort_Memory #(.MEM_SIZE (NUMBER_OF_FILTERS)) bm (.clk(clk),	.Enable_Write(bm_enable_write),
     .Enable_Read(bm_enable_read),	.Address(bm_address),
	 .Data_Input(riscv_data),	.Data_Output(data_bias));
	 
  
	TrueDualPort_Memory #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_SIZE*IFM_SIZE)) 
	convA1_IFM1 (
    .clk(clk),
    
    .Data_Input_A(riscv_data),
    .Address_A(riscv_address),
    .Enable_Write_A(ifm_enable_write_previous[0]),
    .Enable_Read_A(0), 
  
    .Data_Input_B(0),
    .Address_B(ifm_address_read_current),
    .Enable_Write_B(0),
    .Enable_Read_B(ifm_enable_read_current), 
  
    .Data_Output_A(),
    .Data_Output_B(data_read_for_unit1)
	);
	
/*	TrueDualPort_Memory #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_SIZE*IFM_SIZE)) 
	convA1_IFM2 (
    .clk(clk),
    
    .Data_Input_A(riscv_data),
    .Address_A(riscv_address),
    .Enable_Write_A(ifm_enable_write_previous[1]),
    .Enable_Read_A(0), 
  
    .Data_Input_B(0),
    .Address_B(ifm_address_read_current),
    .Enable_Write_B(0),
    .Enable_Read_B(ifm_enable_read_current), 
  
    .Data_Output_A(),
    .Data_Output_B(data_read_for_unit2)
	);
	
	TrueDualPort_Memory #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_SIZE*IFM_SIZE)) 
	convA1_IFM3 (
    .clk(clk),
    
    .Data_Input_A(riscv_data),
    .Address_A(riscv_address),
    .Enable_Write_A(ifm_enable_write_previous[2]),
    .Enable_Read_A(0), 
  
    .Data_Input_B(0),
    .Address_B(ifm_address_read_current),
    .Enable_Write_B(0),
    .Enable_Read_B(ifm_enable_read_current), 
  
    .Data_Output_A(),
    .Data_Output_B(data_read_for_unit3)
	);
*/	
	 
    ConvA1_unit 
    convA1_unit_1
    (
    .clk(clk),                                 
    .reset(reset),  
    .riscv_data(riscv_data),                             
    .unit_data_in(data_read_for_unit1),       
    .fifo_enable(fifo_enable),                         
    .conv_enable(conv_enable),
    .wm_enable_read(wm_enable_read),          
    .wm_enable_write(wm_enable_write[0]),          
    .wm_address(wm_address),
    .wm_fifo_enable(wm_fifo_enable),
    .unit_data_out(unit1_data_out)   
    );
    
/*    ConvA1_unit 
    convA1_unit_2
    (
    .clk(clk),                                 
    .reset(reset),  
    .riscv_data(riscv_data),                             
    .unit_data_in(data_read_for_unit2),       
    .fifo_enable(fifo_enable),                         
    .conv_enable(conv_enable),  
    .wm_enable_read(wm_enable_read),          
    .wm_enable_write(wm_enable_write[1]),          
    .wm_address(wm_address),
    .wm_fifo_enable(wm_fifo_enable),          
    .unit_data_out(unit2_data_out)   
    );
    
    ConvA1_unit 
    convA1_unit_3
    (
    .clk(clk),                                 
    .reset(reset),  
    .riscv_data(riscv_data),                             
    .unit_data_in(data_read_for_unit3),       
    .fifo_enable(fifo_enable),                         
    .conv_enable(conv_enable),    
    .wm_enable_read(wm_enable_read),          
    .wm_enable_write(wm_enable_write[2]),         
    .wm_address(wm_address),
    .wm_fifo_enable(wm_fifo_enable),          
    .unit_data_out(unit3_data_out)   
    );
*/	
	wire [DATA_WIDTH-1:0] full_sum_reg;
	
	always @(posedge clk)
	begin
	   partial_sum1 <= unit1_data_out;//unit1_data_out + unit2_data_out;
	   partial_sum2 <= data_bias;//unit3_data_out + data_bias;
	   full_sum     <= full_sum_reg;
	end
	
   FP_Adder Adder (.FP_in1 (partial_sum1), .FP_in2 (partial_sum2), .FP_out (full_sum_reg));
   
   Relu  Active1 (.in(full_sum),.out (data_out_for_next), .relu_enable(1'b1)); 
	 
    
	
endmodule