`timescale 1ns / 1ps

module mem_array_2 #(parameter DATA_WIDTH            = 32,
                              /////////////////////////////////////
	                          IFM_SIZE              = 14,                                                
                              NUMBER_OF_IFM         = 2,
                              NUMBER_OF_UNITS       = 3,
                              ADDRESS_SIZE_IFM      = $clog2(IFM_SIZE*IFM_SIZE))
    (
    input clk,
	input ifm_sel,
	
	input                        ifm_enable_write_previous,            
	input                        ifm_enable_read_previous, 
	input [ADDRESS_SIZE_IFM-1:0] ifm_address_write_previous,
	input [ADDRESS_SIZE_IFM-1:0] ifm_address_read_previous,	
	input      [DATA_WIDTH-1:0]  data_in_from_previous,
	output reg [DATA_WIDTH-1:0]  data_out_for_previous,
	
	input                        ifm_enable_read_A_next,
	input                        ifm_enable_read_B_next,
	input [ADDRESS_SIZE_IFM-1:0] ifm_address_read_A_next,
	input [ADDRESS_SIZE_IFM-1:0] ifm_address_read_B_next,
	output reg [DATA_WIDTH-1:0]  data_out_A_for_next,
	output reg [DATA_WIDTH-1:0]  data_out_B_for_next
    );
    
    ////////////////////////Signal declaration/////////////////
    
    wire [DATA_WIDTH-1:0]   Data_Output_A_Mem1 , Data_Output_B_Mem1 ,
	                        Data_Output_A_Mem2 , Data_Output_B_Mem2 ;


    wire ifm_enable_write_previous_dMuxOut1, ifm_enable_write_previous_dMuxOut2;
    wire ifm_enable_read_previous_dMuxOut1, ifm_enable_read_previous_dMuxOut2;
    wire ifm_enable_read_A_next_dMuxOut1, ifm_enable_read_A_next_dMuxOut2;
    wire ifm_enable_read_B_next_dMuxOut1, ifm_enable_read_B_next_dMuxOut2;
        
    wire [ADDRESS_SIZE_IFM-1:0] ifm_address_write_previous_dMuxOut1, ifm_address_write_previous_dMuxOut2;                           
    wire [ADDRESS_SIZE_IFM-1:0] ifm_address_read_previous_dMuxOut1, ifm_address_read_previous_dMuxOut2;
    wire [ADDRESS_SIZE_IFM-1:0] ifm_address_read_A_next_dMuxOut1, ifm_address_read_A_next_dMuxOut2;     
    wire [ADDRESS_SIZE_IFM-1:0] ifm_address_read_B_next_dMuxOut1, ifm_address_read_B_next_dMuxOut2;     
    	
    demux_1_to_2 
    d0(
	.din(ifm_enable_write_previous),
	.sel(ifm_sel),
	.dout_1(ifm_enable_write_previous_dMuxOut1),
	.dout_2(ifm_enable_write_previous_dMuxOut2)
    );
    
    demux_1_to_2 
    d1(
	.din(ifm_enable_read_previous),
	.sel(ifm_sel),
	.dout_1(ifm_enable_read_previous_dMuxOut1),
	.dout_2(ifm_enable_read_previous_dMuxOut2)
    );
    
    demux_1_to_2
    d2(
	.din(ifm_enable_read_A_next),
	.sel(ifm_sel),
	.dout_1(ifm_enable_read_A_next_dMuxOut1),
	.dout_2(ifm_enable_read_A_next_dMuxOut2)
    );
    
    demux_1_to_2
    d3(
	.din(ifm_enable_read_B_next),
	.sel(ifm_sel),
	.dout_1(ifm_enable_read_B_next_dMuxOut1),
	.dout_2(ifm_enable_read_B_next_dMuxOut2)
    );
    
    demux_1_to_2_8bits 
    d4(
	.din(ifm_address_write_previous),
	.sel(ifm_sel),
	.dout_1(ifm_address_write_previous_dMuxOut1),
	.dout_2(ifm_address_write_previous_dMuxOut2)
    );
    
    demux_1_to_2_8bits 
    d5(
	.din(ifm_address_read_previous),
	.sel(ifm_sel),
	.dout_1(ifm_address_read_previous_dMuxOut1),
	.dout_2(ifm_address_read_previous_dMuxOut2)
    );
    
    demux_1_to_2_8bits 
    d6(
	.din(ifm_address_read_A_next),
	.sel(ifm_sel),
	.dout_1(ifm_address_read_A_next_dMuxOut1),
	.dout_2(ifm_address_read_A_next_dMuxOut2)
    );
    
    demux_1_to_2_8bits 
    d7(
	.din(ifm_address_read_B_next),
	.sel(ifm_sel),
	.dout_1(ifm_address_read_B_next_dMuxOut1),
	.dout_2(ifm_address_read_B_next_dMuxOut2)
    );
    
    always @*
    begin
   
        case(ifm_sel)
        
        1'b0:
        begin

            data_out_for_previous = Data_Output_B_Mem1;   

            data_out_A_for_next   = Data_Output_A_Mem2;
            data_out_B_for_next   = Data_Output_B_Mem2;   
        end
        
        default:
        begin

            data_out_for_previous = Data_Output_B_Mem2;   

            data_out_A_for_next   = Data_Output_A_Mem1;
            data_out_B_for_next   = Data_Output_B_Mem1;   
        end

        endcase
        
	end
    
    
	TrueDualPort_Memory #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_SIZE*IFM_SIZE)) 
    IFM1 (
    .clk(clk),
    
    .Data_Input_A(data_in_from_previous),
    .Address_A(ifm_address_write_previous_dMuxOut1 | ifm_address_read_A_next_dMuxOut2),
    .Enable_Write_A(ifm_enable_write_previous_dMuxOut1),
    .Enable_Read_A(ifm_enable_read_A_next_dMuxOut2), 
  
    .Data_Input_B('b0),
    .Address_B(ifm_address_read_previous_dMuxOut1 | ifm_address_read_B_next_dMuxOut2),
    .Enable_Write_B(1'b0),
    .Enable_Read_B(ifm_enable_read_previous_dMuxOut1 | ifm_enable_read_B_next_dMuxOut2), 
  
    .Data_Output_A(Data_Output_A_Mem1),
    .Data_Output_B(Data_Output_B_Mem1)
	);
	
	TrueDualPort_Memory #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_SIZE*IFM_SIZE))
	IFM2 (
    .clk(clk),
    
    .Data_Input_A(data_in_from_previous),
    .Address_A(ifm_address_write_previous_dMuxOut2 | ifm_address_read_A_next_dMuxOut1),
    .Enable_Write_A(ifm_enable_write_previous_dMuxOut2),
    .Enable_Read_A(ifm_enable_read_A_next_dMuxOut1), 
  
    .Data_Input_B('b0),
    .Address_B(ifm_address_read_previous_dMuxOut2 | ifm_address_read_B_next_dMuxOut1),
    .Enable_Write_B(1'b0),
    .Enable_Read_B(ifm_enable_read_previous_dMuxOut2  | ifm_enable_read_B_next_dMuxOut1), 
  
    .Data_Output_A(Data_Output_A_Mem2),
    .Data_Output_B(Data_Output_B_Mem2)
	);
	 
	
endmodule

