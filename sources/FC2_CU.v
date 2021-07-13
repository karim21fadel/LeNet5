`timescale 1ns / 1ps


module FC2_CU #(parameter DATA_WIDTH      = 32,
                              ADDRESS_BITS    = 11,
                              ////////////////////////////////////
                              IFM_DEPTH       = 84,                             
                              IFM_SIZE        = 1,
                              ADDRESS_SIZE_WM = $clog2(IFM_DEPTH),      
                              NUMBER_OF_WM    = 10 )
    (
    input clk,
    input reset, 
    ///////////////////////////////////
    input start_from_previous,
    output reg  end_to_previous, 
    ///////////////////////////////////
    output reg wm_addr_sel,
    output reg wm_enable_read,
    output reg [ADDRESS_SIZE_WM-1:0] wm_address_read_current,
    ///////////////////////////////////
    output bias_sel,
    output reg enable_read_current,  
    output [ ADDRESS_SIZE_WM-1:0] sel_ifm,
    output fc_output_ready,  
    output enable_write_next,      
    output output_ready
    );
       
  
    localparam [1:0]   IDLE     = 2'b00,
                       READ     = 2'b01,
                       FINISH   = 2'b10,
                       HOLD     = 2'b11;
					   
    reg [1:0] state_reg, state_next;
    
    reg  start_wm_counter_read_address;
	wire wm_address_read_current_tick; 
	reg  bias_sel_sig;	
	
    always @(posedge clk, posedge reset)
     begin
        if(reset)
            state_reg <= IDLE;        
        else
            state_reg <= state_next;
     end
    
  always @*
  begin 
        enable_read_current           = 1'b0;  
		bias_sel_sig                  = 1'b0;
		wm_addr_sel                   = 1'b0;
        wm_enable_read                = 1'b0;
		end_to_previous               = 1'b1;        
        start_wm_counter_read_address = 1'b0;
        		
        state_next                    = state_reg;
		
        case(state_reg)
         
        IDLE : 
        begin
			enable_read_current           = 1'b0;  
			bias_sel_sig                  = 1'b1;
			wm_addr_sel                   = 1'b0;
			wm_enable_read                = 1'b0;
			end_to_previous               = 1'b1;        
			start_wm_counter_read_address = 1'b0;
                                
            if(start_from_previous)
                state_next = READ;          
        end
        READ : 
        begin  
			enable_read_current           = 1'b1;  
			bias_sel_sig                  = 1'b0;
			wm_addr_sel                   = 1'b1;
			wm_enable_read                = 1'b1;
			end_to_previous               = 1'b0;        
			start_wm_counter_read_address = 1'b1;
        
            if (wm_address_read_current_tick)
				state_next = IDLE;
        end
        endcase
    end
  
  
	Register #(.DATA_WIDTH(1)) 
    R1 
    (.clk(clk),
     .reset(reset), 
     .Enable(1'b1),
     .Data_in(enable_read_current), 
     .Data_out(fc_output_ready)
    );
	
	Register #(.DATA_WIDTH(1)) 
    R2 
    (.clk(clk),
     .reset(reset), 
     .Enable(1'b1),
     .Data_in(fc_output_ready), 
     .Data_out(enable_write_next)
    );
	
	
	Delay #(.Delay_Data_Width(1), .delay_cycles(2)) 
    d1
    (.clk(clk),
     .reset(reset),
     .Data_In(bias_sel_sig), 
     .Data_Out(bias_sel)
    );
    
    Delay #(.Delay_Data_Width(1), .delay_cycles(3)) 
    d2
    (.clk(clk),
     .reset(reset), 
     .Data_In(wm_address_read_current_tick), 
     .Data_Out(output_ready)
    );
	
  
    always @(posedge clk, posedge reset)
    begin
        if(reset)
            wm_address_read_current <= 0;
        else if (wm_address_read_current == (IFM_DEPTH-1) & start_wm_counter_read_address )
            wm_address_read_current <= 0;
        else if(start_wm_counter_read_address)
            wm_address_read_current <= wm_address_read_current + 1'b1;
        
    end
    assign wm_address_read_current_tick = (wm_address_read_current == (IFM_DEPTH-1) & start_wm_counter_read_address );  
	
	assign sel_ifm = wm_address_read_current;

endmodule
