module FIFO_10outputs_FC2 #(parameter DATA_WIDTH      = 32,
                            ADDRESS_BITS    = 15,
                            ////////////////////////////////////
                            IFM_DEPTH       = 84,
                            IFM_SIZE        = 1,
                            ADDRESS_SIZE_WM = $clog2(IFM_DEPTH),      
                            NUMBER_OF_WM    = 10
                            )
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
    
    reg [DATA_WIDTH-1:0] FIFO  [NUMBER_OF_WM-1:0];
  
   
    integer i;
    always @ (posedge clk)
    begin
       if(fifo_enable)
        begin
            for( i=0; i<NUMBER_OF_WM-1; i=i+1)
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