module FIFO_25outputs_WM #(parameter DATA_WIDTH  = 32,
                                     KERNAL_SIZE = 5,
	                                 FIFO_SIZE   = KERNAL_SIZE*KERNAL_SIZE)
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
            for( i=0; i<FIFO_SIZE-1; i=i+1)
                begin 
                    FIFO[i]<=0;
                end
        end
    
        else if(fifo_enable)
        begin
            for( i=0; i<FIFO_SIZE-1; i=i+1)
            begin 
                FIFO[i+1]<=FIFO[i];
            end
                FIFO[0]<=fifo_data_in;    
        end
    end

   
    assign    fifo_data_out_1=FIFO[FIFO_SIZE-1];
    assign    fifo_data_out_2=FIFO[FIFO_SIZE-2];
    assign    fifo_data_out_3=FIFO[FIFO_SIZE-3];
    assign    fifo_data_out_4=FIFO[FIFO_SIZE-4];
    assign    fifo_data_out_5=FIFO[FIFO_SIZE-5];
    assign    fifo_data_out_6=FIFO[FIFO_SIZE-6];
    assign    fifo_data_out_7=FIFO[FIFO_SIZE-7];
    assign    fifo_data_out_8=FIFO[FIFO_SIZE-8];
    assign    fifo_data_out_9=FIFO[FIFO_SIZE-9];
    assign    fifo_data_out_10=FIFO[FIFO_SIZE-10]; 
    assign    fifo_data_out_11=FIFO[FIFO_SIZE-11];
    assign    fifo_data_out_12=FIFO[FIFO_SIZE-12];
    assign    fifo_data_out_13=FIFO[FIFO_SIZE-13];
    assign    fifo_data_out_14=FIFO[FIFO_SIZE-14];
    assign    fifo_data_out_15=FIFO[FIFO_SIZE-15];
    assign    fifo_data_out_16=FIFO[FIFO_SIZE-16];
    assign    fifo_data_out_17=FIFO[FIFO_SIZE-17];
    assign    fifo_data_out_18=FIFO[FIFO_SIZE-18];
    assign    fifo_data_out_19=FIFO[FIFO_SIZE-19];
    assign    fifo_data_out_20=FIFO[FIFO_SIZE-20];
    assign    fifo_data_out_21=FIFO[FIFO_SIZE-21];
    assign    fifo_data_out_22=FIFO[FIFO_SIZE-22];
    assign    fifo_data_out_23=FIFO[FIFO_SIZE-23];
    assign    fifo_data_out_24=FIFO[FIFO_SIZE-24];
    assign    fifo_data_out_25=FIFO[FIFO_SIZE-25];
    
endmodule
    