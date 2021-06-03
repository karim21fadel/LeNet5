`timescale 1ns / 1ps

module ConvB_tb;

    reg clk;
	reg reset;
	reg [31:0] riscv_data;
	reg [14:0] riscv_address;
	reg [3-1:0] wm_enable_write;
	reg [3-1:0] bm_enable_write;
	/////////////////////////////////////////////////
	
	reg start_from_previous;
	reg [31:0] data_in_from_previous;
	reg ifm_enable_write_previous;
	reg [7:0] ifm_address_write_previous;
	reg end_from_next;
    reg [31:0] data_in_from_next1;
    reg [31:0] data_in_from_next2;
    reg [31:0] data_in_from_next3;
	
	// Outputs
	wire end_to_pervious;
	wire [31:0] data_out_for_next1;
	wire [31:0] data_out_for_next2;
	wire [31:0] data_out_for_next3;
	wire ifm_enable_read_next;
	wire ifm_enable_write_next;
	wire [6:0]ifm_address_read_next;
	wire [6:0]ifm_address_write_next;
    wire start_to_next;
    wire [2:0] ifm_sel_next;
    
    // Files
    reg [31:0] convB_input [14*14-1:0];
    reg [31:0] convB_WM1 [900-1:0];
    reg [31:0] convB_WM2 [900-1:0];
    reg [31:0] convB_WM3 [900-1:0];
    reg [31:0] convB_BM [2:0][5:0];
    
    // Mems
    reg arr_mem;
	
	// Instantiate the Unit Under Test (UUT)
	
	TOP_ConvB #(.IFM_SIZE(14), 
                .IFM_DEPTH(6), 
                .KERNAL_SIZE(5), 
                .NUMBER_OF_FILTERS(16))
	uut (
	.clk(clk),
	.reset(reset),
	.riscv_data(riscv_data),
	.riscv_address(riscv_address),
	.wm_enable_write(wm_enable_write),
	.bm_enable_write(bm_enable_write),
	
    .start_from_previous(start_from_previous),
    .end_to_previous(end_to_previous),
    .data_in_from_previous(data_in_from_previous),
	.data_out_for_previous(data_out_for_previous),
	
	.ifm_enable_read_previous(0),
	.ifm_enable_write_previous(ifm_enable_write_previous),
	.ifm_address_read_previous(0),
	.ifm_address_write_previous(ifm_address_write_previous),
	     
	.end_from_next(1),
    .data_in_from_next1(0),
    .data_in_from_next2(0),
    .data_in_from_next3(0),
	.ifm_enable_read_next(ifm_enable_read_next),
    .ifm_enable_write_next(ifm_enable_write_next),
    .ifm_address_read_next(ifm_address_read_next),
    .ifm_address_write_next(ifm_address_write_next),
	.data_out_for_next1(data_out_for_next1),
	.data_out_for_next2(data_out_for_next2),
	.data_out_for_next3(data_out_for_next3),
	.start_to_next(start_to_next),
    .ifm_sel_next(ifm_sel_next)
	);
    
    parameter convB_output_file = "convB_output_file.txt";
	integer convB_output_file_id;
	
    integer i;
    integer j,k;
	initial begin
	
	$readmemb("files/output_2_layer.txt",convB_input);
	$readmemb("files/layer_3_mem_0.txt",convB_WM1);
	$readmemb("files/layer_3_mem_1.txt",convB_WM2);
	$readmemb("files/layer_3_mem_2.txt",convB_WM3);
	$readmemb("files/layer_3_mem_bias.txt",convB_BM);
	
	convB_output_file_id = $fopen(convB_output_file,"w");
	
	// Initialize Inputs
	clk = 0;
	reset = 1;
	riscv_data = 0;
	riscv_address = 0;
	data_in_from_previous = 0;
	ifm_address_write_previous = 0;
	ifm_enable_write_previous = 0;
	start_from_previous = 0;
	end_from_next = 1;
	data_in_from_next1=0;
	data_in_from_next2=0;
	data_in_from_next3=0;

		 
    @(negedge clk);
    reset = 0;
	wm_enable_write = 1;
	

	for(j=0; j<900; j=j+1)
	begin
	    riscv_data    = convB_WM1[j];
	    @(negedge clk);
	    riscv_address = j; 
	end
	    wm_enable_write = wm_enable_write<<1;
	    
	for(j=0; j<900; j=j+1)
	begin
	    riscv_data    = convB_WM2[j];
	    @(negedge clk);
	    riscv_address = j; 
	end
	    wm_enable_write = wm_enable_write<<1;
	    
	for(j=0; j<900; j=j+1)
	begin
	    riscv_data    = convB_WM3[j];
	    @(negedge clk);
	    riscv_address = j; 
	end
	    
	
	@(negedge clk);
	wm_enable_write = 0;
	bm_enable_write = 1;
	
	for(i=0; i<3; i=i+1)
	begin
	   for(j=0; j<8; j=j+1)
	   begin
	       riscv_data    = convB_BM[i][j];
	       @(negedge clk);
	       riscv_address = j; 
	   end
	       bm_enable_write = bm_enable_write<<1;
	end
	
	@(negedge clk);
	bm_enable_write = 1'b0;
	
	for(i=0; i<14*14; i=i+1)
        begin
            
            @(negedge clk);
            data_in_from_previous      = convB_input[i];
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

                $fwrite(convB_output_file_id, "%d %d %b\n" , ifm_enable_write_next, ifm_address_write_next, data_out_for_next1);
                @(posedge clk) ;
            end
            
            else
            begin
                @(posedge clk);
            end

        end


end
 
 
 
always #10 clk=~clk;
endmodule

