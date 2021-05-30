`timescale 1ns / 1ps

module mem_array_3 #(parameter DATA_WIDTH            = 32,
                               /////////////////////////////////////
	                           IFM_SIZE              = 14,                                                
                               NUMBER_OF_IFM         = 16,
                               NUMBER_OF_UNITS       = 3,
                               ADDRESS_SIZE_IFM      = $clog2(IFM_SIZE*IFM_SIZE))
    (
    input clk,
	input [$clog2(NUMBER_OF_IFM/NUMBER_OF_UNITS+1)-1:0] ifm_sel,
	
	input                        ifm_enable_write_previous,            
	input                        ifm_enable_read_previous, 
	input [ADDRESS_SIZE_IFM-1:0] ifm_address_write_previous,
	input [ADDRESS_SIZE_IFM-1:0] ifm_address_read_previous,	
	input      [DATA_WIDTH-1:0]  data_in_from_previous1,
	input      [DATA_WIDTH-1:0]  data_in_from_previous2,
	input      [DATA_WIDTH-1:0]  data_in_from_previous3,
	output reg [DATA_WIDTH-1:0]  data_out_for_previous1,
	output reg [DATA_WIDTH-1:0]  data_out_for_previous2,
	output reg [DATA_WIDTH-1:0]  data_out_for_previous3,

	input                        ifm_enable_read_A_next,
    input                        ifm_enable_read_B_next,
	input [ADDRESS_SIZE_IFM-1:0] ifm_address_read_A_next,
	input [ADDRESS_SIZE_IFM-1:0] ifm_address_read_B_next,
	output reg [DATA_WIDTH-1:0]  data_out_A_for_next1,
	output reg [DATA_WIDTH-1:0]  data_out_B_for_next1,
	output reg [DATA_WIDTH-1:0]  data_out_A_for_next2,
	output reg [DATA_WIDTH-1:0]  data_out_B_for_next2,
	output reg [DATA_WIDTH-1:0]  data_out_A_for_next3,
	output reg [DATA_WIDTH-1:0]  data_out_B_for_next3
    );
    
    ////////////////////////Signal declaration/////////////////
	
	wire [DATA_WIDTH-1:0]    Data_Output_A_Mem1 , Data_Output_B_Mem1 ,
	                         Data_Output_A_Mem2 , Data_Output_B_Mem2 ,
	                         Data_Output_A_Mem3 , Data_Output_B_Mem3 ,
	                         Data_Output_A_Mem4 , Data_Output_B_Mem4 ,
	                         Data_Output_A_Mem5 , Data_Output_B_Mem5 ,
	                         Data_Output_A_Mem6 , Data_Output_B_Mem6 ,
	                         Data_Output_A_Mem7 , Data_Output_B_Mem7 ,
	                         Data_Output_A_Mem8 , Data_Output_B_Mem8 ,
	                         Data_Output_A_Mem9 , Data_Output_B_Mem9 ,
	                         Data_Output_A_Mem10 , Data_Output_B_Mem10 ,
	                         Data_Output_A_Mem11 , Data_Output_B_Mem11 ,
	                         Data_Output_A_Mem12 , Data_Output_B_Mem12 ,
	                         Data_Output_A_Mem13 , Data_Output_B_Mem13 ,
	                         Data_Output_A_Mem14 , Data_Output_B_Mem14 ,
	                         Data_Output_A_Mem15 , Data_Output_B_Mem15 ,
	                         Data_Output_A_Mem16 , Data_Output_B_Mem16 ;


wire ifm_enable_write_previous_dMuxOut1, ifm_enable_write_previous_dMuxOut2, 
     ifm_enable_write_previous_dMuxOut3, ifm_enable_write_previous_dMuxOut4, 
     ifm_enable_write_previous_dMuxOut5, ifm_enable_write_previous_dMuxOut6;

wire ifm_enable_read_previous_dMuxOut1, ifm_enable_read_previous_dMuxOut2, 
     ifm_enable_read_previous_dMuxOut3, ifm_enable_read_previous_dMuxOut4, 
     ifm_enable_read_previous_dMuxOut5, ifm_enable_read_previous_dMuxOut6;
     
wire ifm_enable_read_A_next_dMuxOut1, ifm_enable_read_A_next_dMuxOut2, 
     ifm_enable_read_A_next_dMuxOut3, ifm_enable_read_A_next_dMuxOut4, 
     ifm_enable_read_A_next_dMuxOut5, ifm_enable_read_A_next_dMuxOut6;
     
wire ifm_enable_read_B_next_dMuxOut1, ifm_enable_read_B_next_dMuxOut2, 
     ifm_enable_read_B_next_dMuxOut3, ifm_enable_read_B_next_dMuxOut4, 
     ifm_enable_read_B_next_dMuxOut5, ifm_enable_read_B_next_dMuxOut6;
     
wire [ADDRESS_SIZE_IFM-1:0] ifm_address_write_previous_dMuxOut1, ifm_address_write_previous_dMuxOut2, 
                            ifm_address_write_previous_dMuxOut3, ifm_address_write_previous_dMuxOut4, 
                            ifm_address_write_previous_dMuxOut5, ifm_address_write_previous_dMuxOut6;
                            
wire [ADDRESS_SIZE_IFM-1:0] ifm_address_read_previous_dMuxOut1, ifm_address_read_previous_dMuxOut2, 
                            ifm_address_read_previous_dMuxOut3, ifm_address_read_previous_dMuxOut4, 
                            ifm_address_read_previous_dMuxOut5, ifm_address_read_previous_dMuxOut6;
                            
wire [ADDRESS_SIZE_IFM-1:0] ifm_address_read_A_next_dMuxOut1, ifm_address_read_A_next_dMuxOut2, 
                            ifm_address_read_A_next_dMuxOut3, ifm_address_read_A_next_dMuxOut4, 
                            ifm_address_read_A_next_dMuxOut5, ifm_address_read_A_next_dMuxOut6;     
                                                                  
wire [ADDRESS_SIZE_IFM-1:0] ifm_address_read_B_next_dMuxOut1, ifm_address_read_B_next_dMuxOut2, 
                            ifm_address_read_B_next_dMuxOut3, ifm_address_read_B_next_dMuxOut4, 
                            ifm_address_read_B_next_dMuxOut5, ifm_address_read_B_next_dMuxOut6;
                                                        
    demux_1_to_6 
    d0(
	.din(ifm_enable_write_previous),
	.sel(ifm_sel),
	.dout_1(ifm_enable_write_previous_dMuxOut1),
	.dout_2(ifm_enable_write_previous_dMuxOut2),
	.dout_3(ifm_enable_write_previous_dMuxOut3),
	.dout_4(ifm_enable_write_previous_dMuxOut4),
	.dout_5(ifm_enable_write_previous_dMuxOut5),
	.dout_6(ifm_enable_write_previous_dMuxOut6)
    );
    
    demux_1_to_6 
    d1(
	.din(ifm_enable_read_previous),
	.sel(ifm_sel),
	.dout_1(ifm_enable_read_previous_dMuxOut1),
	.dout_2(ifm_enable_read_previous_dMuxOut2),
	.dout_3(ifm_enable_read_previous_dMuxOut3),
	.dout_4(ifm_enable_read_previous_dMuxOut4),
	.dout_5(ifm_enable_read_previous_dMuxOut5),
	.dout_6(ifm_enable_read_previous_dMuxOut6)
    );
    
    demux_1_to_6 
    d2(
	.din(ifm_enable_read_A_next),
	.sel(ifm_sel),
	.dout_1(ifm_enable_read_A_next_dMuxOut1),
	.dout_2(ifm_enable_read_A_next_dMuxOut2),
	.dout_3(ifm_enable_read_A_next_dMuxOut3),
	.dout_4(ifm_enable_read_A_next_dMuxOut4),
	.dout_5(ifm_enable_read_A_next_dMuxOut5),
	.dout_6(ifm_enable_read_A_next_dMuxOut6)
    );
    
    demux_1_to_6 
    d3(
	.din(ifm_enable_read_B_next),
	.sel(ifm_sel),
	.dout_1(ifm_enable_read_B_next_dMuxOut1),
	.dout_2(ifm_enable_read_B_next_dMuxOut2),
	.dout_3(ifm_enable_read_B_next_dMuxOut3),
	.dout_4(ifm_enable_read_B_next_dMuxOut4),
	.dout_5(ifm_enable_read_B_next_dMuxOut5),
	.dout_6(ifm_enable_read_B_next_dMuxOut6)
    );
    
    demux_1_to_6_7bits 
    d4(
	.din(ifm_address_write_previous),
	.sel(ifm_sel),
	.dout_1(ifm_address_write_previous_dMuxOut1),
	.dout_2(ifm_address_write_previous_dMuxOut2),
	.dout_3(ifm_address_write_previous_dMuxOut3),
	.dout_4(ifm_address_write_previous_dMuxOut4),
	.dout_5(ifm_address_write_previous_dMuxOut5),
	.dout_6(ifm_address_write_previous_dMuxOut6)
    );
    
    demux_1_to_6_7bits 
    d5(
	.din(ifm_address_read_previous),
	.sel(ifm_sel),
	.dout_1(ifm_address_read_previous_dMuxOut1),
	.dout_2(ifm_address_read_previous_dMuxOut2),
	.dout_3(ifm_address_read_previous_dMuxOut3),
	.dout_4(ifm_address_read_previous_dMuxOut4),
	.dout_5(ifm_address_read_previous_dMuxOut5),
	.dout_6(ifm_address_read_previous_dMuxOut6)
    );
    
    demux_1_to_6_7bits 
    d6(
	.din(ifm_address_read_A_next),
	.sel(ifm_sel),
	.dout_1(ifm_address_read_A_next_dMuxOut1),
	.dout_2(ifm_address_read_A_next_dMuxOut2),
	.dout_3(ifm_address_read_A_next_dMuxOut3),
	.dout_4(ifm_address_read_A_next_dMuxOut4),
	.dout_5(ifm_address_read_A_next_dMuxOut5),
	.dout_6(ifm_address_read_A_next_dMuxOut6)
    );
    
    demux_1_to_6_7bits 
    d7(
	.din(ifm_address_read_B_next),
	.sel(ifm_sel),
	.dout_1(ifm_address_read_B_next_dMuxOut1),
	.dout_2(ifm_address_read_B_next_dMuxOut2),
	.dout_3(ifm_address_read_B_next_dMuxOut3),
	.dout_4(ifm_address_read_B_next_dMuxOut4),
	.dout_5(ifm_address_read_B_next_dMuxOut5),
	.dout_6(ifm_address_read_B_next_dMuxOut6)
    );
    

    always @*
    begin

        case(ifm_sel)
        
        3'd0:
        begin

            data_out_for_previous1 = Data_Output_B_Mem1;   
            data_out_for_previous2 = Data_Output_B_Mem2;   
            data_out_for_previous3 = Data_Output_B_Mem3;   

            data_out_A_for_next1   = Data_Output_A_Mem16;
            data_out_B_for_next1   = Data_Output_B_Mem16;

			data_out_A_for_next2   = 0;
            data_out_B_for_next2   = 0;	
			
			data_out_A_for_next3   = 0;
            data_out_B_for_next3   = 0;

        end
        
        3'd1:
        begin

            data_out_for_previous1 = Data_Output_B_Mem4;   
            data_out_for_previous2 = Data_Output_B_Mem5;   
            data_out_for_previous3 = Data_Output_B_Mem6;   

            data_out_A_for_next1   = Data_Output_A_Mem1;
            data_out_B_for_next1   = Data_Output_B_Mem1;   

            data_out_A_for_next2   = Data_Output_A_Mem2;
            data_out_B_for_next2   = Data_Output_B_Mem2;   

            data_out_A_for_next3   = Data_Output_A_Mem3;
            data_out_B_for_next3   = Data_Output_B_Mem3;   

        end
        
        3'd2:
        begin

            data_out_for_previous1 = Data_Output_B_Mem7;   
            data_out_for_previous2 = Data_Output_B_Mem8;   
            data_out_for_previous3 = Data_Output_B_Mem9;   

            data_out_A_for_next1   = Data_Output_A_Mem4;
            data_out_B_for_next1   = Data_Output_B_Mem4;   

            data_out_A_for_next2   = Data_Output_A_Mem5;
            data_out_B_for_next2   = Data_Output_B_Mem5;   

            data_out_A_for_next3   = Data_Output_A_Mem6;
            data_out_B_for_next3   = Data_Output_B_Mem6;   

        end
        
        3'd3:
        begin

            data_out_for_previous1 = Data_Output_B_Mem10;   
            data_out_for_previous2 = Data_Output_B_Mem11;   
            data_out_for_previous3 = Data_Output_B_Mem12;   

            data_out_A_for_next1   = Data_Output_A_Mem7;
            data_out_B_for_next1   = Data_Output_B_Mem7;
			
			data_out_A_for_next2   = Data_Output_A_Mem8;
            data_out_B_for_next2   = Data_Output_B_Mem8;   

            data_out_A_for_next3   = Data_Output_A_Mem9;
            data_out_B_for_next3   = Data_Output_B_Mem9;   

        end
        
        3'd4:
        begin

            data_out_for_previous1 = Data_Output_B_Mem13;   
            data_out_for_previous2 = Data_Output_B_Mem14;   
            data_out_for_previous3 = Data_Output_B_Mem15;   

            data_out_A_for_next1   = Data_Output_A_Mem10;
            data_out_B_for_next1   = Data_Output_B_Mem10;   

            data_out_A_for_next2   = Data_Output_A_Mem11;
            data_out_B_for_next2   = Data_Output_B_Mem11;   

            data_out_A_for_next3   = Data_Output_A_Mem12;
            data_out_B_for_next3   = Data_Output_B_Mem12;   

        end
        
        default:
        begin

            data_out_for_previous1 = Data_Output_B_Mem16;   
            data_out_for_previous2 = 0;   
            data_out_for_previous3 = 0;   

            data_out_A_for_next1   = Data_Output_A_Mem13;
            data_out_B_for_next1   = Data_Output_B_Mem13;   

            data_out_A_for_next2   = Data_Output_A_Mem14;
            data_out_B_for_next2   = Data_Output_B_Mem14;   
  
            data_out_A_for_next3   = Data_Output_A_Mem15;
            data_out_B_for_next3   = Data_Output_B_Mem15;   

        end
        
        endcase
        
	end

mem_unit #( .DATA_WIDTH(DATA_WIDTH),.IFM_SIZE(IFM_SIZE))
M1 (  .clk(clk),
      .Data_Input_A_Mem1 (data_in_from_previous1),
      .Data_Input_B_Mem1 ('b0),
      .Data_Input_A_Mem2 (data_in_from_previous2),
      .Data_Input_B_Mem2 ('b0),
      .Data_Input_A_Mem3 (data_in_from_previous3),
      .Data_Input_B_Mem3 ('b0),
      
      .Address_A ( ifm_address_write_previous_dMuxOut1 | ifm_address_read_A_next_dMuxOut2 ),
      .Address_B ( ifm_address_read_previous_dMuxOut1  | ifm_address_read_B_next_dMuxOut2 ),
      
      .Enable_Write_A_Mem (ifm_enable_write_previous_dMuxOut1),
      .Enable_Read_A_Mem  (ifm_enable_read_A_next_dMuxOut2),
      .Enable_Write_B_Mem (1'b0),
      .Enable_Read_B_Mem  (ifm_enable_read_previous_dMuxOut1 | ifm_enable_read_B_next_dMuxOut2),
      
      .Data_Output_A_Mem1 (Data_Output_A_Mem1),
      .Data_Output_B_Mem1 (Data_Output_B_Mem1),
      .Data_Output_A_Mem2 (Data_Output_A_Mem2),
      .Data_Output_B_Mem2 (Data_Output_B_Mem2),
      .Data_Output_A_Mem3 (Data_Output_A_Mem3),
      .Data_Output_B_Mem3 (Data_Output_B_Mem3)
      );
      
mem_unit #( .DATA_WIDTH(DATA_WIDTH),.IFM_SIZE(IFM_SIZE))
  M2( .clk(clk),
      .Data_Input_A_Mem1 (data_in_from_previous1),
      .Data_Input_B_Mem1 (0),
      .Data_Input_A_Mem2 (data_in_from_previous2),
      .Data_Input_B_Mem2 (0),
      .Data_Input_A_Mem3 (data_in_from_previous3),
      .Data_Input_B_Mem3 (0),
      
      .Address_A ( ifm_address_write_previous_dMuxOut2 | ifm_address_read_A_next_dMuxOut3 ),
      .Address_B ( ifm_address_read_previous_dMuxOut2  | ifm_address_read_B_next_dMuxOut3 ),
      
      .Enable_Write_A_Mem (ifm_enable_write_previous_dMuxOut2),
      .Enable_Read_A_Mem  (ifm_enable_read_A_next_dMuxOut3),
      .Enable_Write_B_Mem (1'b0),
      .Enable_Read_B_Mem  (ifm_enable_read_previous_dMuxOut2 | ifm_enable_read_B_next_dMuxOut3),
      
      .Data_Output_A_Mem1 (Data_Output_A_Mem4),
      .Data_Output_B_Mem1 (Data_Output_B_Mem4),
      .Data_Output_A_Mem2 (Data_Output_A_Mem5),
      .Data_Output_B_Mem2 (Data_Output_B_Mem5),
      .Data_Output_A_Mem3 (Data_Output_A_Mem6),
      .Data_Output_B_Mem3 (Data_Output_B_Mem6)
      );
      
mem_unit #( .DATA_WIDTH(DATA_WIDTH),.IFM_SIZE(IFM_SIZE))
  M3( .clk(clk),
      .Data_Input_A_Mem1 (data_in_from_previous1),
      .Data_Input_B_Mem1 (0),
      .Data_Input_A_Mem2 (data_in_from_previous2),
      .Data_Input_B_Mem2 (0),
      .Data_Input_A_Mem3 (data_in_from_previous3),
      .Data_Input_B_Mem3 (0),
      
      .Address_A ( ifm_address_write_previous_dMuxOut3 | ifm_address_read_A_next_dMuxOut4 ),
      .Address_B ( ifm_address_read_previous_dMuxOut3  | ifm_address_read_B_next_dMuxOut4 ),
      
      .Enable_Write_A_Mem (ifm_enable_write_previous_dMuxOut3),
      .Enable_Read_A_Mem  (ifm_enable_read_A_next_dMuxOut4),
      .Enable_Write_B_Mem (1'b0),
      .Enable_Read_B_Mem  (ifm_enable_read_previous_dMuxOut3 | ifm_enable_read_B_next_dMuxOut4),
      
      .Data_Output_A_Mem1 (Data_Output_A_Mem7),
      .Data_Output_B_Mem1 (Data_Output_B_Mem7),
      .Data_Output_A_Mem2 (Data_Output_A_Mem8),
      .Data_Output_B_Mem2 (Data_Output_B_Mem8),
      .Data_Output_A_Mem3 (Data_Output_A_Mem9),
      .Data_Output_B_Mem3 (Data_Output_B_Mem9)
      )  ; 
         
mem_unit #( .DATA_WIDTH(DATA_WIDTH),.IFM_SIZE(IFM_SIZE))
  M4( .clk(clk),
      .Data_Input_A_Mem1 (data_in_from_previous1),
      .Data_Input_B_Mem1 (0),
      .Data_Input_A_Mem2 (data_in_from_previous2),
      .Data_Input_B_Mem2 (0),
      .Data_Input_A_Mem3 (data_in_from_previous3),
      .Data_Input_B_Mem3 (0),
      
      .Address_A ( ifm_address_write_previous_dMuxOut4 | ifm_address_read_A_next_dMuxOut5 ),
      .Address_B ( ifm_address_read_previous_dMuxOut4  | ifm_address_read_B_next_dMuxOut5 ),
      
      .Enable_Write_A_Mem (ifm_enable_write_previous_dMuxOut4),
      .Enable_Read_A_Mem  (ifm_enable_read_A_next_dMuxOut5),
      .Enable_Write_B_Mem (1'b0),
      .Enable_Read_B_Mem  (ifm_enable_read_previous_dMuxOut4 | ifm_enable_read_B_next_dMuxOut5),
      
      .Data_Output_A_Mem1 (Data_Output_A_Mem10),
      .Data_Output_B_Mem1 (Data_Output_B_Mem10),
      .Data_Output_A_Mem2 (Data_Output_A_Mem11),
      .Data_Output_B_Mem2 (Data_Output_B_Mem11),
      .Data_Output_A_Mem3 (Data_Output_A_Mem12),
      .Data_Output_B_Mem3 (Data_Output_B_Mem12)
      )   ; 
	  
mem_unit #( .DATA_WIDTH(DATA_WIDTH),.IFM_SIZE(IFM_SIZE))
  M5( .clk(clk),
      .Data_Input_A_Mem1 (data_in_from_previous1),
      .Data_Input_B_Mem1 (0),
      .Data_Input_A_Mem2 (data_in_from_previous2),
      .Data_Input_B_Mem2 (0),
      .Data_Input_A_Mem3 (data_in_from_previous3),
      .Data_Input_B_Mem3 (0),
      
      .Address_A ( ifm_address_write_previous_dMuxOut5 | ifm_address_read_A_next_dMuxOut6 ),
      .Address_B ( ifm_address_read_previous_dMuxOut5  | ifm_address_read_B_next_dMuxOut6 ),
      
      .Enable_Write_A_Mem (ifm_enable_write_previous_dMuxOut5),
      .Enable_Read_A_Mem  (ifm_enable_read_A_next_dMuxOut6),
      .Enable_Write_B_Mem (1'b0),
      .Enable_Read_B_Mem  (ifm_enable_read_previous_dMuxOut5 | ifm_enable_read_B_next_dMuxOut6),
      
      .Data_Output_A_Mem1 (Data_Output_A_Mem13),
      .Data_Output_B_Mem1 (Data_Output_B_Mem13),
      .Data_Output_A_Mem2 (Data_Output_A_Mem14),
      .Data_Output_B_Mem2 (Data_Output_B_Mem14),
      .Data_Output_A_Mem3 (Data_Output_A_Mem15),
      .Data_Output_B_Mem3 (Data_Output_B_Mem15)
      )  ; 

	TrueDualPort_Memory #(.DATA_WIDTH(DATA_WIDTH), .MEM_SIZE(IFM_SIZE*IFM_SIZE)) 
	convA2_IFM16 (
    .clk(clk),
    
    .Data_Input_A(data_in_from_previous1),
    .Address_A ( ifm_address_write_previous_dMuxOut6 | ifm_address_read_A_next_dMuxOut1 ),
    .Enable_Write_A (ifm_enable_write_previous_dMuxOut6),
    .Enable_Read_A (ifm_enable_read_A_next_dMuxOut1 ),
      
    .Data_Input_B(0),
    .Address_B ( ifm_address_read_previous_dMuxOut6  | ifm_address_read_B_next_dMuxOut1 ),
    .Enable_Write_B (1'b0),
    .Enable_Read_B  ( ifm_enable_read_previous_dMuxOut6 | ifm_enable_read_B_next_dMuxOut1), 
  
    .Data_Output_A(Data_Output_A_Mem16),
    .Data_Output_B(Data_Output_B_Mem16)
	);
	 
	
endmodule

