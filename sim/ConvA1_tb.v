`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2021 06:52:10 PM
// Design Name: 
// Module Name: tb_cona1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_cona1;
    reg clk;
	reg reset;
	reg [31:0] riscv_data_bus;
	reg [18:0] riscv_address_bus;
	///////////////////////////////
	//reg [31:0] data_in_from_previous;
	//reg [7:0] ifm_address_write_previous;
	//reg ifm_enable_write_previous;
	reg start_from_previous;
	reg end_from_next;
    reg data_in_from_next;
	// Outputs
	//wire end_to_pervious;
	wire [31:0] data_out_for_next;
	//wire [4:0] ifm_address_write_next;
	wire ifm_enable_write_next;
	wire ifm_enable_read_next;
	wire start_to_next;

	// Instantiate the Unit Under Test (UUT)
	TOP_ConvA1 uut (
		.clk(clk), 
		.reset(reset), 
		.riscv_data_bus(riscv_data_bus), 
		.riscv_address_bus(riscv_address_bus), 
		//.data_in_from_previous(data_in_from_previous), 
		//.ifm_address_write_previous(ifm_address_write_previous), 
		//.ifm_enable_write_previous(ifm_enable_write_previous), 
		.start_from_previous(start_from_previous), 
		//.end_to_previous(end_to_previous), 
		.end_from_next(end_from_next), 
		.data_out_for_next(data_out_for_next), 
		.data_in_from_next(data_in_from_next),
		.ifm_enable_write_next(ifm_enable_write_next), 
		.ifm_enable_read_next(ifm_enable_read_next), 
		.start_to_next(start_to_next)
	);
integer i,j,k;

//parameter output_file = "output_file_convA2.txt";
//integer output_file_id;
	initial begin
	
	//output_file_id = $fopen(output_file,"w");
	
	//if(!output_file_id)
	  // $display("failed");
	   
		// Initialize Inputs
		clk = 0;
		reset = 1;
		riscv_data_bus = 0;
		riscv_address_bus = 0;
		//data_in_from_previous = 0;
		data_in_from_next = 0;
		//ifm_address_write_previous = 0;
		//ifm_enable_write_previous = 0;
		start_from_previous = 0;
		end_from_next = 0;

		 
 @(negedge clk)
 reset = 0;
 

for (j=1;j<26 ; j=j+1)
begin
    for (i=2048*j; i<2048*j+6*3; i=i+1)
    begin
    
    @(negedge clk)
    riscv_address_bus = i;
    riscv_data_bus =1;
    end
end

   
     for (i=344064; i<344064+1024; i=i+1)
     begin
    @(negedge clk)
    riscv_address_bus = i;
    riscv_data_bus = 1;
     end
    for (i=346112; i<346112+1024; i=i+1)
     begin
    @(negedge clk)
    riscv_address_bus = i;
    riscv_data_bus = 1;
     end
   for (i=348160; i<348160+1024; i=i+1)
     begin
    @(negedge clk)
    riscv_address_bus = i;
    riscv_data_bus = 1;
     end
   
        @(negedge clk)  
         riscv_address_bus = 0;
        @(negedge clk)  
         start_from_previous = 1; 
        @(negedge clk)  
         start_from_previous = 0;  
end
always #10 clk=~clk;
endmodule
