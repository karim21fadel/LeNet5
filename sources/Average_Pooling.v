`timescale 1ns / 1ps

module Average_Pooling#(parameter ARITH_TYPE = 1, DATA_WIDTH          = 32,
                             /////////////////////////////////////
	                         IFM_SIZE              = 14,                                                
                             IFM_DEPTH             = 3,
							 KERNAL_SIZE           = 2,
		                     //////////////////////////////////////
		                     NUMBER_OF_IFM           = IFM_DEPTH,
							 IFM_SIZE_NEXT           = (IFM_SIZE - KERNAL_SIZE)/2 + 1,
                             ADDRESS_SIZE_IFM        = $clog2(IFM_SIZE*IFM_SIZE),
                             ADDRESS_SIZE_NEXT_IFM   = $clog2(IFM_SIZE_NEXT*IFM_SIZE_NEXT),      
                             FIFO_SIZE               = (KERNAL_SIZE-1)*IFM_SIZE + KERNAL_SIZE)
   (
    input clk,
    input reset,
    input pool_enable,
    input [DATA_WIDTH-1:0] pool_data_in_1,
    input [DATA_WIDTH-1:0] pool_data_in_2,
    input [DATA_WIDTH-1:0] pool_data_in_3,
    input [DATA_WIDTH-1:0] pool_data_in_4,
    output reg [DATA_WIDTH-1:0] pool_data_out_reg
    );
    
    
    wire [DATA_WIDTH-1:0] sum_11,     sum_12,     sum_21;       
    reg  [DATA_WIDTH-1:0] sum_11_reg, sum_12_reg, sum_21_reg;
    wire [DATA_WIDTH-1:0] avgIFM;
    
    Adder #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) add1( .FP_in1(pool_data_in_1), .FP_in2(pool_data_in_2), .FP_out(sum_11) );
    Adder #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) add2( .FP_in1(pool_data_in_3), .FP_in2(pool_data_in_4), .FP_out(sum_12) );

    Adder #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) add3( .FP_in1(sum_11_reg), .FP_in2(sum_12_reg), .FP_out(sum_21) ); 
    
    always @(posedge clk or posedge reset)
    begin
        if(reset)
            begin
            sum_11_reg <= {DATA_WIDTH{1'b0}};
            sum_12_reg <= {DATA_WIDTH{1'b0}};      
            end
        else if (pool_enable)
            begin
            sum_11_reg <= sum_11;
            sum_12_reg <= sum_12;
            end
    end 
    
    always @(posedge clk or posedge reset)
    begin
        if(reset)
            sum_21_reg <= {DATA_WIDTH{1'b0}};        
        else 
            sum_21_reg <= sum_21;
    end 

    Divider #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) div1 ( .FP_in1(sum_21_reg), .FP_out(avgIFM) );

    always @(posedge clk or posedge reset)
    begin
        if(reset)
            pool_data_out_reg <= {DATA_WIDTH{1'b0}};
        else
            pool_data_out_reg <= avgIFM;
    end
    
endmodule
