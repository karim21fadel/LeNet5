module reg_array #(parameter DATA_WIDTH =16)
(
  input clk ,reset ,
  /////////////////////////////////////////////////
  input  [DATA_WIDTH-1 : 0] data_in_from_previous,
  output [DATA_WIDTH-1 : 0] data_out_for_previous,
  input  enable_write_previous,
  input  enable_read_previous,
  
  ////////////////////////////////////////////////
  input   ifm_sel,
  output  [DATA_WIDTH-1 : 0]  data_out_for_next,
  input   enable_read_next
  );
  
  
    wire	[DATA_WIDTH - 1 : 0]	Data_Read_Reg1, Data_Read_Reg2;
		
	wire Write_En_Reg1, Write_En_Reg2;

	reg [DATA_WIDTH - 1 : 0] data_out_for_next_sig ,data_out_for_previous_sig;
	
	// Demux For Enable Write 
    assign Write_En_Reg1 = enable_write_previous & ~ifm_sel ;
    assign Write_En_Reg2 = enable_write_previous &  ifm_sel ;
    
	
	always @*
	begin
        if(ifm_sel)
        begin
            data_out_for_next_sig     = Data_Read_Reg1; 	   
	        data_out_for_previous_sig = Data_Read_Reg2; 
        end
    
        else
        begin
            data_out_for_next_sig     = Data_Read_Reg2;   
            data_out_for_previous_sig = Data_Read_Reg1; 	        
        end
    end
	
	
   Register #(.DATA_WIDTH(DATA_WIDTH)) R1 (.clk(clk),.reset(reset),.Data_in(data_in_from_previous),.Enable(Write_En_Reg1),.Data_out(Data_Read_Reg1)); 
   Register #(.DATA_WIDTH(DATA_WIDTH)) R2 (.clk(clk),.reset(reset),.Data_in(data_in_from_previous),.Enable(Write_En_Reg2),.Data_out(Data_Read_Reg2));  
   
   Register #(.DATA_WIDTH(DATA_WIDTH)) R3 (.clk(clk),.reset(reset),.Data_in(data_out_for_next_sig),.Enable(enable_read_next),.Data_out(data_out_for_next)); 
   Register #(.DATA_WIDTH(DATA_WIDTH)) R4 (.clk(clk),.reset(reset),.Data_in(data_out_for_previous_sig),.Enable(enable_read_previous),.Data_out(data_out_for_previous));
   
   endmodule
