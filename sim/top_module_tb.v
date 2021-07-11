`timescale 1ns / 1ps

module top_module_tb #(parameter DATA_WIDTH      = 32,
                                 ARITH_TYPE      = 0,  
                                 ADDRESS_BUS     = 22,  
                                 ADDRESS_BITS    = 15,  
                                 ENABLE_BITS     = 7,   
                                 NUMBER_OF_UNITS = 3,
                                 IFM_SIZE        = 32,   
                                 IFM_DEPTH       = 3);//f el control unit 
								 //sh8al 3la 3 bas 3amel comment ll data bus

    localparam MEM_SIZE = 783;
	
    reg [DATA_WIDTH-1:0] input_image2 [1023:0];
    reg [DATA_WIDTH-1:0] input_image5 [1023:0];
    reg [DATA_WIDTH-1:0] input_image7 [1023:0];
    reg [DATA_WIDTH-1:0] input_image9 [1023:0];
	
	reg [DATA_WIDTH-1:0] convA1_WM1 [150-1:0];
	
    reg [DATA_WIDTH-1:0] convB_WM1 [900-1:0];
    reg [DATA_WIDTH-1:0] convB_WM2 [900-1:0];
    reg [DATA_WIDTH-1:0] convB_WM3 [900-1:0];
   
    reg [DATA_WIDTH-1:0] convA2_WM1 [18000-1:0];
    reg [DATA_WIDTH-1:0] convA2_WM2 [18000-1:0];
    reg [DATA_WIDTH-1:0] convA2_WM3 [18000-1:0];
   
    reg [DATA_WIDTH-1:0] FC1_WM [83:0][119:0];  
    reg [DATA_WIDTH-1:0] FC2_WM [9 :0][83:0];
    
    reg [DATA_WIDTH-1:0] convA1_BM [5:0];
    reg [DATA_WIDTH-1:0] convB_BM [2:0][5:0];
    reg [DATA_WIDTH-1:0] convA2_BM [119:0];
    reg [DATA_WIDTH-1:0] FC1_BM [83:0];
    reg [DATA_WIDTH-1:0] FC2_BM [9:0];
    
    // Inputs
	reg clk;
	reg reset;
	reg [DATA_WIDTH-1:0] riscv_data_bus;
	reg [ADDRESS_BUS-1:0] riscv_address_bus;
	reg initialization_done;
    
	// Outputs
	wire [DATA_WIDTH-1:0] Data_out_1_final; 
    wire [DATA_WIDTH-1:0] Data_out_2_final; 
    wire [DATA_WIDTH-1:0] Data_out_3_final; 
    wire [DATA_WIDTH-1:0] Data_out_4_final; 
    wire [DATA_WIDTH-1:0] Data_out_5_final; 
    wire [DATA_WIDTH-1:0] Data_out_6_final; 
    wire [DATA_WIDTH-1:0] Data_out_7_final; 
    wire [DATA_WIDTH-1:0] Data_out_8_final; 
    wire [DATA_WIDTH-1:0] Data_out_9_final; 
    wire [DATA_WIDTH-1:0] Data_out_10_final;
    wire ready;
    wire output_ready;                   

    ///////////////////////////////////////////
	///Instantiate the Unit Under Test (UUT)///
	///////////////////////////////////////////
	top_module  #(.DATA_WIDTH(DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE))
        uut
        (
		.clk(clk), 
		.reset(reset), 
		.riscv_data_bus(riscv_data_bus), 
		.riscv_address_bus(riscv_address_bus),
		.initialization_done(initialization_done),
		.Data_out_1_final(Data_out_1_final), 
        .Data_out_2_final(Data_out_2_final), 
        .Data_out_3_final(Data_out_3_final), 
        .Data_out_4_final(Data_out_4_final), 
        .Data_out_5_final(Data_out_5_final), 
        .Data_out_6_final(Data_out_6_final), 
        .Data_out_7_final(Data_out_7_final), 
        .Data_out_8_final(Data_out_8_final), 
        .Data_out_9_final(Data_out_9_final), 
        .Data_out_10_final(Data_out_10_final),
        .ready(ready),
        .output_ready(output_ready)                    
	);
	
	always #5 clk = ~clk;

    integer i,j;
    localparam output_file = "files/output/hard/dec/output_file_dec.txt";
    integer output_file_id;
    
    
	initial 
	begin
	
	   output_file_id = $fopen(output_file,"w");
	   
	   if(~output_file_id)
	          $display("failed1");

	   $readmemb("files/input/image_4977_float.txt",input_image2);
	   $readmemb("files/input/image_4979_float.txt",input_image5);
	   $readmemb("files/input/image_5273_float.txt",input_image7);
	   $readmemb("files/input/9.txt",input_image9);

	             
	   $readmemb("files/memory/memory_float/layer_0_mem.txt",convA1_WM1);
	             
	   $readmemb("files/memory/memory_float/layer_3_mem_0.txt",convB_WM1);
	   $readmemb("files/memory/memory_float/layer_3_mem_1.txt",convB_WM2);
	   $readmemb("files/memory/memory_float/layer_3_mem_2.txt",convB_WM3);
	             
	   $readmemb("files/memory/memory_float/layer_6_mem_0.txt",convA2_WM1);
	   $readmemb("files/memory/memory_float/layer_6_mem_1.txt",convA2_WM2);
	   $readmemb("files/memory/memory_float/layer_6_mem_2.txt",convA2_WM3);
                 
	   $readmemb("files/memory/memory_float/layer_10_mem.txt",FC1_WM);
	   $readmemb("files/memory/memory_float/layer_12_mem.txt",FC2_WM);
                 
	   $readmemb("files/memory/memory_float/layer_0_mem_bias.txt",convA1_BM);
	   $readmemb("files/memory/memory_float/layer_3_mem_bias.txt",convB_BM);
	   $readmemb("files/memory/memory_float/layer_6_mem_bias.txt",convA2_BM);
	   $readmemb("files/memory/memory_float/layer_10_mem_bias.txt",FC1_BM);
	   $readmemb("files/memory/memory_float/layer_12_mem_bias.txt",FC2_BM);
	
	
	// Initialize Inputs
	
	clk = 0;
	reset = 1;
	riscv_data_bus = 0;
	initialization_done = 0;
	riscv_address_bus = 22'b00_0000_1000_0000_0000_0000;

    @(negedge clk);
    reset = 0;

////////////////////////////////////////////////////////////////////////////////   
////////////////////////////// ConvA1 WM ///////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////   
    
    // convA1_WM1
    for(j = 0; j < 150 ; j = j + 1)
    begin
        riscv_data_bus=convA1_WM1[j];
        @(negedge clk);
        riscv_address_bus = riscv_address_bus + 1;
            
    end           
        riscv_address_bus = riscv_address_bus & 22'b11_1111_1000_0000_0000_0000;
        riscv_address_bus = riscv_address_bus + 22'b00_0000_1000_0000_0000_0000;          

    // convA1_WM2,3
    for(j = 0; j < 2 ; j = j + 1)
    begin
        riscv_address_bus = riscv_address_bus + 22'b00_0000_1000_0000_0000_0000;    
    end 
    
////////////////////////////////////////////////////////////////////////////////   
/////////////////////////////// ConvB WM ///////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
       
    // convB_WM1
    for(j = 0; j < 900 ; j = j + 1)
    begin   
        riscv_data_bus    = convB_WM1[j];
       @(negedge clk);
        riscv_address_bus = riscv_address_bus + 1;
    end 
        
        riscv_address_bus = riscv_address_bus & 22'b11_1111_1000_0000_0000_0000;
        riscv_address_bus = riscv_address_bus + 22'b00_0000_1000_0000_0000_0000;   
    
    // convB_WM2
    for(j = 0; j < 900 ; j = j + 1)
    begin   
        riscv_data_bus    = convB_WM2[j];
       @(negedge clk);
        riscv_address_bus = riscv_address_bus + 1;
    end 
        
        riscv_address_bus = riscv_address_bus & 22'b11_1111_1000_0000_0000_0000;
        riscv_address_bus = riscv_address_bus + 22'b00_0000_1000_0000_0000_0000;
    
    // convB_WM3
    for(j = 0; j < 900 ; j = j + 1)
    begin   
        riscv_data_bus    = convB_WM3[j];
       @(negedge clk);
        riscv_address_bus = riscv_address_bus + 1;
    end 
        
        riscv_address_bus = riscv_address_bus & 22'b11_1111_1000_0000_0000_0000;
        riscv_address_bus = riscv_address_bus + 22'b00_0000_1000_0000_0000_0000;
          
////////////////////////////////////////////////////////////////////////////////   
////////////////////////////// ConvA2 WM ///////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

    // convA2_WM1
    for(j = 0; j < 18000 ; j = j + 1)
    begin
         riscv_data_bus   = convA2_WM1[j];
        @(negedge clk);
        riscv_address_bus = riscv_address_bus + 1;      
    end 
        
        riscv_address_bus = riscv_address_bus & 22'b11_1111_1000_0000_0000_0000;
        riscv_address_bus = riscv_address_bus + 22'b00_0000_1000_0000_0000_0000; 
        
    // convA2_WM2
    for(j = 0; j < 18000 ; j = j + 1)
    begin
         riscv_data_bus   = convA2_WM2[j];
        @(negedge clk);
        riscv_address_bus = riscv_address_bus + 1;      
    end 
        
        riscv_address_bus = riscv_address_bus & 22'b11_1111_1000_0000_0000_0000;
        riscv_address_bus = riscv_address_bus + 22'b00_0000_1000_0000_0000_0000; 
        
    // convA2_WM3
    for(j = 0; j < 18000 ; j = j + 1)
    begin
         riscv_data_bus   = convA2_WM3[j];
        @(negedge clk);
        riscv_address_bus = riscv_address_bus + 1;      
    end 
        
        riscv_address_bus = riscv_address_bus & 22'b11_1111_1000_0000_0000_0000;
        riscv_address_bus = riscv_address_bus + 22'b00_0000_1000_0000_0000_0000;         
     
////////////////////////////////////////////////////////////////////////////////   
//////////////////////////////// FC 1 WM ///////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
    for(i = 0; i < 84 ; i = i + 1)
    begin
        for(j = 0; j < 120 ; j = j + 1)
        begin
            riscv_data_bus    = FC1_WM[i][j];
            @(negedge clk);
            riscv_address_bus = riscv_address_bus + 1;  
        end        
            riscv_address_bus = riscv_address_bus & 22'b11_1111_1000_0000_0000_0000;
            riscv_address_bus = riscv_address_bus + 22'b00_0000_1000_0000_0000_0000;            
    end  
   
////////////////////////////////////////////////////////////////////////////////   
//////////////////////////////// FC 2 WM ///////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
    for(i = 0; i < 10 ; i = i + 1)
    begin
        for(j = 0; j < 84 ; j = j + 1)
        begin
            riscv_data_bus    = FC2_WM[i][j];
            @(negedge clk);
            riscv_address_bus = riscv_address_bus + 1;        
        end 
            riscv_address_bus = riscv_address_bus & 22'b11_1111_1000_0000_0000_0000;
            riscv_address_bus = riscv_address_bus + 22'b00_0000_1000_0000_0000_0000;            
    end  
   
////////////////////////////////////////////////////////////////////////////////   
////////////////////////////// ConvA1 BM ///////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
   
    for(j = 0; j < 6 ; j = j + 1)
    begin
        riscv_data_bus    = convA1_BM[j];
        @(negedge clk);        
        riscv_address_bus = riscv_address_bus + 1;
    end
                   
        riscv_address_bus = riscv_address_bus & 22'b11_1111_1000_0000_0000_0000;
        riscv_address_bus = riscv_address_bus + 22'b00_0000_1000_0000_0000_0000;            
    
    for(i = 0; i < 3 ; i = i + 1)
    begin   
        for(j = 0; j < 6 ; j = j + 1)
        begin     
            riscv_data_bus    = convB_BM[i][j];
            @(negedge clk);
            riscv_address_bus = riscv_address_bus + 1;
        end 
            riscv_address_bus = riscv_address_bus & 22'b11_1111_1000_0000_0000_0000;
            riscv_address_bus = riscv_address_bus + 22'b00_0000_1000_0000_0000_0000;        
    end
     
    for(j = 0; j < 120 ; j = j + 1)
    begin
        riscv_data_bus    = convA2_BM[j];
        @(negedge clk);
        riscv_address_bus = riscv_address_bus + 1;           
    end 
        
        riscv_address_bus = riscv_address_bus & 22'b11_1111_1000_0000_0000_0000;
        riscv_address_bus = riscv_address_bus + 22'b00_0000_1000_0000_0000_0000;          
      
      
    for(j = 0; j < 84 ; j = j + 1)
    begin
       
        riscv_data_bus    = FC1_BM[j];
        @(negedge clk);
        riscv_address_bus = riscv_address_bus + 1;   
    end 
        
        riscv_address_bus = riscv_address_bus & 22'b11_1111_1000_0000_0000_0000;
        riscv_address_bus = riscv_address_bus + 22'b00_0000_1000_0000_0000_0000;        
    
    
    for(j = 0; j < 10 ; j = j + 1)
    begin       
        riscv_data_bus    = FC2_BM[j];
        @(negedge clk);
        riscv_address_bus = riscv_address_bus + 1;       
    end 
       
        riscv_address_bus = riscv_address_bus & 22'b11_1111_1000_0000_0000_0000;
        riscv_address_bus = riscv_address_bus + 22'b00_0000_1000_0000_0000_0000;   


////////////////////////////////////////
//////////////// IFM ///////////////////
////////////////////////////////////////      
         
    for(j = 0; j < 1024 ; j = j + 1)
    begin
        riscv_data_bus    = input_image2[j];
        @(negedge clk);
        riscv_address_bus = riscv_address_bus + 1;       
    end 
        riscv_address_bus = riscv_address_bus & 22'b11_1111_1000_0000_0000_0000;
    
    initialization_done = 1'b1;
    
    @(negedge clk)
    initialization_done = 1'b0;

////////////////////////////////////////
//////////////// IFM ///////////////////
////////////////////////////////////////      
    
    @(posedge ready)
        
    for(j = 0; j < 1024 ; j = j + 1)
    begin
        riscv_data_bus    = input_image5[j];
        @(negedge clk);
        riscv_address_bus = riscv_address_bus + 1;       
    end 
        riscv_address_bus = riscv_address_bus & 22'b11_1111_1000_0000_0000_0000;
    
    initialization_done = 1'b1;
    
    @(negedge clk)
    initialization_done = 1'b0;      
    
////////////////////////////////////////
//////////////// IFM ///////////////////
////////////////////////////////////////      
/*    
    @(posedge ready)
         
    for(j = 0; j < 1024 ; j = j + 1)
    begin
        riscv_data_bus    = input_image7[j];
        @(negedge clk);
        riscv_address_bus = riscv_address_bus + 1;       
    end 
        riscv_address_bus = riscv_address_bus & 22'b11_1111_1000_0000_0000_0000;
    
    initialization_done = 1'b1;
    
    @(negedge clk)
    initialization_done = 1'b0;      
*/   
end


initial begin  
///////////////////////////////////////////////////////////////
////////////////// Output File ////////////////////////////////
///////////////////////////////////////////////////////////////
    @(negedge reset)
    
    @(negedge output_ready)
    
    $fwrite(output_file_id, "%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n\n" , $bitstoshortreal(Data_out_1_final)
                                                                     , $bitstoshortreal(Data_out_2_final)
                                                                     , $bitstoshortreal(Data_out_3_final)
                                                                     , $bitstoshortreal(Data_out_4_final)
                                                                     , $bitstoshortreal(Data_out_5_final)
                                                                     , $bitstoshortreal(Data_out_6_final)
                                                                     , $bitstoshortreal(Data_out_7_final)
                                                                     , $bitstoshortreal(Data_out_8_final)
                                                                     , $bitstoshortreal(Data_out_9_final)
                                                                     , $bitstoshortreal(Data_out_10_final)
                                                                     );
                                                                     
    @(negedge output_ready)
    
    $fwrite(output_file_id, "%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n\n" , $bitstoshortreal(Data_out_1_final)
                                                                     , $bitstoshortreal(Data_out_2_final)
                                                                     , $bitstoshortreal(Data_out_3_final)
                                                                     , $bitstoshortreal(Data_out_4_final)
                                                                     , $bitstoshortreal(Data_out_5_final)
                                                                     , $bitstoshortreal(Data_out_6_final)
                                                                     , $bitstoshortreal(Data_out_7_final)
                                                                     , $bitstoshortreal(Data_out_8_final)
                                                                     , $bitstoshortreal(Data_out_9_final)
                                                                     , $bitstoshortreal(Data_out_10_final)
                                                                     );
    /*                                                                  	
    @(negedge output_ready)
    
    $fwrite(output_file_id, "%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n\n" , $bitstoshortreal(Data_out_1_final)
                                                                     , $bitstoshortreal(Data_out_2_final)
                                                                     , $bitstoshortreal(Data_out_3_final)
                                                                     , $bitstoshortreal(Data_out_4_final)
                                                                     , $bitstoshortreal(Data_out_5_final)
                                                                     , $bitstoshortreal(Data_out_6_final)
                                                                     , $bitstoshortreal(Data_out_7_final)
                                                                     , $bitstoshortreal(Data_out_8_final)
                                                                     , $bitstoshortreal(Data_out_9_final)
                                                                     , $bitstoshortreal(Data_out_10_final)
                                                                     );                                                                    																	 
                                                                     
*/
$fclose(output_file_id);
 $finish;
           
end       
 
 
endmodule