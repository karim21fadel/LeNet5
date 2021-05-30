module FIFO_4outputs #(parameter DATA_WIDTH          = 32,
                             /////////////////////////////////////
	                         IFM_SIZE              = 14,                                                
                             IFM_DEPTH             = 3,
							 KERNAL_SIZE           = 2,
		                     //////////////////////////////////////
							 IFM_SIZE_NEXT           = (IFM_SIZE - KERNAL_SIZE)/2 + 1,
                             ADDRESS_SIZE_IFM        = $clog2(IFM_SIZE*IFM_SIZE),
                             ADDRESS_SIZE_NEXT_IFM   = $clog2(IFM_SIZE_NEXT*IFM_SIZE_NEXT),      
                             FIFO_SIZE               = (KERNAL_SIZE-1)*IFM_SIZE + KERNAL_SIZE)
      (
       input wire clk,
       input wire reset,
       input wire [DATA_WIDTH-1:0] fifo_data_in_A,
       input wire [DATA_WIDTH-1:0] fifo_data_in_B,
       input wire fifo_enable,
       output [DATA_WIDTH-1:0] fifo_data_out_1,
       output [DATA_WIDTH-1:0] fifo_data_out_2,
       output [DATA_WIDTH-1:0] fifo_data_out_3,
       output [DATA_WIDTH-1:0] fifo_data_out_4      
      );
    
    reg [DATA_WIDTH-1:0] FIFO [ FIFO_SIZE-1 : 0] ; 

    integer i;
    always @ (posedge clk,posedge reset)
    begin
        if(reset)
		begin 	
		    for( i=0; i<FIFO_SIZE; i=i+1)
            begin 
                FIFO[i] <= 0;
            end
		end
		
        else if(fifo_enable)
        begin  
            FIFO[1] <= fifo_data_in_A;          
            FIFO[0] <= fifo_data_in_B;          
            for( i=0; i<(FIFO_SIZE/2-1); i=i+1)
            begin 
                FIFO[2*i+3] <= FIFO[2*i+1];
                FIFO[2*i+2] <= FIFO[2*i];
            end       
        end
    end 
 
    assign    fifo_data_out_1=FIFO[(KERNAL_SIZE-1)*IFM_SIZE+(KERNAL_SIZE-1)];
    assign    fifo_data_out_2=FIFO[(KERNAL_SIZE-1)*IFM_SIZE+(KERNAL_SIZE-2)];
    assign    fifo_data_out_3=FIFO[(KERNAL_SIZE-2)*IFM_SIZE+(KERNAL_SIZE-1)];
    assign    fifo_data_out_4=FIFO[(KERNAL_SIZE-2)*IFM_SIZE+(KERNAL_SIZE-2)];
 
endmodule