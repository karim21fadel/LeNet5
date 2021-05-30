`timescale 1ns / 1ps

module Pool2_tb;
    
    localparam DATA_WIDTH            = 32, 
               IFM_SIZE              = 10,
               IFM_DEPTH             = 16,
               KERNAL_SIZE           = 2,
               IFM_SIZE_NEXT         = (IFM_SIZE - KERNAL_SIZE)/2 + 1,
               IFM_ADDRESS_SIZE      = $clog2(IFM_SIZE*IFM_SIZE),
               IFM_ADDRESS_SIZE_NEXT = $clog2(IFM_SIZE_NEXT*IFM_SIZE_NEXT),  
               FIFO_SIZE             = (KERNAL_SIZE-1)*IFM_SIZE + KERNAL_SIZE;
	// Inputs
	reg clk;
	reg reset;
	reg [DATA_WIDTH-1:0] data_in_from_previous;
	reg [IFM_ADDRESS_SIZE-1:0] ifm_address_write_previous;
	reg [IFM_ADDRESS_SIZE-1:0] ifm_address_read_previous;
	reg start_from_previous;
	reg ifm_enable_read_previous;
	reg ifm_enable_write_previous;
	reg end_from_next;
	reg [3:0] ifm_sel_previous;

	// Outputs
	wire [DATA_WIDTH-1:0] data_out_for_previous;
	wire end_to_previous;
	wire [DATA_WIDTH-1:0] data_out_for_next;
	wire [IFM_ADDRESS_SIZE_NEXT-1:0] ifm_address_write_next;
	wire ifm_enable_write_next;
	wire start_to_next;
	
	// integers
	integer i;

	// Instantiate the Unit Under Test (UUT)
	TOP_Pool2 #(.IFM_SIZE(IFM_SIZE), 
                .IFM_DEPTH(IFM_DEPTH), 
                .KERNAL_SIZE(KERNAL_SIZE)) 
    uut (
		.clk(clk), 
		.reset(reset), 
		.data_in_from_previous1(data_in_from_previous1), 
		.data_in_from_previous2(data_in_from_previous2), 
		.data_in_from_previous3(data_in_from_previous3), 
		.ifm_address_write_previous(ifm_address_write_previous), 
		.ifm_address_read_previous(ifm_address_read_previous), 
		.start_from_previous(start_from_previous), 
		.ifm_enable_read_previous(ifm_enable_read_previous), 
		.ifm_enable_write_previous(ifm_enable_write_previous),
		.ifm_sel_previous(ifm_sel_previous), 
		.data_out_for_previous1(data_out_for_previous1), 
		.data_out_for_previous2(data_out_for_previous2), 
		.data_out_for_previous3(data_out_for_previous3), 
		.end_to_previous(end_to_previous), 
		.data_out_for_next1(data_out_for_next1), 
		.data_out_for_next2(data_out_for_next2), 
		.data_out_for_next3(data_out_for_next3), 
		.ifm_address_write_next(ifm_address_write_next), 
		.ifm_enable_write_next(ifm_enable_write_next), 
		.start_to_next(start_to_next), 
		.end_from_next(end_from_next)
	);
    
    parameter output_file1  = "output_file1_pool2.txt";
    parameter output_file2  = "output_file2_pool2.txt";
    parameter output_file3  = "output_file3_pool2.txt";
    parameter output_file4  = "output_file4_pool2.txt";
    parameter output_file5  = "output_file5_pool2.txt";
    parameter output_file6  = "output_file6_pool2.txt";
    parameter output_file7  = "output_file7_pool2.txt";
    parameter output_file8  = "output_file8_pool2.txt";
    parameter output_file9  = "output_file9_pool2.txt";
    parameter output_file10 = "output_file10_pool2.txt";
    parameter output_file11 = "output_file11_pool2.txt";
    parameter output_file12 = "output_file12_pool2.txt";
    parameter output_file13 = "output_file13_pool2.txt";
    parameter output_file14 = "output_file14_pool2.txt";
    parameter output_file15 = "output_file15_pool2.txt";
    parameter output_file16 = "output_file16_pool2.txt";
    
	integer output_file_id1;
	integer output_file_id2;
	integer output_file_id3;
	integer output_file_id4;
	integer output_file_id5;
	integer output_file_id6;
	integer output_file_id7;
	integer output_file_id8;
	integer output_file_id9;
	integer output_file_id10;
	integer output_file_id11;
	integer output_file_id12;
	integer output_file_id13;
	integer output_file_id14;
	integer output_file_id15;
	integer output_file_id16;
	
	always #5 clk=~clk;  
	
	initial begin
	
	   output_file_id1  = $fopen(pool2_output_file1,"w"); 
	   output_file_id2  = $fopen(pool2_output_file2,"w"); 
	   output_file_id3  = $fopen(pool2_output_file3,"w"); 
	   output_file_id4  = $fopen(pool2_output_file4,"w"); 
	   output_file_id5  = $fopen(pool2_output_file5,"w"); 
	   output_file_id6  = $fopen(pool2_output_file6,"w"); 
	   output_file_id7  = $fopen(pool2_output_file7,"w"); 
	   output_file_id8  = $fopen(pool2_output_file8,"w"); 
	   output_file_id9  = $fopen(pool2_output_file9,"w"); 
	   output_file_id10 = $fopen(pool2_output_file10,"w"); 
	   output_file_id11 = $fopen(pool2_output_file11,"w"); 
	   output_file_id12 = $fopen(pool2_output_file12,"w"); 
	   output_file_id13 = $fopen(pool2_output_file13,"w"); 
	   output_file_id14 = $fopen(pool2_output_file14,"w"); 
	   output_file_id15 = $fopen(pool2_output_file15,"w"); 
	   output_file_id16 = $fopen(pool2_output_file16,"w"); 
	   
	   if(!output_file_id1)
	       $display("failed1");
	       
	   if(!output_file_id2)
	       $display("failed2");
	       
	   if(!output_file_id3)
	       $display("faile3");
	       
 
	 // Initialize Inputs
		clk = 1;
		reset = 1;
		data_in_from_previous = 0;
		ifm_address_write_previous = 0;
		ifm_address_read_previous = 0;
		start_from_previous = 0;
		ifm_enable_read_previous = 0;
		ifm_enable_write_previous = 0;
		end_from_next = 0;
		ifm_sel_previous  = 0; 

	 // Wait 100 ns for global reset to finish
		@(negedge clk);
        reset =0;  
        
        //------------------------------------------//
        //--------------Channel 1,2,3---------------//
        //------------------------------------------//
        for(i=0; i<IFM_SIZE*IFM_SIZE; i=i+1)
        begin
            
            @(negedge clk);
            data_in_from_previous1      = i+1;
            data_in_from_previous2      = i+1;
            data_in_from_previous3      = i+1;
            ifm_enable_write_previous  = 1'b1;
            ifm_address_write_previous = i;
   
        end
        
		@(negedge clk);//
		start_from_previous = 1;
		end_from_next       = 1;
		
		@(negedge clk);//
		start_from_previous = 0;
		
		@(posedge ifm_enable_write_next); 
		
		while(~start_to_next)
        begin
            #1
            if(ifm_enable_write_next)
            begin
                $fwrite(output_file_id1, "%f\n" ,  $bitstoshortreal(data_out_for_next1) );
                $fwrite(output_file_id2, "%f\n" ,  $bitstoshortreal(data_out_for_next2) );
                $fwrite(output_file_id3, "%f\n" ,  $bitstoshortreal(data_out_for_next3) );
                @(posedge clk) ;
            end
            
            else
            begin
                @(posedge clk);
            end

        end
        
        $fclose(output_file_id1);
   end
        
endmodule
