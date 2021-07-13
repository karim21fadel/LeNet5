`timescale 1ns / 1ps

module Delay
    #(parameter Delay_Data_Width = 1,
                delay_cycles = 5
                )
      (
       input wire clk,
       input wire [Delay_Data_Width-1:0] Data_In,
       
       input wire reset,
        
       output wire [Delay_Data_Width-1:0] Data_Out

    );
    
    reg [Delay_Data_Width-1:0] FIFO [delay_cycles - 1:0] ;
    integer i;
    always @ (posedge clk)
       if(reset)
	   begin 
	       for( i=0;i<delay_cycles-1;i=i+1)
           begin 
                FIFO[i]<=0;
           end
		end
      else 
      begin
           for( i=0;i<delay_cycles-1;i=i+1)
             begin 
              FIFO[i+1]<=FIFO[i];
             end
          FIFO[0]<=Data_In; 
      end 
   assign    Data_Out=FIFO[i-1];
  
endmodule
