`timescale 1ns / 1ps

module ConvB_CU #(parameter  DATA_WIDTH           = 32,
                             ADDRESS_BITS          = 15,
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
                             ADDRESS_SIZE_WM         = $clog2(KERNAL_SIZE*KERNAL_SIZE*IFM_DEPTH*(NUMBER_OF_FILTERS/NUMBER_OF_UNITS+1)),       
                             FIFO_SIZE               = (KERNAL_SIZE-1)*IFM_SIZE + KERNAL_SIZE,
                             NUMBER_OF_IFM           = 2,
                             NUMBER_OF_IFM_NEXT      = NUMBER_OF_FILTERS,
                             NUMBER_OF_WM            = KERNAL_SIZE*KERNAL_SIZE)
(
    input  clk,
    input  reset,
   
    input  end_from_next,
    input  start_from_previous,
    input  conv_ready,
    output reg end_to_previous,
    
    output reg ifm_enable_read_current,
    output reg [ADDRESS_SIZE_IFM-1:0] ifm_address_read_current,
    
    output reg wm_addr_sel,
    output reg wm_enable_read,
    output reg [ADDRESS_SIZE_WM-1:0] wm_address_read_current,
    output reg wm_fifo_enable,

    output reg bm_addr_sel,
    output reg bm_enable_read,
    output reg [$clog2(NUMBER_OF_FILTERS)-1:0] bm_address_read_current,
    
    output reg fifo_enable,
    output conv_enable,
    output accu_enable,
    output relu_enable,
    
    output ifm_enable_read_next,
    output ifm_enable_write_next,
    output reg  [ADDRESS_SIZE_NEXT_IFM-1:0] ifm_address_read_next,
    output wire [ADDRESS_SIZE_NEXT_IFM-1:0] ifm_address_write_next,
    output reg start_to_next,
    output reg [$clog2(NUMBER_OF_IFM_NEXT/NUMBER_OF_UNITS+1)-1:0] ifm_sel_next
    );
    
    reg  ifm_start_counter_read_address;
    wire ifm_address_read_current_tick;
    
    wire wm_address_read_current_tick;
        
    reg  fifo_enable_sig1;
    
    reg  [$clog2(NUMBER_OF_FILTERS/NUMBER_OF_UNITS+1)-1 : 0] filters_counter;
    wire filters_counter_tick;
    
    reg  [$clog2(IFM_DEPTH)-1 : 0] depth_counter;
    wire depth_counter_tick;
    
    reg  [$clog2(NUMBER_OF_FILTERS/NUMBER_OF_UNITS+1)-1 : 0] psums_counter_next;
    wire psums_counter_next_tick;
    wire ifm_sel_next_tick;
    
    reg mem_empty;
    wire signal_hold;
    reg Enable1_reg,Enable2_reg,Enable3_reg,Enable4_reg,Enable5_reg,Enable6_reg;
    wire ifm_address_write_next_tick;
	wire ifm_sel_en;
    
    localparam [1:0]   IDLE   = 2'b00,
                       READ   = 2'b01,
                       FINISH = 2'b10,
                       HOLD   = 2'b11;
                      
    reg [1:0] state_reg, state_next;  
              
    always @(posedge clk, posedge reset)
    begin
        if(reset)
            state_reg <= IDLE;       
        else
            state_reg <= state_next;
    end

    always @*
    begin 
        state_next                     = state_reg;
        
        case(state_reg)
         
        IDLE : 
        begin
            ifm_enable_read_current        = 1'b0;
            ifm_start_counter_read_address = 1'b0;
    
            wm_addr_sel                    = 1'b0;
            
            bm_addr_sel                    = 1'b0;
            bm_enable_read                 = 1'b0;
      
            fifo_enable_sig1               = 1'b0;
            
            end_to_previous                = 1'b1;
              
            if(start_from_previous)
                state_next = READ;
        end                    
 
        READ : 
        begin // Read From Memory 
            ifm_enable_read_current        = 1'b1;
            ifm_start_counter_read_address = 1'b1;
    
            wm_addr_sel                    = 1'b1;
            
            bm_addr_sel                    = 1'b1;
            bm_enable_read                 = 1'b1 & (depth_counter==0);
            
            fifo_enable_sig1               = 1'b1;
            
            end_to_previous                = 1'b0;
            
            if(signal_hold & ( ~mem_empty | ~conv_ready) )
                state_next = HOLD;
                    
            else if(depth_counter_tick)
                state_next = IDLE;
                    
	        else if(ifm_address_read_current_tick)
                state_next = FINISH;
        end
                
        FINISH : 
        begin 
            ifm_enable_read_current        = 1'b0;
            ifm_start_counter_read_address = 1'b0;
    
            wm_addr_sel                    = 1'b1;
      
            bm_addr_sel                    = 1'b1;
            bm_enable_read                 = 1'b0;
            
            fifo_enable_sig1               = 1'b0;
            
            end_to_previous                = 1'b1 & ~(|filters_counter);

	        if(start_from_previous | (|filters_counter) )
                state_next = READ;
        end
        
        HOLD :
        begin
            ifm_enable_read_current        = 1'b0;
            ifm_start_counter_read_address = 1'b0;
    
            wm_addr_sel                    = 1'b0;
            
            bm_addr_sel                    = 1'b0;
            bm_enable_read                 = 1'b0;
            
            fifo_enable_sig1               = 1'b0;
            
            end_to_previous                = 1'b0;
            
            if ( mem_empty & conv_ready ) 
                state_next = READ;
        end
        
        endcase
    end  
	
	assign ifm_sel_en = (depth_counter==IFM_DEPTH-1) ? start_to_next : ifm_address_write_next_tick ;
	
	always @(posedge clk, posedge reset)
    begin
        if(reset)
            ifm_sel_next <= 0;
        else if (ifm_sel_next == ( (NUMBER_OF_IFM_NEXT/NUMBER_OF_UNITS +1) -1) & ifm_address_write_next_tick)
            ifm_sel_next <= 0;
        else if( ifm_sel_en )
            ifm_sel_next <= ifm_sel_next +  1; 
    end
    assign ifm_sel_next_tick = (ifm_sel_next == ( (NUMBER_OF_IFM_NEXT/NUMBER_OF_UNITS +1) -1) & ifm_address_write_next_tick);
    
    always @(posedge clk, posedge reset)
    begin
        if(reset)
            ifm_address_read_current <= 0;
        else if(ifm_address_read_current == IFM_SIZE*IFM_SIZE-1)
            ifm_address_read_current <= 0 ;
        else if(ifm_start_counter_read_address)
            ifm_address_read_current <= (ifm_address_read_current + 1'b1);      
    end
  
    assign ifm_address_read_current_tick = (ifm_address_read_current == IFM_SIZE*IFM_SIZE-1);
    assign signal_hold = ( ifm_address_read_current == FIFO_SIZE-3 );
    
    always @(posedge clk, posedge reset)
    begin
        if(reset)
            wm_enable_read <= 1'b0;
        else if( (ifm_address_read_current == 1) )/// will fail if IFM_SIZE = KERNAL_SIZE
            wm_enable_read <= 1'b1;
        else if( (ifm_address_read_current == KERNAL_SIZE*KERNAL_SIZE+1) | (state_reg==IDLE) )
            wm_enable_read <= 1'b0;
    end

    always @(posedge clk, posedge reset)
    begin
        if(reset)
            wm_address_read_current <= 0;
        else if(wm_enable_read)
            wm_address_read_current <= wm_address_read_current + 1'b1;
        else if(state_reg==IDLE) 
            wm_address_read_current <= 0;      
    end
    
    assign wm_address_read_current_tick  = (wm_address_read_current == NUMBER_OF_FILTERS*IFM_DEPTH-1);
   
    always @(posedge clk, posedge reset)
    begin
        if(reset)
            bm_address_read_current <= 0;
        else if(bm_address_read_current == ( (NUMBER_OF_FILTERS/NUMBER_OF_UNITS+1) -1) & ifm_address_write_next_tick)
            bm_address_read_current <= 0;
        else if(ifm_address_write_next_tick)
            bm_address_read_current <= bm_address_read_current + 1'b1;      
    end
    
    always @(posedge clk, posedge reset)
    begin
        if(reset)
            filters_counter <= 0;
        else if( filters_counter == ((NUMBER_OF_FILTERS/NUMBER_OF_UNITS+1)-1) & ifm_address_read_current_tick )
            filters_counter <= 0;
        else if(ifm_address_read_current_tick)
            filters_counter <= filters_counter + 1'b1;
    end
    
    assign filters_counter_tick = (filters_counter == ((NUMBER_OF_FILTERS/NUMBER_OF_UNITS+1)-1) & ifm_address_read_current_tick);
    
    always @(posedge clk, posedge reset)
    begin
        if(reset)
            depth_counter <= 0;
        else if(depth_counter == (IFM_DEPTH-1) & filters_counter_tick)
            depth_counter <= 0 ;
        else if(filters_counter_tick)
            depth_counter <= depth_counter+ 1'b1;      
    end
  
    assign depth_counter_tick = (depth_counter == (IFM_DEPTH-1) & filters_counter_tick);
  
    always @(posedge clk, posedge reset)
    begin
        if(reset)
            psums_counter_next <= 0;
        else if(psums_counter_next == ( (NUMBER_OF_FILTERS/NUMBER_OF_UNITS+1) -1) & ifm_sel_next_tick)
            psums_counter_next <= 0 ;
        else if(ifm_sel_next_tick)
            psums_counter_next <= psums_counter_next + 1'b1;      
    end
    assign psums_counter_next_tick = (psums_counter_next == ( (NUMBER_OF_FILTERS/NUMBER_OF_UNITS+1) -1) & ifm_sel_next_tick);
    
    assign accu_enable = ( psums_counter_next != 0 );
    assign relu_enable = ( psums_counter_next == (NUMBER_OF_FILTERS/NUMBER_OF_UNITS+1) -1 );
    
    
    always @(posedge clk)
    begin
        fifo_enable    <= fifo_enable_sig1;
        wm_fifo_enable <= wm_enable_read;
    end 
    
    ///////////////////////
    // FIFO Control Unit //
    ///////////////////////
    reg start_counter_fifo;
    reg [$clog2(FIFO_SIZE)-1:0] counter_fifo;
    wire counter_fifo_tick;
    reg start_counter_ready;
    reg [$clog2(IFM_SIZE-(KERNAL_SIZE-1))-1:0] counter_ready;
    wire counter_ready_tick;
    reg start_counter_not_ready;
    reg [$clog2(KERNAL_SIZE-1)-1:0] counter_not_ready;
    wire counter_not_ready_tick;
    reg fifo_output_ready;
    
    localparam [1:0] FIFO_IDLE      = 2'b00,
                     FIFO_READY     = 2'b01,
                     FIFO_NOT_READY = 2'b10;
                     
    
    reg [1:0] fifo_state_reg, fifo_state_next;
     
    always @(posedge clk, posedge reset)
    begin
        if(reset)
            fifo_state_reg <= FIFO_IDLE;       
        else
            fifo_state_reg <= fifo_state_next;
    end
    
    always @*
    begin 
        fifo_state_next = fifo_state_reg;

        case(fifo_state_reg)
         
        FIFO_IDLE : 
        begin
            fifo_output_ready       = 1'b0;
            start_counter_fifo      = 1'b1;
            start_counter_ready     = 1'b0; 
            start_counter_not_ready = 1'b0;
            if(counter_fifo_tick)
                fifo_state_next = FIFO_READY;       
        end
        
        FIFO_READY : 
        begin // Output READY
            fifo_output_ready       = 1'b1;
            start_counter_fifo      = 1'b0;
            start_counter_ready     = 1'b1; 
            start_counter_not_ready = 1'b0;
            if( (~fifo_enable) )
                fifo_state_next = FIFO_IDLE;
            else if (counter_ready_tick)
                fifo_state_next = FIFO_NOT_READY;           
        end
        
        FIFO_NOT_READY : 
        begin // Output Not READY 
      
            fifo_output_ready       = 1'b0;
            start_counter_fifo      = 1'b0;
            start_counter_ready     = 1'b0; 
            start_counter_not_ready = 1'b1; 
            if( (~fifo_enable) )
                fifo_state_next = FIFO_IDLE;
            if (counter_not_ready_tick)  
                fifo_state_next = FIFO_READY;     
        end
        
        default :
        begin
            fifo_output_ready       = 1'b0;
            start_counter_fifo      = 1'b0;
            start_counter_ready     = 1'b0;
            start_counter_not_ready = 1'b0;
            fifo_state_next         = FIFO_IDLE;
        end
        
        endcase
    end
    
    always @(posedge clk, posedge reset)
    begin
        if(reset)
            counter_fifo <= 0;       
        else if(counter_fifo == FIFO_SIZE-1)
            counter_fifo <= 0;
        else if(fifo_enable & start_counter_fifo)
            counter_fifo <= counter_fifo + 1'b1;
    end
    assign  counter_fifo_tick = (counter_fifo == FIFO_SIZE-1);
    
    always @(posedge clk, posedge reset)
    begin
        if(reset)
            counter_ready <= 0;       
        else if(start_counter_ready)
            counter_ready <= counter_ready + 1'b1;
        else
            counter_ready <= 0;
    end
    assign  counter_ready_tick = (counter_ready == IFM_SIZE-(KERNAL_SIZE-1)-1);
    
    always @(posedge clk, posedge reset)
    begin
        if(reset)
            counter_not_ready <= 0;

        else if(start_counter_not_ready)
            counter_not_ready <= counter_not_ready + 1'b1;
        else
            counter_not_ready <= 0;
    end
    assign  counter_not_ready_tick = (counter_not_ready == (KERNAL_SIZE-1)-1);
    
    assign conv_enable = fifo_output_ready;
    
    
    ////////////////////////
    // address write next //
    ////////////////////////
    
    
    always @(posedge clk, posedge reset)
    begin
        if(reset)
            ifm_address_read_next <= {ADDRESS_SIZE_NEXT_IFM{1'b0}}; 
        else if(ifm_address_read_next == IFM_SIZE_NEXT*IFM_SIZE_NEXT)
            ifm_address_read_next <= 0;      
        else if(ifm_enable_read_next)
            ifm_address_read_next <= ifm_address_read_next + 1'b1;
    end

    assign ifm_address_write_next = ifm_address_read_next - 1;
    assign ifm_address_write_next_tick = (ifm_address_write_next == IFM_SIZE_NEXT*IFM_SIZE_NEXT-1);

    always @(posedge clk )
    begin
        Enable1_reg <= conv_enable;
        Enable2_reg <= Enable1_reg;
        Enable3_reg <= Enable2_reg;  
        Enable4_reg <= Enable3_reg;
		Enable5_reg <= Enable4_reg; 
		Enable6_reg <= Enable5_reg;
    end 
    
    assign ifm_enable_read_next  = Enable5_reg;
    assign ifm_enable_write_next = Enable6_reg;
            
    //////////////////////////
    ////// start to next /////
    //////////////////////////
     localparam  s0   = 1'b0,
                 s1   = 1'b1;	  
							  
    reg state_reg2, state_next2; 
    
    always @(posedge clk, posedge reset)
    begin
        if(reset)
            state_reg2 <= s0;       
        else
            state_reg2 <= state_next2;
    end

    always @*
    begin     
        state_next2 = state_reg2;
        		
        case(state_reg2)
        
        s0 : 
        begin
            start_to_next = 1'b0;
            mem_empty     = 1'b1;
            if( (psums_counter_next == ( (NUMBER_OF_FILTERS/NUMBER_OF_UNITS+1) -1) & ifm_address_write_next_tick) )
                state_next2 = s1;          
        end
        
        s1 : 
        begin 
            if ( end_from_next )
            begin
                start_to_next = 1'b1;
                mem_empty     = 1'b1;
                state_next2    = s0;
            end
            else 
            begin
                start_to_next = 1'b0;
                mem_empty     = 1'b0;
                state_next2    = s1;  
            end      
        end
        
        endcase
    end
    
endmodule