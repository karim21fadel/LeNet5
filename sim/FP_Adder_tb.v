`timescale 1ns / 1ps


module FP_Adder_tb;
    
    reg  clk;
    reg  [31:0] FP_in1;
    reg  [31:0] FP_in2;
    wire [31:0] FP_out;
    
    FP_Adder Adder (
              .FP_in1(FP_in1),
              .FP_in2(FP_in2),
              .FP_out(FP_out)
             );
             
    initial
    begin
        
        // initialization inputs
        clk = 0;
        
        @(negedge clk)
        FP_in1 = $shortrealtobits(0.6048);
        FP_in2 = $shortrealtobits(0.0662);
        #1
        $display($bitstoshortreal(FP_out));
        
        @(negedge clk)
        FP_in1 = $shortrealtobits(-0.6048);
        FP_in2 = $shortrealtobits(7.0662);
        #1
        $display($bitstoshortreal(FP_out));
        
        @(negedge clk)
        FP_in1 = $shortrealtobits(5.6048);
        FP_in2 = $shortrealtobits(-1.0662);
        #1
        $display($bitstoshortreal(FP_out));
        
    end
    
    always #5 clk = ~clk;
    
endmodule
