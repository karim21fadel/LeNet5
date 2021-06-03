module FIFO_84outputs_FC1 #(parameter DATA_WIDTH      = 32,
                            ADDRESS_BITS    = 15,
                            ////////////////////////////////////
                            IFM_DEPTH       = 120,
                            IFM_SIZE        = 1,
                            ADDRESS_SIZE_WM = $clog2(IFM_DEPTH),      
                            NUMBER_OF_WM    = 84
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
       output [DATA_WIDTH-1:0] fifo_data_out_10, 
       output [DATA_WIDTH-1:0] fifo_data_out_11, 
       output [DATA_WIDTH-1:0] fifo_data_out_12, 
       output [DATA_WIDTH-1:0] fifo_data_out_13, 
       output [DATA_WIDTH-1:0] fifo_data_out_14, 
       output [DATA_WIDTH-1:0] fifo_data_out_15, 
       output [DATA_WIDTH-1:0] fifo_data_out_16, 
       output [DATA_WIDTH-1:0] fifo_data_out_17, 
       output [DATA_WIDTH-1:0] fifo_data_out_18, 
       output [DATA_WIDTH-1:0] fifo_data_out_19, 
       output [DATA_WIDTH-1:0] fifo_data_out_20, 
       output [DATA_WIDTH-1:0] fifo_data_out_21, 
       output [DATA_WIDTH-1:0] fifo_data_out_22, 
       output [DATA_WIDTH-1:0] fifo_data_out_23, 
       output [DATA_WIDTH-1:0] fifo_data_out_24, 
       output [DATA_WIDTH-1:0] fifo_data_out_25, 
       output [DATA_WIDTH-1:0] fifo_data_out_26, 
       output [DATA_WIDTH-1:0] fifo_data_out_27, 
       output [DATA_WIDTH-1:0] fifo_data_out_28, 
       output [DATA_WIDTH-1:0] fifo_data_out_29, 
       output [DATA_WIDTH-1:0] fifo_data_out_30, 
       output [DATA_WIDTH-1:0] fifo_data_out_31, 
       output [DATA_WIDTH-1:0] fifo_data_out_32, 
       output [DATA_WIDTH-1:0] fifo_data_out_33, 
       output [DATA_WIDTH-1:0] fifo_data_out_34, 
       output [DATA_WIDTH-1:0] fifo_data_out_35, 
       output [DATA_WIDTH-1:0] fifo_data_out_36, 
       output [DATA_WIDTH-1:0] fifo_data_out_37, 
       output [DATA_WIDTH-1:0] fifo_data_out_38, 
       output [DATA_WIDTH-1:0] fifo_data_out_39, 
       output [DATA_WIDTH-1:0] fifo_data_out_40, 
       output [DATA_WIDTH-1:0] fifo_data_out_41, 
       output [DATA_WIDTH-1:0] fifo_data_out_42, 
       output [DATA_WIDTH-1:0] fifo_data_out_43, 
       output [DATA_WIDTH-1:0] fifo_data_out_44, 
       output [DATA_WIDTH-1:0] fifo_data_out_45, 
       output [DATA_WIDTH-1:0] fifo_data_out_46, 
       output [DATA_WIDTH-1:0] fifo_data_out_47, 
       output [DATA_WIDTH-1:0] fifo_data_out_48, 
       output [DATA_WIDTH-1:0] fifo_data_out_49, 
       output [DATA_WIDTH-1:0] fifo_data_out_50, 
       output [DATA_WIDTH-1:0] fifo_data_out_51, 
       output [DATA_WIDTH-1:0] fifo_data_out_52, 
       output [DATA_WIDTH-1:0] fifo_data_out_53, 
       output [DATA_WIDTH-1:0] fifo_data_out_54, 
       output [DATA_WIDTH-1:0] fifo_data_out_55, 
       output [DATA_WIDTH-1:0] fifo_data_out_56, 
       output [DATA_WIDTH-1:0] fifo_data_out_57, 
       output [DATA_WIDTH-1:0] fifo_data_out_58, 
       output [DATA_WIDTH-1:0] fifo_data_out_59, 
       output [DATA_WIDTH-1:0] fifo_data_out_60, 
       output [DATA_WIDTH-1:0] fifo_data_out_61, 
       output [DATA_WIDTH-1:0] fifo_data_out_62, 
       output [DATA_WIDTH-1:0] fifo_data_out_63, 
       output [DATA_WIDTH-1:0] fifo_data_out_64, 
       output [DATA_WIDTH-1:0] fifo_data_out_65, 
       output [DATA_WIDTH-1:0] fifo_data_out_66, 
       output [DATA_WIDTH-1:0] fifo_data_out_67, 
       output [DATA_WIDTH-1:0] fifo_data_out_68, 
       output [DATA_WIDTH-1:0] fifo_data_out_69, 
       output [DATA_WIDTH-1:0] fifo_data_out_70, 
       output [DATA_WIDTH-1:0] fifo_data_out_71, 
       output [DATA_WIDTH-1:0] fifo_data_out_72, 
       output [DATA_WIDTH-1:0] fifo_data_out_73, 
       output [DATA_WIDTH-1:0] fifo_data_out_74, 
       output [DATA_WIDTH-1:0] fifo_data_out_75, 
       output [DATA_WIDTH-1:0] fifo_data_out_76, 
       output [DATA_WIDTH-1:0] fifo_data_out_77, 
       output [DATA_WIDTH-1:0] fifo_data_out_78, 
       output [DATA_WIDTH-1:0] fifo_data_out_79, 
       output [DATA_WIDTH-1:0] fifo_data_out_80, 
       output [DATA_WIDTH-1:0] fifo_data_out_81, 
       output [DATA_WIDTH-1:0] fifo_data_out_82, 
       output [DATA_WIDTH-1:0] fifo_data_out_83, 
       output [DATA_WIDTH-1:0] fifo_data_out_84  
    );
    
    reg [DATA_WIDTH-1:0] FIFO  [84-1:0];
  
   
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
    
    assign fifo_data_out_84 = FIFO[0 ];
    assign fifo_data_out_83 = FIFO[1 ];
    assign fifo_data_out_82 = FIFO[2 ];
    assign fifo_data_out_81 = FIFO[3 ];
    assign fifo_data_out_80 = FIFO[4 ];
    assign fifo_data_out_79 = FIFO[5 ];
    assign fifo_data_out_78 = FIFO[6 ];
    assign fifo_data_out_77 = FIFO[7 ];
    assign fifo_data_out_76 = FIFO[8 ];
    assign fifo_data_out_75 = FIFO[9 ];
    assign fifo_data_out_74 = FIFO[10];
    assign fifo_data_out_73 = FIFO[11];
    assign fifo_data_out_72 = FIFO[12];
    assign fifo_data_out_71 = FIFO[13];
    assign fifo_data_out_70 = FIFO[14];
    assign fifo_data_out_69 = FIFO[15];
    assign fifo_data_out_68 = FIFO[16];
    assign fifo_data_out_67 = FIFO[17];
    assign fifo_data_out_66 = FIFO[18];
    assign fifo_data_out_65 = FIFO[19];
    assign fifo_data_out_64 = FIFO[20];
    assign fifo_data_out_63 = FIFO[21];
    assign fifo_data_out_62 = FIFO[22];
    assign fifo_data_out_61 = FIFO[23];
    assign fifo_data_out_60 = FIFO[24];
    assign fifo_data_out_59 = FIFO[25];
    assign fifo_data_out_58 = FIFO[26];
    assign fifo_data_out_57 = FIFO[27];
    assign fifo_data_out_56 = FIFO[28];
    assign fifo_data_out_55 = FIFO[29];
    assign fifo_data_out_54 = FIFO[30];
    assign fifo_data_out_53 = FIFO[31];
    assign fifo_data_out_52 = FIFO[32];
    assign fifo_data_out_51 = FIFO[33];
    assign fifo_data_out_50 = FIFO[34];
    assign fifo_data_out_49 = FIFO[35];
    assign fifo_data_out_48 = FIFO[36];
    assign fifo_data_out_47 = FIFO[37];
    assign fifo_data_out_46 = FIFO[38];
    assign fifo_data_out_45 = FIFO[39];
    assign fifo_data_out_44 = FIFO[40];
    assign fifo_data_out_43 = FIFO[41];
    assign fifo_data_out_42 = FIFO[42];
    assign fifo_data_out_41 = FIFO[43];
    assign fifo_data_out_40 = FIFO[44];
    assign fifo_data_out_39 = FIFO[45];
    assign fifo_data_out_38 = FIFO[46];
    assign fifo_data_out_37 = FIFO[47];
    assign fifo_data_out_36 = FIFO[48];
    assign fifo_data_out_35 = FIFO[49];
    assign fifo_data_out_34 = FIFO[50];
    assign fifo_data_out_33 = FIFO[51];
    assign fifo_data_out_32 = FIFO[52];
    assign fifo_data_out_31 = FIFO[53];
    assign fifo_data_out_30 = FIFO[54];
    assign fifo_data_out_29 = FIFO[55];
    assign fifo_data_out_28 = FIFO[56];
    assign fifo_data_out_27 = FIFO[57];
    assign fifo_data_out_26 = FIFO[58];
    assign fifo_data_out_25 = FIFO[59];
    assign fifo_data_out_24 = FIFO[60];
    assign fifo_data_out_23 = FIFO[61];
    assign fifo_data_out_22 = FIFO[62];
    assign fifo_data_out_21 = FIFO[63];
    assign fifo_data_out_20 = FIFO[64];
    assign fifo_data_out_19 = FIFO[65];
    assign fifo_data_out_18 = FIFO[66];
    assign fifo_data_out_17 = FIFO[67];
    assign fifo_data_out_16 = FIFO[68];
    assign fifo_data_out_15 = FIFO[69];
    assign fifo_data_out_14 = FIFO[70];
    assign fifo_data_out_13 = FIFO[71];
    assign fifo_data_out_12 = FIFO[72];
    assign fifo_data_out_11 = FIFO[73];
    assign fifo_data_out_10 = FIFO[74];
    assign fifo_data_out_9 = FIFO[75];
    assign fifo_data_out_8 = FIFO[76];
    assign fifo_data_out_7 = FIFO[77];
    assign fifo_data_out_6 = FIFO[78];
    assign fifo_data_out_5 = FIFO[79];
    assign fifo_data_out_4 = FIFO[80];
    assign fifo_data_out_3 = FIFO[81];
    assign fifo_data_out_2 = FIFO[82];
    assign fifo_data_out_1 = FIFO[83];
           
           
           
           
endmodule    