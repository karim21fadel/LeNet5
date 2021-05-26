module FIFO_10outputs_FC2 #(parameter DATA_WIDTH   = 32,
                                      ADDRESS_BITS = 11,
                                      /////////////////////////////////////
	                                  IFM_SIZE              = 14,                                                
                                      IFM_DEPTH             = 3,
							          KERNAL_SIZE           = 5,
		                              NUMBER_OF_FILTERS     = 2,
		                              //////////////////////////////////////
							          IFM_SIZE_NEXT           = IFM_SIZE - KERNAL_SIZE + 1,
                                      ADDRESS_SIZE_IFM        = $clog2(IFM_SIZE*IFM_SIZE),
                                      ADDRESS_SIZE_NEXT_IFM   = $clog2(IFM_SIZE_NEXT*IFM_SIZE_NEXT),
                                      ADDRESS_SIZE_WM         = $clog2(IFM_DEPTH*NUMBER_OF_FILTERS),
                                      NUMBER_OF_IFM           = IFM_DEPTH,      
                                      FIFO_SIZE               = (KERNAL_SIZE-1)*IFM_SIZE + KERNAL_SIZE,
                                      NUMBER_OF_IFM_NEXT      = NUMBER_OF_FILTERS,
                                      NUMBER_OF_WM            = KERNAL_SIZE*KERNAL_SIZE,                              
                                      NUMBER_OF_BITS_SEL_IFM_NEXT =$clog2(NUMBER_OF_IFM_NEXT))
    (
       input  clk,
       input  [DATA_WIDTH-1:0] fifo_data_in,
       input  fifo_enable,
       output [DATA_WIDTH-1:0] fifo_data_out_1,     
       output [DATA_WIDTH-1:0] fifo_data_out_2,  
       output [DATA_WIDTH-1:0] fifo_data_out_3,  
       output [DATA_WIDTH-1:0] fifo_data_out_4,  
       output [DATA_WIDTH-1:0] fifo_data_out_5,  
       output [DATA_WIDTH-1:0] fifo_data_out_6,  
       output [DATA_WIDTH-1:0] fifo_data_out_7,  
       output [DATA_WIDTH-1:0] fifo_data_out_8,  
       output [DATA_WIDTH-1:0] fifo_data_out_9,  
       output [DATA_WIDTH-1:0] fifo_data_out_10
    );
    
    reg [DATA_WIDTH-1:0] FIFO  [10-1:0];
  
   
    integer i;
    always @ (posedge clk)
    begin
       if(fifo_enable)
        begin
            for( i=0; i<10; i=i+1)
            begin 
                FIFO[i+1]<=FIFO[i];
            end
                FIFO[0]<=fifo_data_in;    
        end
    end
    
    assign fifo_data_out_10 = FIFO[0];
    assign fifo_data_out_9  = FIFO[1];
    assign fifo_data_out_8  = FIFO[2];
    assign fifo_data_out_7  = FIFO[3];
    assign fifo_data_out_6  = FIFO[4];
    assign fifo_data_out_5  = FIFO[5];
    assign fifo_data_out_4  = FIFO[6];
    assign fifo_data_out_3  = FIFO[7];
    assign fifo_data_out_2  = FIFO[8];
    assign fifo_data_out_1  = FIFO[9];
       
           
endmodule    