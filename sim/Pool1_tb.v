`timescale 1ns / 1ps

module Pool1_tb;
    
    localparam DATA_WIDTH            = 32, 
               IFM_SIZE              = 28,
               IFM_DEPTH             = 3,
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
	TOP_Pool1 #(.IFM_SIZE(IFM_SIZE), 
                .IFM_DEPTH(IFM_DEPTH), 
                .KERNAL_SIZE(KERNAL_SIZE))  
    uut (
		.clk(clk), 
		.reset(reset), 
		.data_in_from_previous(data_in_from_previous), 
		.ifm_address_write_previous(ifm_address_write_previous), 
		.ifm_address_read_previous(ifm_address_read_previous), 
		.start_from_previous(start_from_previous), 
		.ifm_enable_read_previous(ifm_enable_read_previous), 
		.ifm_enable_write_previous(ifm_enable_write_previous), 
		.data_out_for_previous(data_out_for_previous), 
		.end_to_previous(end_to_previous), 
		.data_out_for_next(data_out_for_next), 
		.ifm_address_write_next(ifm_address_write_next), 
		.ifm_enable_write_next(ifm_enable_write_next), 
		.start_to_next(start_to_next), 
		.end_from_next(end_from_next)
	);
    
    parameter pool1_output_file_float = "files/outputs/hard/float/pool1_output_file_float.txt";
    parameter pool1_output_file_bin = "files/outputs/hard/bin/pool1_output_file_bin.txt";
	integer pool1_output_file_float_id;
	integer pool1_output_file_bin_id;
	
	//memory variable
    reg [DATA_WIDTH-1:0] data_in_from_previous_mem [4704-1:0];
	
	always #5 clk=~clk;  
	
	initial begin
	
	$readmemb("files/outputs/soft/float/output_1_layer.txt",data_in_from_previous_mem);
	
	   pool1_output_file_float_id = $fopen(pool1_output_file_float,"w");  
	   pool1_output_file_bin_id = $fopen(pool1_output_file_bin,"w");  

	   
	   if(~pool1_output_file_float_id)
	       $display("failed float");
	   
	   if(~pool1_output_file_float_id)
	       $display("failed bin");
	       
 
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

	 // Wait 100 ns for global reset to finish
		@(negedge clk);
        reset =0;
        
        // First Channel
        for(i=0; i<IFM_SIZE*IFM_SIZE; i=i+1)
        begin
            
            @(negedge clk);
            
            data_in_from_previous      = data_in_from_previous_mem[i];
            ifm_enable_write_previous  = 1'b1;
            ifm_address_write_previous = i;
   
        end
        
        
		@(negedge clk);//
		ifm_enable_write_previous  = 1'b0;
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
                $fwrite(pool1_output_file_bin_id, "%b " , data_out_for_next);
                $fwrite(pool1_output_file_float_id, "%f \n" , $bitstoshortreal(data_out_for_next));
                //$display($bitstoshortreal(data_out_for_next));
                @(posedge clk) ;
            end
            
            else
            begin
                @(posedge clk);
            end

        end
       
        //$fclose(pool1_output_file_float_id);
        
        
        // Second Channel
        for(i=0; i<IFM_SIZE*IFM_SIZE; i=i+1)
        begin
            
            @(negedge clk);
            data_in_from_previous      = data_in_from_previous_mem[i+IFM_SIZE*IFM_SIZE];
            ifm_enable_write_previous  = 1'b1;
            ifm_address_write_previous = i;
   
        end
        
		@(negedge clk);//
		ifm_enable_write_previous  = 1'b0;
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
                $fwrite(pool1_output_file_bin_id, "%b " , data_out_for_next);
                $fwrite(pool1_output_file_float_id, "%f \n" , $bitstoshortreal(data_out_for_next));
                //$display($bitstoshortreal(data_out_for_next));
                @(posedge clk) ;
            end
            
            else
            begin
                @(posedge clk);
            end

        end
        
        //$fclose(output_file_id2);
        
        
        // Third Channel
        for(i=0; i<IFM_SIZE*IFM_SIZE; i=i+1)
        begin
            
            @(negedge clk);
            data_in_from_previous      = data_in_from_previous_mem[i+2*IFM_SIZE*IFM_SIZE];
            ifm_enable_write_previous  = 1'b1;
            ifm_address_write_previous = i;
   
        end
        
		@(negedge clk);//
		ifm_enable_write_previous  = 1'b0;
		start_from_previous = 1;
		end_from_next       = 1;
				
		@(negedge clk);//
		start_from_previous = 0;
		
		/*for(i=0; i<FIFO_SIZE; i=i+1)
		begin
		    @(negedge clk);
		end
		
		@(negedge clk)
		end_from_next = 1;*/
		
		@(posedge ifm_enable_write_next); 
		
		while(~start_to_next)
        begin
            #1
            if(ifm_enable_write_next)
            begin
                $fwrite(pool1_output_file_bin_id, "%b " , data_out_for_next);
                $fwrite(pool1_output_file_float_id, "%f \n" , $bitstoshortreal(data_out_for_next));
                //$display($bitstoshortreal(data_out_for_next));
                @(posedge clk) ;
            end
            
            else
            begin
                @(posedge clk);
            end

        end
        
        //$fclose(output_file_id3);
 
         // Fourth Channel
        for(i=0; i<IFM_SIZE*IFM_SIZE; i=i+1)
        begin
            
            @(negedge clk);
            data_in_from_previous      = data_in_from_previous_mem[i+3*IFM_SIZE*IFM_SIZE];
            ifm_enable_write_previous  = 1'b1;
            ifm_address_write_previous = i;
   
        end
        
		@(negedge clk);//
		ifm_enable_write_previous  = 1'b0;
		start_from_previous = 1;
		end_from_next       = 1;
				
		@(negedge clk);//
		start_from_previous = 0;
		
		/*for(i=0; i<FIFO_SIZE; i=i+1)
		begin
		    @(negedge clk);
		end
		
		@(negedge clk)
		end_from_next = 1;*/
		
		@(posedge ifm_enable_write_next); 
		
		while(~start_to_next)
        begin
            #1
            if(ifm_enable_write_next)
            begin
                $fwrite(pool1_output_file_bin_id, "%b " , data_out_for_next);
                $fwrite(pool1_output_file_float_id, "%f \n" , $bitstoshortreal(data_out_for_next));
                //$display($bitstoshortreal(data_out_for_next));
                @(posedge clk) ;
            end
            
            else
            begin
                @(posedge clk);
            end

        end
        
        //$fclose(output_file_id3);
 
         // Fifth Channel
        for(i=0; i<IFM_SIZE*IFM_SIZE; i=i+1)
        begin
            
            @(negedge clk);
            data_in_from_previous      = data_in_from_previous_mem[i+4*IFM_SIZE*IFM_SIZE];
            ifm_enable_write_previous  = 1'b1;
            ifm_address_write_previous = i;
   
        end
        
		@(negedge clk);//
		ifm_enable_write_previous  = 1'b0;
		start_from_previous = 1;
		end_from_next       = 1;
				
		@(negedge clk);//
		start_from_previous = 0;
		
		/*for(i=0; i<FIFO_SIZE; i=i+1)
		begin
		    @(negedge clk);
		end
		
		@(negedge clk)
		end_from_next = 1;*/
		
		@(posedge ifm_enable_write_next); 
		
		while(~start_to_next)
        begin
            #1
            if(ifm_enable_write_next)
            begin
                $fwrite(pool1_output_file_bin_id, "%b " , data_out_for_next);
                $fwrite(pool1_output_file_float_id, "%f \n" , $bitstoshortreal(data_out_for_next));
                //$display($bitstoshortreal(data_out_for_next));
                @(posedge clk) ;
            end
            
            else
            begin
                @(posedge clk);
            end

        end
        
        //$fclose(output_file_id3);
 
         // Sixth Channel
        for(i=0; i<IFM_SIZE*IFM_SIZE; i=i+1)
        begin
            
            @(negedge clk);
            data_in_from_previous      = data_in_from_previous_mem[i+5*IFM_SIZE*IFM_SIZE];
            ifm_enable_write_previous  = 1'b1;
            ifm_address_write_previous = i;
   
        end
        
		@(negedge clk);//
		ifm_enable_write_previous  = 1'b0;
		start_from_previous = 1;
		end_from_next       = 1;
				
		@(negedge clk);//
		start_from_previous = 0;
		
		/*for(i=0; i<FIFO_SIZE; i=i+1)
		begin
		    @(negedge clk);
		end
		
		@(negedge clk)
		end_from_next = 1;*/
		
		@(posedge ifm_enable_write_next); 
		
		while(~start_to_next)
        begin
            #1
            if(ifm_enable_write_next)
            begin
                $fwrite(pool1_output_file_bin_id, "%b " , data_out_for_next);
                $fwrite(pool1_output_file_float_id, "%f \n" , $bitstoshortreal(data_out_for_next));
                //$display($bitstoshortreal(data_out_for_next));
                @(posedge clk) ;
            end
            
            else
            begin
                @(posedge clk);
            end

        end
        

        $fclose(pool1_output_file_float_id);
        $fclose(pool1_output_file_bin_id);
	end

     
   
endmodule
