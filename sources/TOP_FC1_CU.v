`timescale 1ns / 1ps


module TOP_FC1_CU#(parameter DATA_WIDTH      = 32,
                             ADDRESS_BITS    = 11,
                             ////////////////////////////////////
                             IFM_DEPTH       = 120,
                             IFM_SIZE        = 1,
                             ADDRESS_SIZE_WM = $clog2(IFM_DEPTH),      
                             NUMBER_OF_WM    = 84
                  )
    (
    input clk,
    input reset, 
    /////////////////////////
    output reg wm_addr_sel,
    output reg [ADDRESS_SIZE_WM-1:0] wm_address_read_current,
    output reg wm_enable_read,
    output fc1_bias_sel,
    ///////////////////////////////////
    output reg enable_read_fc,
    input start_from_previous,
    output reg  ifm_sel,
    output reg  end_to_previous,
    input end_from_next,
    ////////////////////////////////////////
    output  ifm_enable_write_next,
	output  reg start_to_next
    );
       
  
    localparam [1:0]   IDLE     = 2'b00,
                       WORKING  = 2'b01,
                       FINISH   = 2'b10,
                       WAITING  = 2'b11;
					  
							  
    reg [1:0] state_reg, state_next;
    
    reg enable_write_memory_next_reg;
    wire signal_start_to_next;
    reg  start_counter_reading_address;          
   always @(posedge clk, posedge reset)
    begin
        if(reset)
            state_reg <= IDLE;        
        else
            state_reg <= state_next;
    end
    
  always @*
  begin 
        state_next                    = state_reg;
        wm_addr_sel                   = 1'b0;
        enable_read_fc                = 1'b0;  
        wm_enable_read                = 1'b0;
        end_to_previous               = 1'b1;
        start_counter_reading_address = 1'b0;
	    enable_write_memory_next_reg  = 1'b0;
	    
        case(state_reg)
         
        IDLE : 
        begin
            wm_addr_sel                   = 1'b0;
            enable_read_fc                = 1'b0;  
            wm_enable_read                = 1'b0;
            end_to_previous               = 1'b1;
            start_counter_reading_address = 1'b0;
             if ( ~fc1_bias_sel )
	           enable_write_memory_next_reg  = 1'b1;
	         else 
	           enable_write_memory_next_reg  = 1'b0;
            if(start_from_previous)
                state_next=WORKING;          
        end
        WORKING : 
        begin   
            wm_addr_sel                   = 1'b1;
            enable_read_fc                = 1'b1;  
            wm_enable_read                = 1'b1;
            end_to_previous               = 1'b0;  
            start_counter_reading_address = 1'b1; 
            enable_write_memory_next_reg  = 1'b1;                  
           //if (signal_start_to_next)
            //   state_next=IDLE;
          // else
             state_next = FINISH;
        end
        FINISH : 
        begin 
            wm_addr_sel                   = 1'b1;
            enable_read_fc                = 1'b0;  
            wm_enable_read                = 1'b0;
            end_to_previous               = 1'b1;                 
            start_counter_reading_address = 1'b0;          
            enable_write_memory_next_reg  = 1'b0;   
             if (start_from_previous) 
                state_next = WORKING;  
            else if (start_to_next)
                state_next=WAITING;
                      
        end
       WAITING :
          begin 
           end_to_previous               = 1'b0; 
           if (end_from_next) 
                state_next = IDLE;  
          end
     endcase
   end

  
   
   always @(posedge clk, posedge reset)
    begin
        if(reset)
            ifm_sel <= 0;
        else if (ifm_sel == 2)
            ifm_sel <= 0;
        else if(start_from_previous)
            ifm_sel <= ifm_sel + 1'b1; 
    end
      
  always @(posedge clk, posedge reset)
    begin
        if(reset)
            wm_address_read_current <= 0;
        else
          begin
            if(start_counter_reading_address)
                    wm_address_read_current <= wm_address_read_current + 1'b1;
            else if (wm_address_read_current == IFM_DEPTH)
                    wm_address_read_current <= 0;
         end
     end
     
    
    Reg  #(.DATA_WIDTH(1)) En ( .clk(clk),.reset(reset),.Data_in(enable_write_memory_next_reg),.Data_out(ifm_enable_write_next)); 
    assign signal_start_to_next= (wm_address_read_current == 120);
    assign fc1_bias_sel =  (state_reg==IDLE) ? 1'b0 : 1'b1;

    always @(posedge clk)
        start_to_next<=signal_start_to_next;
    
endmodule
