module FIFO_25outputs_A1 #(parameter DATA_WIDTH  = 32,
                             ADDRESS_BITS        = 15,
                             /////////////////////////////////////
	                         IFM_SIZE              = 14,                                                
                             IFM_DEPTH             = 3,
							 KERNAL_SIZE           = 5,
		                     NUMBER_OF_FILTERS     = 2,
							 NUMBER_OF_UNITS       = 3,
		                     //////////////////////////////////////
							 IFM_SIZE_NEXT           = IFM_SIZE - KERNAL_SIZE + 1,
                             ADDRESS_SIZE_IFM        = $clog2(IFM_SIZE*IFM_SIZE),
                             ADDRESS_SIZE_NEXT_IFM   = $clog2(IFM_SIZE_NEXT*IFM_SIZE_NEXT),
                             ADDRESS_SIZE_WM         = $clog2(KERNAL_SIZE*KERNAL_SIZE*NUMBER_OF_FILTERS),
                             NUMBER_OF_IFM           = IFM_DEPTH,      
                             FIFO_SIZE               = (KERNAL_SIZE-1)*IFM_SIZE + KERNAL_SIZE,
                             NUMBER_OF_IFM_NEXT      = NUMBER_OF_FILTERS,
                             NUMBER_OF_WM            = KERNAL_SIZE*KERNAL_SIZE,                              
                             NUMBER_OF_BITS_SEL_IFM_NEXT =$clog2(NUMBER_OF_IFM_NEXT))
    (
       input clk,
       input reset,
       input fifo_enable,
       input   [DATA_WIDTH-1:0] fifo_data_in,
       output  [DATA_WIDTH-1:0] fifo_data_out_1,
       output  [DATA_WIDTH-1:0] fifo_data_out_2,
       output  [DATA_WIDTH-1:0] fifo_data_out_3,
       output  [DATA_WIDTH-1:0] fifo_data_out_4,
       output  [DATA_WIDTH-1:0] fifo_data_out_5,
       output  [DATA_WIDTH-1:0] fifo_data_out_6,
       output  [DATA_WIDTH-1:0] fifo_data_out_7,
       output  [DATA_WIDTH-1:0] fifo_data_out_8,
       output  [DATA_WIDTH-1:0] fifo_data_out_9,
       output  [DATA_WIDTH-1:0] fifo_data_out_10,
       output  [DATA_WIDTH-1:0] fifo_data_out_11,
       output  [DATA_WIDTH-1:0] fifo_data_out_12,
       output  [DATA_WIDTH-1:0] fifo_data_out_13,
       output  [DATA_WIDTH-1:0] fifo_data_out_14,
       output  [DATA_WIDTH-1:0] fifo_data_out_15,
       output  [DATA_WIDTH-1:0] fifo_data_out_16,
       output  [DATA_WIDTH-1:0] fifo_data_out_17,
       output  [DATA_WIDTH-1:0] fifo_data_out_18,
       output  [DATA_WIDTH-1:0] fifo_data_out_19,
       output  [DATA_WIDTH-1:0] fifo_data_out_20,
       output  [DATA_WIDTH-1:0] fifo_data_out_21,
       output  [DATA_WIDTH-1:0] fifo_data_out_22,
       output  [DATA_WIDTH-1:0] fifo_data_out_23,
       output  [DATA_WIDTH-1:0] fifo_data_out_24,
       output  [DATA_WIDTH-1:0] fifo_data_out_25
    );
    
    reg [DATA_WIDTH-1:0] FIFO  [FIFO_SIZE-1:0] ;
  
   
   
    integer i;
    always @ (posedge clk or posedge reset)
    begin
        if(reset)
        begin 
        for( i=0;i<((KERNAL_SIZE - 1)*IFM_SIZE+KERNAL_SIZE)-1;i=i+1)
            begin 
                FIFO[i]<=0;
            end
        end
    
        else if(fifo_enable)
        begin
            for( i=0;i<((KERNAL_SIZE - 1)*IFM_SIZE+KERNAL_SIZE)-1;i=i+1)
            begin 
                FIFO[i+1]<=FIFO[i];
            end
                FIFO[0]<=fifo_data_in;    
        end
    end

   
    assign    fifo_data_out_1=FIFO[(KERNAL_SIZE-1)*IFM_SIZE+(KERNAL_SIZE-1)];
    assign    fifo_data_out_2=FIFO[(KERNAL_SIZE-1)*IFM_SIZE+(KERNAL_SIZE-2)];
    assign    fifo_data_out_3=FIFO[(KERNAL_SIZE-1)*IFM_SIZE+(KERNAL_SIZE-3)];
    assign    fifo_data_out_4=FIFO[(KERNAL_SIZE-1)*IFM_SIZE+(KERNAL_SIZE-4)];
    assign    fifo_data_out_5=FIFO[(KERNAL_SIZE-1)*IFM_SIZE+(KERNAL_SIZE-5)];
   
    assign    fifo_data_out_6=FIFO[(KERNAL_SIZE-2)*IFM_SIZE+(KERNAL_SIZE-1)];
    assign    fifo_data_out_7=FIFO[(KERNAL_SIZE-2)*IFM_SIZE+(KERNAL_SIZE-2)];
    assign    fifo_data_out_8=FIFO[(KERNAL_SIZE-2)*IFM_SIZE+(KERNAL_SIZE-3)];
    assign    fifo_data_out_9=FIFO[(KERNAL_SIZE-2)*IFM_SIZE+(KERNAL_SIZE-4)];
    assign    fifo_data_out_10=FIFO[(KERNAL_SIZE-2)*IFM_SIZE+(KERNAL_SIZE-5)]; 

    assign    fifo_data_out_11=FIFO[(KERNAL_SIZE-3)*IFM_SIZE+(KERNAL_SIZE-1)];
    assign    fifo_data_out_12=FIFO[(KERNAL_SIZE-3)*IFM_SIZE+(KERNAL_SIZE-2)];
    assign    fifo_data_out_13=FIFO[(KERNAL_SIZE-3)*IFM_SIZE+(KERNAL_SIZE-3)];
    assign    fifo_data_out_14=FIFO[(KERNAL_SIZE-3)*IFM_SIZE+(KERNAL_SIZE-4)];
    assign    fifo_data_out_15=FIFO[(KERNAL_SIZE-3)*IFM_SIZE+(KERNAL_SIZE-5)];
 
    assign    fifo_data_out_16=FIFO[(KERNAL_SIZE-4)*IFM_SIZE+(KERNAL_SIZE-1)];
    assign    fifo_data_out_17=FIFO[(KERNAL_SIZE-4)*IFM_SIZE+(KERNAL_SIZE-2)];
    assign    fifo_data_out_18=FIFO[(KERNAL_SIZE-4)*IFM_SIZE+(KERNAL_SIZE-3)];
    assign    fifo_data_out_19=FIFO[(KERNAL_SIZE-4)*IFM_SIZE+(KERNAL_SIZE-4)];
    assign    fifo_data_out_20=FIFO[(KERNAL_SIZE-4)*IFM_SIZE+(KERNAL_SIZE-5)];
    
   
    assign    fifo_data_out_21=FIFO[(KERNAL_SIZE-5)*IFM_SIZE+(KERNAL_SIZE-1)];
    assign    fifo_data_out_22=FIFO[(KERNAL_SIZE-5)*IFM_SIZE+(KERNAL_SIZE-2)];
    assign    fifo_data_out_23=FIFO[(KERNAL_SIZE-5)*IFM_SIZE+(KERNAL_SIZE-3)];
    assign    fifo_data_out_24=FIFO[(KERNAL_SIZE-5)*IFM_SIZE+(KERNAL_SIZE-4)];
    assign    fifo_data_out_25=FIFO[(KERNAL_SIZE-5)*IFM_SIZE+(KERNAL_SIZE-5)];
    
endmodule
    