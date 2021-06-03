`timescale 1ns / 1ps


module TOP_FC2_CU #(parameter DATA_WIDTH      = 32,
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
    output reg wm_addr_sel,
    output reg [ADDRESS_SIZE_WM-1:0] wm_address_read_current,
    output reg wm_enable_read,
    output fc2_bias_sel,
    ///////////////////////////////////
    output reg enable_read_fc,  
    output reg [ ADDRESS_SIZE_WM-1 :  0 ] sel_ifm,
    output reg  end_to_previous, 
    output ifm_enable_write_next,
    output Get_final_value
    //output reg sel_enable  
    );
       
  
    localparam [1:0]   IDLE     = 2'b00,
                       WORKING  = 2'b01,
                       FINISH   = 2'b10;
                       
	reg ifm_enable_write_nextt_reg;				  
    reg [1:0] state_reg, state_next;
    
    reg  start_counter_reading_address; 
    reg  start_counter_sel;  
    
    reg  Get_final_value_reg;
    wire Get_final_value_reg2;
    wire sel_tick,address_tick;       
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
        start_counter_sel             = 1'b0;   
        Get_final_value_reg           = 1'b0;
        ifm_enable_write_nextt_reg    = 1'b0;
        case(state_reg)
         
        IDLE : 
        begin
            wm_addr_sel                   = 1'b0;
            enable_read_fc                = 1'b0;  
            wm_enable_read                = 1'b0;
            end_to_previous               = 1'b1; 
            start_counter_reading_address = 1'b0;
            start_counter_sel             = 1'b0;
            ifm_enable_write_nextt_reg    = 1'b1;   
           // sel_enable                    = 1'b0;
            Get_final_value_reg           = 1'b0;            
                        
            if(start_from_previous)
                state_next=WORKING;          
        end
        WORKING : 
        begin // Read From Reg 1  
            wm_addr_sel                   = 1'b1;
            enable_read_fc                = 1'b1;  
            wm_enable_read                = 1'b1;
            end_to_previous               = 1'b0;  
            start_counter_reading_address = 1'b1;
            start_counter_sel             = 1'b1;     
            ifm_enable_write_nextt_reg    = 1'b1 ;
         //   sel_enable                    = 1'b1;            

            if (sel_tick & address_tick )
                begin 
                 Get_final_value_reg =1'b1;    
                 state_next = IDLE;
                end
        end
        endcase
    end

    

        
    always @(posedge clk, posedge reset)
      begin
        if(reset)
            wm_address_read_current <= 0;
        else if(start_counter_reading_address)
            wm_address_read_current <= wm_address_read_current + 1'b1;
        else if (wm_address_read_current == 83)
            wm_address_read_current <= 0;
      end
    
    always @(posedge clk, posedge reset)
    begin
        if(reset)
             sel_ifm <=0;
        else if(start_counter_sel)
             sel_ifm <= sel_ifm + 1'b1;
        else if(sel_ifm == 83)
             sel_ifm <= 0;
     end
    
 assign sel_tick  = (sel_ifm==83);  
 assign address_tick  = (wm_address_read_current==83);  
 assign fc2_bias_sel = (state_reg!=IDLE);

   
 Reg #(.DATA_WIDTH(1)) En1 ( .clk(clk),.reset(reset),.Data_in(ifm_enable_write_nextt_reg),.Data_out(ifm_enable_write_next)); 
 Reg #(.DATA_WIDTH(1)) En2 ( .clk(clk),.reset(reset),.Data_in(Get_final_value_reg),.Data_out(Get_final_value_reg2)); 
 Reg #(.DATA_WIDTH(1)) En3 ( .clk(clk),.reset(reset),.Data_in(Get_final_value_reg2),.Data_out(Get_final_value)); 

endmodule
