`timescale 1ns / 1ps


module top_module #(parameter ARITH_TYPE = 1,
                              DATA_WIDTH   = 32,
                              ADDRESS_BUS  = 22, 
                              ADDRESS_BITS = 15, 
                              ENABLE_BITS  = 7,  
                              NUMBER_OF_UNITS = 3,
                              
                              IFM_SIZE    = 32,
                              IFM_DEPTH   = 3,
                              // 1.Conv A1
                              CONVA1_KERNAL_SIZE       = 5,
                              CONVA1_NUMBER_OF_FILTERS = 6,
                              // 2.Pool 1
                              POOL1_KERNAL_SIZE = 2,
                              // 3.Conv B
                              CONVB_KERNAL_SIZE       = 5,
                              CONVB_NUMBER_OF_FILTERS = 16,
                              // 4.Pool 2
                              POOL2_KERNAL_SIZE = 2,
                              // 5.Conv A2
                              CONVA2_KERNAL_SIZE       = 5,
                              CONVA2_NUMBER_OF_FILTERS = 120,
                              // 6. Fc1
                              FC1_NUMBER_OF_WM         = 84,
                              // 7.Fc 2
                              FC2_NUMBER_OF_WM         = 10
                              )
    
    ( input clk,
      input reset,
      input [DATA_WIDTH-1:0] riscv_data_bus,
      input [ADDRESS_BUS-1:0]riscv_address_bus,
      input initialization_done,
      
      output [DATA_WIDTH-1:0] Data_out_1_final,
      output [DATA_WIDTH-1:0] Data_out_2_final,
      output [DATA_WIDTH-1:0] Data_out_3_final,
      output [DATA_WIDTH-1:0] Data_out_4_final,
      output [DATA_WIDTH-1:0] Data_out_5_final,
      output [DATA_WIDTH-1:0] Data_out_6_final,
      output [DATA_WIDTH-1:0] Data_out_7_final,
      output [DATA_WIDTH-1:0] Data_out_8_final,
      output [DATA_WIDTH-1:0] Data_out_9_final,
      output [DATA_WIDTH-1:0] Data_out_10_final,
      output ready,
      output output_ready   
    );
    
    localparam CONVA1_IFM_SIZE = IFM_SIZE,
               POOL1_IFM_SIZE  = CONVA1_IFM_SIZE - CONVA1_KERNAL_SIZE + 1,
               CONVB_IFM_SIZE  = POOL1_IFM_SIZE/2,
               POOL2_IFM_SIZE  = CONVB_IFM_SIZE - CONVB_KERNAL_SIZE + 1,
               CONVA2_IFM_SIZE = POOL2_IFM_SIZE/2;
                                         
    localparam CONVA1_ADDRESS_SIZE_IFM = $clog2(CONVA1_IFM_SIZE*CONVA1_IFM_SIZE),
               POOL1_ADDRESS_SIZE_IFM  = $clog2(POOL1_IFM_SIZE*POOL1_IFM_SIZE),
               CONVB_ADDRESS_SIZE_IFM  = $clog2(CONVB_IFM_SIZE*CONVB_IFM_SIZE),
               POOL2_ADDRESS_SIZE_IFM  = $clog2(POOL2_IFM_SIZE*POOL2_IFM_SIZE),
               CONVA2_ADDRESS_SIZE_IFM = $clog2(CONVA2_IFM_SIZE*CONVA2_IFM_SIZE);
        
    localparam CONVA1_IFM_DEPTH = IFM_DEPTH,
               POOL1_IFM_DEPTH  = CONVA1_NUMBER_OF_FILTERS,
               CONVB_IFM_DEPTH  = POOL1_IFM_DEPTH,
               POOL2_IFM_DEPTH  = CONVB_NUMBER_OF_FILTERS,
               CONVA2_IFM_DEPTH = POOL2_IFM_DEPTH,
               FC1_IFM_DEPTH    = CONVA2_NUMBER_OF_FILTERS,
               FC2_IFM_DEPTH    = FC1_NUMBER_OF_WM;
               
    // Outputs of Memory Control
    wire memControl_conva1_start;
    wire [2:0] memControl_conva1_ifm_enable_write;
    wire [2:0] memControl_conva1_wm_enable_write;
    wire [2:0] memControl_convb_wm_enable_write;
    wire [2:0] memControl_conva2_wm_enable_write;
    wire [84-1:0] memControl_fc1_wm_enable_write;
    wire [10-1:0] memControl_fc2_wm_enable_write;
    
    wire [DATA_WIDTH-1:0] memControl_riscv_data;
    wire [ADDRESS_BITS-1:0] memControl_riscv_address;
    
    wire memControl_conva1_bm_enable_write;
    wire [3-1:0] memControl_convb_bm_enable_write;
    wire memControl_conva2_bm_enable_write;
    wire memControl_fc1_bm_enable_write;
    wire memControl_fc2_bm_enable_write;
         
    // Outputs of layer Conv A1
    wire [DATA_WIDTH-1:0]  convA1_data_out_for_next;
    wire [POOL1_ADDRESS_SIZE_IFM-1:0] convA1_ifm_address_write_next;
    wire convA1_ifm_enable_write_next;
    wire convA1_start_to_next;  
    wire convA1_ifm_sel_next;  
         
    // Outputs of Mem_Array 1
    wire [DATA_WIDTH-1:0] mem_arr1_data_out_for_previous;     
    wire [DATA_WIDTH-1:0] mem_arr1_data_out_A_for_next;   
    wire [DATA_WIDTH-1:0] mem_arr1_data_out_B_for_next;
         
    // Outputs of layer Pool 1
    wire pool1_ifm_enable_read_A_current; 
    wire pool1_ifm_enable_read_B_current;
    wire [POOL1_ADDRESS_SIZE_IFM-1:0] pool1_ifm_address_read_A_current;
    wire [POOL1_ADDRESS_SIZE_IFM-1:0] pool1_ifm_address_read_B_current;
    wire pool1_end_to_previous;
    wire [DATA_WIDTH-1:0] pool1_data_out;
    wire [CONVB_ADDRESS_SIZE_IFM-1:0] pool1_ifm_address_write_next;
    wire pool1_ifm_enable_write_next;
    wire pool1_start_to_next;
    wire pool1_ifm_sel_next;  
    
    // Outputs of Mem_Array 2
    wire [DATA_WIDTH-1:0] mem_arr2_data_out_for_previous;     
    wire [DATA_WIDTH-1:0] mem_arr2_data_out_A_for_next;   
    wire [DATA_WIDTH-1:0] mem_arr2_data_out_B_for_next;   
	
    // Outputs of layer Conv B 
    wire convB_end_to_previous;
	wire convB_ifm_enable_read_current;
	wire [CONVB_ADDRESS_SIZE_IFM-1:0] convB_ifm_address_read_current;
	wire convB_ifm_enable_read_next;
	wire convB_ifm_enable_write_next;
    wire [POOL2_ADDRESS_SIZE_IFM-1:0] convB_ifm_address_read_next;
	wire [POOL2_ADDRESS_SIZE_IFM-1:0] convB_ifm_address_write_next;
	wire [DATA_WIDTH-1:0] convB_data_out_for_next1;
    wire [DATA_WIDTH-1:0] convB_data_out_for_next2;
    wire [DATA_WIDTH-1:0] convB_data_out_for_next3;
	wire convB_start_to_next;
	wire [$clog2(POOL2_IFM_DEPTH/NUMBER_OF_UNITS+1)-1:0] convB_ifm_sel_next;
	
	// Outputs of Mem_Array 3
	wire [DATA_WIDTH-1:0] mem_arr3_data_out_for_previous1;     
	wire [DATA_WIDTH-1:0] mem_arr3_data_out_for_previous2;     
	wire [DATA_WIDTH-1:0] mem_arr3_data_out_for_previous3;     
    wire [DATA_WIDTH-1:0] mem_arr3_data_out_A_for_next1;   
    wire [DATA_WIDTH-1:0] mem_arr3_data_out_B_for_next1;
    wire [DATA_WIDTH-1:0] mem_arr3_data_out_A_for_next2;   
    wire [DATA_WIDTH-1:0] mem_arr3_data_out_B_for_next2;
    wire [DATA_WIDTH-1:0] mem_arr3_data_out_A_for_next3;   
    wire [DATA_WIDTH-1:0] mem_arr3_data_out_B_for_next3;
    
    // Outputs of layer Pool 2
    wire pool2_ifm_enable_read_A_current;
    wire pool2_ifm_enable_read_B_current;
	wire [POOL2_ADDRESS_SIZE_IFM-1:0] pool2_ifm_address_read_A_current;
    wire [POOL2_ADDRESS_SIZE_IFM-1:0] pool2_ifm_address_read_B_current;
    wire pool2_end_to_previous;
    wire [DATA_WIDTH-1 : 0] pool2_data_out_1;
    wire [DATA_WIDTH-1 : 0] pool2_data_out_2;
    wire [DATA_WIDTH-1 : 0] pool2_data_out_3;
    wire [CONVA2_ADDRESS_SIZE_IFM-1:0] pool2_ifm_address_write_next;
    wire pool2_ifm_enable_write_next;     
	wire pool2_start_to_next;
	wire [$clog2(CONVA2_IFM_DEPTH/NUMBER_OF_UNITS+1)-1:0] pool2_ifm_sel_next;
	
	// Outputs of Mem_Array 4
	wire [DATA_WIDTH-1:0] mem_arr4_data_out_A_for_previous1;     
	wire [DATA_WIDTH-1:0] mem_arr4_data_out_A_for_previous2;     
	wire [DATA_WIDTH-1:0] mem_arr4_data_out_A_for_previous3;     
    wire [DATA_WIDTH-1:0] mem_arr4_data_out_A_for_next1;   
    wire [DATA_WIDTH-1:0] mem_arr4_data_out_B_for_next1;   
    wire [DATA_WIDTH-1:0] mem_arr4_data_out_A_for_next2;   
    wire [DATA_WIDTH-1:0] mem_arr4_data_out_B_for_next2;   
    wire [DATA_WIDTH-1:0] mem_arr4_data_out_A_for_next3;   
    wire [DATA_WIDTH-1:0] mem_arr4_data_out_B_for_next3;   
	 
    // Outputs of layer Conv A2
    wire convA2_end_to_previous;
    wire convA2_ready;
	wire convA2_ifm_enable_read_current;
	wire [CONVA2_ADDRESS_SIZE_IFM-1:0] convA2_ifm_address_read_current;
    wire [DATA_WIDTH-1:0] convA2_data_out_for_next;
	wire convA2_ifm_enable_write_next;
	wire convA2_ifm_enable_read_next;
	wire convA2_start_to_next;
	wire [$clog2(CONVA2_IFM_DEPTH/NUMBER_OF_UNITS+1)-1:0] convA2_ifm_sel_previous;
	wire                                                  convA2_ifm_sel_next;
    
    //Outputs of Reg_array 1
    wire [DATA_WIDTH-1:0]   reg_arr1_data_out_for_previous;
    wire [DATA_WIDTH-1:0]   reg_arr1_data_out_for_next;
 
    //Outputs of layer FC 1
       wire fc1_enable_read_current;
       wire fc1_end_to_previous;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_1;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_2;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_3;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_4;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_5;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_6;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_7;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_8;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_9;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_10;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_11;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_12;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_13;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_14;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_15;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_16;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_17;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_18;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_19;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_20;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_21;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_22;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_23;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_24;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_25;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_26;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_27;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_28;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_29;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_30;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_31;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_32;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_33;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_34;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_35;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_36;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_37;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_38;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_39;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_40;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_41;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_42;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_43;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_44;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_45;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_46;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_47;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_48;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_49;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_50;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_51;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_52;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_53;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_54;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_55;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_56;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_57;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_58;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_59;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_60;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_61;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_62;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_63;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_64;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_65;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_66;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_67;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_68;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_69;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_70;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_71;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_72;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_73;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_74;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_75;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_76;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_77;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_78;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_79;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_80;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_81;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_82;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_83;
       wire [DATA_WIDTH-1:0] Data_out_FC_1_84;
       
        wire [DATA_WIDTH-1:0] data_bias_FC_1_1; 
       wire [DATA_WIDTH-1:0] data_bias_FC_1_2; 
       wire [DATA_WIDTH-1:0] data_bias_FC_1_3; 
       wire [DATA_WIDTH-1:0] data_bias_FC_1_4; 
       wire [DATA_WIDTH-1:0] data_bias_FC_1_5; 
       wire [DATA_WIDTH-1:0] data_bias_FC_1_6; 
       wire [DATA_WIDTH-1:0] data_bias_FC_1_7; 
       wire [DATA_WIDTH-1:0] data_bias_FC_1_8; 
       wire [DATA_WIDTH-1:0] data_bias_FC_1_9; 
       wire [DATA_WIDTH-1:0] data_bias_FC_1_10;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_11;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_12;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_13;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_14;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_15;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_16;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_17;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_18;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_19;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_20;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_21;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_22;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_23;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_24;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_25;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_26;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_27;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_28;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_29;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_30;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_31;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_32;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_33;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_34;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_35;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_36;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_37;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_38;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_39;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_40;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_41;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_42;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_43;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_44;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_45;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_46;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_47;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_48;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_49;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_50;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_51;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_52;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_53;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_54;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_55;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_56;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_57;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_58;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_59;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_60;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_61;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_62;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_63;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_64;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_65;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_66;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_67;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_68;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_69;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_70;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_71;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_72;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_73;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_74;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_75;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_76;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_77;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_78;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_79;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_80;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_81;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_82;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_83;
       wire [DATA_WIDTH-1:0] data_bias_FC_1_84; 
       
       wire fc1_bias_sel;    
       wire fc1_enable_write_next;
       wire fc1_start_to_next;
       
    // output final Reg_acc_1
       wire [DATA_WIDTH-1:0] out_reg_acc1_1 ; 
       wire [DATA_WIDTH-1:0] out_reg_acc1_2 ; 
       wire [DATA_WIDTH-1:0] out_reg_acc1_3 ; 
       wire [DATA_WIDTH-1:0] out_reg_acc1_4 ; 
       wire [DATA_WIDTH-1:0] out_reg_acc1_5 ; 
       wire [DATA_WIDTH-1:0] out_reg_acc1_6 ; 
       wire [DATA_WIDTH-1:0] out_reg_acc1_7 ; 
       wire [DATA_WIDTH-1:0] out_reg_acc1_8 ; 
       wire [DATA_WIDTH-1:0] out_reg_acc1_9 ; 
       wire [DATA_WIDTH-1:0] out_reg_acc1_10;
       wire [DATA_WIDTH-1:0] out_reg_acc1_11;
       wire [DATA_WIDTH-1:0] out_reg_acc1_12;
       wire [DATA_WIDTH-1:0] out_reg_acc1_13;
       wire [DATA_WIDTH-1:0] out_reg_acc1_14;
       wire [DATA_WIDTH-1:0] out_reg_acc1_15;
       wire [DATA_WIDTH-1:0] out_reg_acc1_16;
       wire [DATA_WIDTH-1:0] out_reg_acc1_17;
       wire [DATA_WIDTH-1:0] out_reg_acc1_18;
       wire [DATA_WIDTH-1:0] out_reg_acc1_19;
       wire [DATA_WIDTH-1:0] out_reg_acc1_20;
       wire [DATA_WIDTH-1:0] out_reg_acc1_21;
       wire [DATA_WIDTH-1:0] out_reg_acc1_22;
       wire [DATA_WIDTH-1:0] out_reg_acc1_23;
       wire [DATA_WIDTH-1:0] out_reg_acc1_24;
       wire [DATA_WIDTH-1:0] out_reg_acc1_25;
       wire [DATA_WIDTH-1:0] out_reg_acc1_26;
       wire [DATA_WIDTH-1:0] out_reg_acc1_27;
       wire [DATA_WIDTH-1:0] out_reg_acc1_28;
       wire [DATA_WIDTH-1:0] out_reg_acc1_29;
       wire [DATA_WIDTH-1:0] out_reg_acc1_30;
       wire [DATA_WIDTH-1:0] out_reg_acc1_31;
       wire [DATA_WIDTH-1:0] out_reg_acc1_32;
       wire [DATA_WIDTH-1:0] out_reg_acc1_33;
       wire [DATA_WIDTH-1:0] out_reg_acc1_34;
       wire [DATA_WIDTH-1:0] out_reg_acc1_35;
       wire [DATA_WIDTH-1:0] out_reg_acc1_36;
       wire [DATA_WIDTH-1:0] out_reg_acc1_37;
       wire [DATA_WIDTH-1:0] out_reg_acc1_38;
       wire [DATA_WIDTH-1:0] out_reg_acc1_39;
       wire [DATA_WIDTH-1:0] out_reg_acc1_40;
       wire [DATA_WIDTH-1:0] out_reg_acc1_41;
       wire [DATA_WIDTH-1:0] out_reg_acc1_42;
       wire [DATA_WIDTH-1:0] out_reg_acc1_43;
       wire [DATA_WIDTH-1:0] out_reg_acc1_44;
       wire [DATA_WIDTH-1:0] out_reg_acc1_45;
       wire [DATA_WIDTH-1:0] out_reg_acc1_46;
       wire [DATA_WIDTH-1:0] out_reg_acc1_47;
       wire [DATA_WIDTH-1:0] out_reg_acc1_48;
       wire [DATA_WIDTH-1:0] out_reg_acc1_49;
       wire [DATA_WIDTH-1:0] out_reg_acc1_50;
       wire [DATA_WIDTH-1:0] out_reg_acc1_51;
       wire [DATA_WIDTH-1:0] out_reg_acc1_52;
       wire [DATA_WIDTH-1:0] out_reg_acc1_53;
       wire [DATA_WIDTH-1:0] out_reg_acc1_54;
       wire [DATA_WIDTH-1:0] out_reg_acc1_55;
       wire [DATA_WIDTH-1:0] out_reg_acc1_56;
       wire [DATA_WIDTH-1:0] out_reg_acc1_57;
       wire [DATA_WIDTH-1:0] out_reg_acc1_58;
       wire [DATA_WIDTH-1:0] out_reg_acc1_59;
       wire [DATA_WIDTH-1:0] out_reg_acc1_60;
       wire [DATA_WIDTH-1:0] out_reg_acc1_61;
       wire [DATA_WIDTH-1:0] out_reg_acc1_62;
       wire [DATA_WIDTH-1:0] out_reg_acc1_63;
       wire [DATA_WIDTH-1:0] out_reg_acc1_64;
       wire [DATA_WIDTH-1:0] out_reg_acc1_65;
       wire [DATA_WIDTH-1:0] out_reg_acc1_66;
       wire [DATA_WIDTH-1:0] out_reg_acc1_67;
       wire [DATA_WIDTH-1:0] out_reg_acc1_68;
       wire [DATA_WIDTH-1:0] out_reg_acc1_69;
       wire [DATA_WIDTH-1:0] out_reg_acc1_70;
       wire [DATA_WIDTH-1:0] out_reg_acc1_71;
       wire [DATA_WIDTH-1:0] out_reg_acc1_72;
       wire [DATA_WIDTH-1:0] out_reg_acc1_73;
       wire [DATA_WIDTH-1:0] out_reg_acc1_74;
       wire [DATA_WIDTH-1:0] out_reg_acc1_75;
       wire [DATA_WIDTH-1:0] out_reg_acc1_76;
       wire [DATA_WIDTH-1:0] out_reg_acc1_77;
       wire [DATA_WIDTH-1:0] out_reg_acc1_78;
       wire [DATA_WIDTH-1:0] out_reg_acc1_79;
       wire [DATA_WIDTH-1:0] out_reg_acc1_80;
       wire [DATA_WIDTH-1:0] out_reg_acc1_81;
       wire [DATA_WIDTH-1:0] out_reg_acc1_82;
       wire [DATA_WIDTH-1:0] out_reg_acc1_83;
       wire [DATA_WIDTH-1:0] out_reg_acc1_84; 
   
    // output final fc2
     wire fc2_bias_sel ;            
     wire fc2_ifm_enable_write_next;      
     wire [DATA_WIDTH-1:0] Data_out_FC_2_1; 
     wire [DATA_WIDTH-1:0] Data_out_FC_2_2; 
     wire [DATA_WIDTH-1:0] Data_out_FC_2_3; 
     wire [DATA_WIDTH-1:0] Data_out_FC_2_4; 
     wire [DATA_WIDTH-1:0] Data_out_FC_2_5; 
     wire [DATA_WIDTH-1:0] Data_out_FC_2_6; 
     wire [DATA_WIDTH-1:0] Data_out_FC_2_7; 
     wire [DATA_WIDTH-1:0] Data_out_FC_2_8; 
     wire [DATA_WIDTH-1:0] Data_out_FC_2_9; 
     wire [DATA_WIDTH-1:0] Data_out_FC_2_10;
     
     wire [DATA_WIDTH-1:0] data_bias_FC_2_1; 
     wire [DATA_WIDTH-1:0] data_bias_FC_2_2; 
     wire [DATA_WIDTH-1:0] data_bias_FC_2_3; 
     wire [DATA_WIDTH-1:0] data_bias_FC_2_4; 
     wire [DATA_WIDTH-1:0] data_bias_FC_2_5; 
     wire [DATA_WIDTH-1:0] data_bias_FC_2_6; 
     wire [DATA_WIDTH-1:0] data_bias_FC_2_7; 
     wire [DATA_WIDTH-1:0] data_bias_FC_2_8; 
     wire [DATA_WIDTH-1:0] data_bias_FC_2_9; 
     wire [DATA_WIDTH-1:0] data_bias_FC_2_10;
     
     //output Reg_acc 2
       wire [DATA_WIDTH-1:0] out_reg_acc2_1 ; 
       wire [DATA_WIDTH-1:0] out_reg_acc2_2 ; 
       wire [DATA_WIDTH-1:0] out_reg_acc2_3 ; 
       wire [DATA_WIDTH-1:0] out_reg_acc2_4 ; 
       wire [DATA_WIDTH-1:0] out_reg_acc2_5 ; 
       wire [DATA_WIDTH-1:0] out_reg_acc2_6 ; 
       wire [DATA_WIDTH-1:0] out_reg_acc2_7 ; 
       wire [DATA_WIDTH-1:0] out_reg_acc2_8 ; 
       wire [DATA_WIDTH-1:0] out_reg_acc2_9 ; 
       wire [DATA_WIDTH-1:0] out_reg_acc2_10;
  
  
    /////////////////////////////////////////
    
    Memory_Control #(.DATA_WIDTH(DATA_WIDTH))
                 
    MEM_Control
    (.clk (clk),
     .riscv_data_bus(riscv_data_bus),
     .riscv_address_bus(riscv_address_bus),
     .initialization_done(initialization_done), 
     .conva1_start(memControl_conva1_start),
     .conva1_ifm_enable_write(memControl_conva1_ifm_enable_write),
     .conva1_wm_enable_write(memControl_conva1_wm_enable_write),
     .convb_wm_enable_write(memControl_convb_wm_enable_write),
     .conva2_wm_enable_write(memControl_conva2_wm_enable_write),
     .fc1_wm_enable_write(memControl_fc1_wm_enable_write),
     .fc2_wm_enable_write(memControl_fc2_wm_enable_write),
     .conva1_bm_enable_write(memControl_conva1_bm_enable_write),
     .convb_bm_enable_write(memControl_convb_bm_enable_write), 
     .conva2_bm_enable_write(memControl_conva2_bm_enable_write),
     .fc1_bm_enable_write(memControl_fc1_bm_enable_write),   
     .fc2_bm_enable_write(memControl_fc2_bm_enable_write),   
     .riscv_data(memControl_riscv_data),
     .riscv_address(memControl_riscv_address)
    
    );
    
    TOP_ConvA1 #(.DATA_WIDTH(DATA_WIDTH),
	             .ARITH_TYPE(ARITH_TYPE),
                 .IFM_SIZE(CONVA1_IFM_SIZE), 
                 .IFM_DEPTH(CONVA1_IFM_DEPTH), 
                 .KERNAL_SIZE(CONVA1_KERNAL_SIZE), 
                 .NUMBER_OF_FILTERS(CONVA1_NUMBER_OF_FILTERS)) 
    ConvA1
    (
     .clk(clk),
	 .reset(reset),
	 .riscv_data(memControl_riscv_data),
	 .riscv_address(memControl_riscv_address),
	 .wm_enable_write(memControl_conva1_wm_enable_write), 
	 .bm_enable_write(memControl_conva1_bm_enable_write), 
	// previous
	 .start_from_previous(memControl_conva1_start),
	 .ifm_enable_write_previous(memControl_conva1_ifm_enable_write),
    // next
	 .end_from_next(pool1_end_to_previous),
	 .data_out_for_next(convA1_data_out_for_next),
	 .ifm_address_write_next(convA1_ifm_address_write_next),
	 .ifm_enable_write_next(convA1_ifm_enable_write_next),
	 .start_to_next(convA1_start_to_next),
	 .ifm_sel_next(convA1_ifm_sel_next),
	 .ready(ready)
    );
    
    mem_array_1 #(.DATA_WIDTH(DATA_WIDTH),
	              .IFM_SIZE(POOL1_IFM_SIZE),
	              .NUMBER_OF_IFM(2),
	              .NUMBER_OF_UNITS(NUMBER_OF_UNITS)   )
    mem_arrr1
    (
    .clk(clk),
	.ifm_sel(convA1_ifm_sel_next),
	.ifm_enable_write_previous(convA1_ifm_enable_write_next),            
	.ifm_enable_read_previous(1'b0), 
	.ifm_address_write_previous(convA1_ifm_address_write_next),
	.ifm_address_read_previous({POOL1_ADDRESS_SIZE_IFM{1'b0}}),	
	.data_in_from_previous(convA1_data_out_for_next),
	.data_out_for_previous(mem_arr1_data_out_for_previous),
	.ifm_enable_read_A_next(pool1_ifm_enable_read_A_current),
    .ifm_enable_read_B_next(pool1_ifm_enable_read_B_current),
	.ifm_address_read_A_next(pool1_ifm_address_read_A_current),
	.ifm_address_read_B_next(pool1_ifm_address_read_B_current),
	.data_out_A_for_next(mem_arr1_data_out_A_for_next),
	.data_out_B_for_next(mem_arr1_data_out_B_for_next)
    );
    
    TOP_Pool1 #(.DATA_WIDTH(DATA_WIDTH),
	            .ARITH_TYPE(ARITH_TYPE),
                .IFM_SIZE(POOL1_IFM_SIZE), 
                .IFM_DEPTH(POOL1_IFM_DEPTH), 
                .KERNAL_SIZE(POOL1_KERNAL_SIZE)) 
    Pool1
    (
	 .clk(clk),
	 .reset(reset),
	 
	 .start_from_previous(convA1_start_to_next),
	 .data_in_A(mem_arr1_data_out_A_for_next),                
     .data_in_B(mem_arr1_data_out_B_for_next),                
     .ifm_enable_read_A_current(pool1_ifm_enable_read_A_current),
     .ifm_enable_read_B_current(pool1_ifm_enable_read_B_current),
     .ifm_address_read_A_current(pool1_ifm_address_read_A_current),
     .ifm_address_read_B_current(pool1_ifm_address_read_B_current),
	 .end_to_previous(pool1_end_to_previous),

     .end_from_next(convB_end_to_previous),
     .data_out(pool1_data_out),
     .ifm_address_write_next(pool1_ifm_address_write_next),
     .ifm_enable_write_next(pool1_ifm_enable_write_next),
     .start_to_next(pool1_start_to_next),
     .ifm_sel_next(pool1_ifm_sel_next)
    );
	
	mem_array_2 #(.DATA_WIDTH(DATA_WIDTH),
	              .IFM_SIZE(CONVB_IFM_SIZE),
	              .NUMBER_OF_IFM(2),
	              .NUMBER_OF_UNITS(NUMBER_OF_UNITS)   )
    mem_arrr2
    (
    .clk(clk),
	.ifm_sel(pool1_ifm_sel_next),
	.ifm_enable_write_previous(pool1_ifm_enable_write_next),            
	.ifm_enable_read_previous(1'b0), 
	.ifm_address_write_previous(pool1_ifm_address_write_next),
	.ifm_address_read_previous({CONVB_ADDRESS_SIZE_IFM{1'b0}}),	
	.data_in_from_previous(pool1_data_out),
	.data_out_for_previous(mem_arr2_data_out_for_previous),
	.ifm_enable_read_A_next(convB_ifm_enable_read_current),
	.ifm_enable_read_B_next(1'b0),
	.ifm_address_read_A_next(convB_ifm_address_read_current),
	.ifm_address_read_B_next({CONVB_ADDRESS_SIZE_IFM{1'b0}}),
	.data_out_A_for_next(mem_arr2_data_out_A_for_next)
    );
    
    
    TOP_ConvB #(.DATA_WIDTH(DATA_WIDTH),
	            .ARITH_TYPE(ARITH_TYPE),
                .IFM_SIZE(CONVB_IFM_SIZE), 
                .IFM_DEPTH(CONVB_IFM_DEPTH), 
                .KERNAL_SIZE(CONVB_KERNAL_SIZE), 
                .NUMBER_OF_FILTERS(CONVB_NUMBER_OF_FILTERS))  
    ConvB 
    (
     .clk (clk),
     .reset (reset),
	 .riscv_data(memControl_riscv_data),
	 .riscv_address(memControl_riscv_address),
	 .wm_enable_write(memControl_convb_wm_enable_write),
	 .bm_enable_write(memControl_convb_bm_enable_write), 
	 .start_from_previous (pool1_start_to_next), 
	 .data_in_from_previous (mem_arr2_data_out_A_for_next),
	 .ifm_enable_read_current(convB_ifm_enable_read_current),
	 .ifm_address_read_current(convB_ifm_address_read_current),
     .end_to_previous (convB_end_to_previous),  
	 .conv_ready(1'b1),
	 .end_from_next (pool2_end_to_previous),
	 .data_in_from_next1 (mem_arr3_data_out_for_previous1),
	 .data_in_from_next2 (mem_arr3_data_out_for_previous2),
	 .data_in_from_next3 (mem_arr3_data_out_for_previous3),
	 .ifm_enable_read_next (convB_ifm_enable_read_next),
	 .ifm_enable_write_next (convB_ifm_enable_write_next),
     .ifm_address_read_next (convB_ifm_address_read_next),
	 .ifm_address_write_next (convB_ifm_address_write_next),
	 .data_out_for_next1 (convB_data_out_for_next1),
	 .data_out_for_next2 (convB_data_out_for_next2),
	 .data_out_for_next3 (convB_data_out_for_next3),
	 .start_to_next (convB_start_to_next),
	 .ifm_sel_next  (convB_ifm_sel_next)
	);
    
    mem_array_3 #(.DATA_WIDTH(DATA_WIDTH),
	              .IFM_SIZE(POOL2_IFM_SIZE),
	              .NUMBER_OF_IFM(POOL2_IFM_DEPTH),
	              .NUMBER_OF_UNITS(NUMBER_OF_UNITS)   )
    mem_arrr3
    (
    .clk(clk),
	.ifm_sel(convB_ifm_sel_next),
	.ifm_enable_write_previous(convB_ifm_enable_write_next),            
	.ifm_enable_read_previous(convB_ifm_enable_read_next), 
	.ifm_address_write_previous(convB_ifm_address_write_next),
	.ifm_address_read_previous(convB_ifm_address_read_next),	
	.data_in_from_previous1(convB_data_out_for_next1),
	.data_in_from_previous2(convB_data_out_for_next2),
	.data_in_from_previous3(convB_data_out_for_next3),
	.data_out_for_previous1(mem_arr3_data_out_for_previous1),
	.data_out_for_previous2(mem_arr3_data_out_for_previous2),
	.data_out_for_previous3(mem_arr3_data_out_for_previous3),
	.ifm_enable_read_A_next(pool2_ifm_enable_read_A_current),
    .ifm_enable_read_B_next(pool2_ifm_enable_read_B_current),
	.ifm_address_read_A_next(pool2_ifm_address_read_A_current),
	.ifm_address_read_B_next(pool2_ifm_address_read_B_current),
	.data_out_A_for_next1(mem_arr3_data_out_A_for_next1),
	.data_out_B_for_next1(mem_arr3_data_out_B_for_next1),
	.data_out_A_for_next2(mem_arr3_data_out_A_for_next2),
	.data_out_B_for_next2(mem_arr3_data_out_B_for_next2),
	.data_out_A_for_next3(mem_arr3_data_out_A_for_next3),
	.data_out_B_for_next3(mem_arr3_data_out_B_for_next3)
    );
    
    TOP_Pool2 #(.DATA_WIDTH(DATA_WIDTH),
	            .ARITH_TYPE(ARITH_TYPE),
                .IFM_SIZE(POOL2_IFM_SIZE), 
                .IFM_DEPTH(POOL2_IFM_DEPTH), 
                .KERNAL_SIZE(POOL2_KERNAL_SIZE)) 
    Pool2
    (
	 .clk(clk),
	 .reset(reset),
	 
	 .start_from_previous(convB_start_to_next),
	 .ifm_enable_read_A_current(pool2_ifm_enable_read_A_current),
	 .ifm_enable_read_B_current(pool2_ifm_enable_read_B_current),
	 .ifm_address_read_A_current(pool2_ifm_address_read_A_current),
	 .ifm_address_read_B_current(pool2_ifm_address_read_B_current),
	 .data_in_A_unit1(mem_arr3_data_out_A_for_next1),
	 .data_in_B_unit1(mem_arr3_data_out_B_for_next1),
     .data_in_A_unit2(mem_arr3_data_out_A_for_next2),
	 .data_in_B_unit2(mem_arr3_data_out_B_for_next2),
	 .data_in_A_unit3(mem_arr3_data_out_A_for_next3),
	 .data_in_B_unit3(mem_arr3_data_out_B_for_next3),
     .end_to_previous (pool2_end_to_previous),
     
     .conv_ready(convA2_ready),
     .end_from_next(convA2_end_to_previous),
     .data_out_1(pool2_data_out_1),
     .data_out_2(pool2_data_out_2),
     .data_out_3(pool2_data_out_3),
     .ifm_address_write_next(pool2_ifm_address_write_next),
     .ifm_enable_write_next(pool2_ifm_enable_write_next),
     .start_to_next(pool2_start_to_next),
     .ifm_sel_next(pool2_ifm_sel_next)
    );
	
	mem_array_4 #(.DATA_WIDTH(DATA_WIDTH),
	              .IFM_SIZE(CONVA2_IFM_SIZE),
	              .NUMBER_OF_IFM(POOL2_IFM_DEPTH),
	              .NUMBER_OF_UNITS(NUMBER_OF_UNITS)   )
    mem_arrr4
    (
    .clk(clk),
	.ifm_sel(convA2_ifm_sel_previous),
	.ifm_enable_write_previous(pool2_ifm_enable_write_next),            
	.ifm_enable_read_previous(1'b0), 
	.ifm_address_write_previous(pool2_ifm_address_write_next),
	.ifm_address_read_previous({CONVA2_ADDRESS_SIZE_IFM{1'b0}}),	
	.data_in_from_previous1(pool2_data_out_1),
	.data_in_from_previous2(pool2_data_out_2),
	.data_in_from_previous3(pool2_data_out_3),
	.data_out_for_previous1(mem_arr4_data_out_A_for_previous1),  
	.data_out_for_previous2(mem_arr4_data_out_A_for_previous2),
	.data_out_for_previous3(mem_arr4_data_out_A_for_previous3),
	.ifm_enable_read_A_next(convA2_ifm_enable_read_current),
	.ifm_enable_read_B_next(1'b0),
	.ifm_address_read_A_next(convA2_ifm_address_read_current),
	.ifm_address_read_B_next({CONVA2_ADDRESS_SIZE_IFM{1'b0}}),
	.data_out_A_for_next1(mem_arr4_data_out_A_for_next1),
	.data_out_A_for_next2(mem_arr4_data_out_A_for_next2),
	.data_out_A_for_next3(mem_arr4_data_out_A_for_next3)
    );
    
    TOP_ConvA2 #(.DATA_WIDTH(DATA_WIDTH),
	             .ARITH_TYPE(ARITH_TYPE),
                 .IFM_SIZE(CONVA2_IFM_SIZE), 
                 .IFM_DEPTH(CONVA2_IFM_DEPTH), 
                 .KERNAL_SIZE(CONVA2_KERNAL_SIZE), 
                 .NUMBER_OF_FILTERS(CONVA2_NUMBER_OF_FILTERS))  
    ConvA2 
    (
     .clk(clk),
	 .reset(reset),
	 .riscv_data(memControl_riscv_data),
	 .riscv_address(memControl_riscv_address),
	 .wm_enable_write(memControl_conva2_wm_enable_write),
	 .bm_enable_write(memControl_conva2_bm_enable_write), 
	 .ifm_sel_previous(convA2_ifm_sel_previous),
	 .ifm_enable_read_current(convA2_ifm_enable_read_current),
	 .ifm_address_read_current(convA2_ifm_address_read_current),
	 .data_in_from_previous1(mem_arr4_data_out_A_for_next1),
	 .data_in_from_previous2(mem_arr4_data_out_A_for_next2),
	 .data_in_from_previous3(mem_arr4_data_out_A_for_next3),
	 .start_from_previous(pool2_start_to_next),
	 .end_to_previous(convA2_end_to_previous), 
	 .ready(convA2_ready),          
    
	 .end_from_next(fc1_end_to_previous),
	 .data_in_from_next(reg_arr1_data_out_for_previous),
	 .data_out_for_next(convA2_data_out_for_next),
	 .ifm_enable_read_next(convA2_ifm_enable_read_next),
	 .ifm_enable_write_next(convA2_ifm_enable_write_next),
	 .start_to_next(convA2_start_to_next),
	 .ifm_sel_next(convA2_ifm_sel_next)
    );
  
   reg_array  #(.DATA_WIDTH(DATA_WIDTH)) reg_array_1
   (
     .clk(clk),
	 .reset(reset),
     .data_in_from_previous(convA2_data_out_for_next),
     .data_out_for_previous(reg_arr1_data_out_for_previous),
     .enable_write_previous(convA2_ifm_enable_write_next),
     .enable_read_previous(convA2_ifm_enable_read_next),
     .ifm_sel(convA2_ifm_sel_next),
     .enable_read_next(fc1_enable_read_current),
     .data_out_for_next(reg_arr1_data_out_for_next)
     );
   
   
  TOP_FC1    #(.DATA_WIDTH(DATA_WIDTH),
               .ARITH_TYPE(ARITH_TYPE),
               .IFM_DEPTH(FC1_IFM_DEPTH))
      FC1
         (.clk(clk),
    	  .reset(reset),
          .riscv_data (memControl_riscv_data),
    	  .riscv_address (memControl_riscv_address),
    	  .wm_enable_write (memControl_fc1_wm_enable_write),
    	  .bm_enable_write(memControl_fc1_bm_enable_write), 
    	 // //////////////////////////////////////previous
    	  .data_in_from_previous(reg_arr1_data_out_for_next),
          .start_from_previous(convA2_start_to_next),
          .end_to_previous(fc1_end_to_previous),   
          .bias_sel(fc1_bias_sel),
          .enable_write_next (fc1_enable_write_next),
          .start_to_next (fc1_start_to_next ),
          .end_from_next (fc2_end_to_previous),
          .enable_read_current (fc1_enable_read_current),
          ///////////////////////////////////
    	  .reg_out_FC_1 ( Data_out_FC_1_1),
          .reg_out_FC_2 ( Data_out_FC_1_2),
          .reg_out_FC_3 ( Data_out_FC_1_3),
          .reg_out_FC_4 ( Data_out_FC_1_4),
          .reg_out_FC_5 ( Data_out_FC_1_5),
          .reg_out_FC_6 ( Data_out_FC_1_6),
          .reg_out_FC_7 ( Data_out_FC_1_7),
          .reg_out_FC_8 ( Data_out_FC_1_8),
          .reg_out_FC_9 ( Data_out_FC_1_9),
          .reg_out_FC_10 (Data_out_FC_1_10),
          .reg_out_FC_11 (Data_out_FC_1_11),
          .reg_out_FC_12 (Data_out_FC_1_12),
          .reg_out_FC_13 (Data_out_FC_1_13),
          .reg_out_FC_14 (Data_out_FC_1_14),
          .reg_out_FC_15 (Data_out_FC_1_15),
          .reg_out_FC_16 (Data_out_FC_1_16),
          .reg_out_FC_17 (Data_out_FC_1_17),
          .reg_out_FC_18 (Data_out_FC_1_18),
          .reg_out_FC_19 (Data_out_FC_1_19),
          .reg_out_FC_20 (Data_out_FC_1_20),
          .reg_out_FC_21 (Data_out_FC_1_21),
          .reg_out_FC_22 (Data_out_FC_1_22),
          .reg_out_FC_23 (Data_out_FC_1_23),
          .reg_out_FC_24 (Data_out_FC_1_24),
          .reg_out_FC_25 (Data_out_FC_1_25),
          .reg_out_FC_26 (Data_out_FC_1_26),
          .reg_out_FC_27 (Data_out_FC_1_27),
          .reg_out_FC_28 (Data_out_FC_1_28),
          .reg_out_FC_29 (Data_out_FC_1_29),
          .reg_out_FC_30 (Data_out_FC_1_30),
          .reg_out_FC_31 (Data_out_FC_1_31),
          .reg_out_FC_32 (Data_out_FC_1_32),
          .reg_out_FC_33 (Data_out_FC_1_33),
          .reg_out_FC_34 (Data_out_FC_1_34),
          .reg_out_FC_35 (Data_out_FC_1_35),
          .reg_out_FC_36 (Data_out_FC_1_36),
          .reg_out_FC_37 (Data_out_FC_1_37),
          .reg_out_FC_38 (Data_out_FC_1_38),
          .reg_out_FC_39 (Data_out_FC_1_39),
          .reg_out_FC_40 (Data_out_FC_1_40),
          .reg_out_FC_41 (Data_out_FC_1_41),
          .reg_out_FC_42 (Data_out_FC_1_42),
          .reg_out_FC_43 (Data_out_FC_1_43),
          .reg_out_FC_44 (Data_out_FC_1_44),
          .reg_out_FC_45 (Data_out_FC_1_45),
          .reg_out_FC_46 (Data_out_FC_1_46),
          .reg_out_FC_47 (Data_out_FC_1_47),
          .reg_out_FC_48 (Data_out_FC_1_48),
          .reg_out_FC_49 (Data_out_FC_1_49),
          .reg_out_FC_50 (Data_out_FC_1_50),
          .reg_out_FC_51 (Data_out_FC_1_51),
          .reg_out_FC_52 (Data_out_FC_1_52),
          .reg_out_FC_53 (Data_out_FC_1_53),
          .reg_out_FC_54 (Data_out_FC_1_54),
          .reg_out_FC_55 (Data_out_FC_1_55),
          .reg_out_FC_56 (Data_out_FC_1_56),
          .reg_out_FC_57 (Data_out_FC_1_57),
          .reg_out_FC_58 (Data_out_FC_1_58),
          .reg_out_FC_59 (Data_out_FC_1_59),
          .reg_out_FC_60 (Data_out_FC_1_60),
          .reg_out_FC_61 (Data_out_FC_1_61),
          .reg_out_FC_62 (Data_out_FC_1_62),
          .reg_out_FC_63 (Data_out_FC_1_63),
          .reg_out_FC_64 (Data_out_FC_1_64),
          .reg_out_FC_65 (Data_out_FC_1_65),
          .reg_out_FC_66 (Data_out_FC_1_66),
          .reg_out_FC_67 (Data_out_FC_1_67),
          .reg_out_FC_68 (Data_out_FC_1_68),
          .reg_out_FC_69 (Data_out_FC_1_69),
          .reg_out_FC_70 (Data_out_FC_1_70),
          .reg_out_FC_71 (Data_out_FC_1_71),
          .reg_out_FC_72 (Data_out_FC_1_72),
          .reg_out_FC_73 (Data_out_FC_1_73),
          .reg_out_FC_74 (Data_out_FC_1_74),
          .reg_out_FC_75 (Data_out_FC_1_75),
          .reg_out_FC_76 (Data_out_FC_1_76),
          .reg_out_FC_77 (Data_out_FC_1_77),
          .reg_out_FC_78 (Data_out_FC_1_78),
          .reg_out_FC_79 (Data_out_FC_1_79),
          .reg_out_FC_80 (Data_out_FC_1_80),
          .reg_out_FC_81 (Data_out_FC_1_81),
          .reg_out_FC_82 (Data_out_FC_1_82),
          .reg_out_FC_83 (Data_out_FC_1_83),
          .reg_out_FC_84 (Data_out_FC_1_84),
          
          .data_bias_1 (data_bias_FC_1_1 ),
          .data_bias_2 (data_bias_FC_1_2 ),
          .data_bias_3 (data_bias_FC_1_3 ),
          .data_bias_4 (data_bias_FC_1_4 ),
          .data_bias_5 (data_bias_FC_1_5 ),
          .data_bias_6 (data_bias_FC_1_6 ),
          .data_bias_7 (data_bias_FC_1_7 ),
          .data_bias_8 (data_bias_FC_1_8 ),
          .data_bias_9 (data_bias_FC_1_9 ),
          .data_bias_10(data_bias_FC_1_10),
          .data_bias_11(data_bias_FC_1_11),
          .data_bias_12(data_bias_FC_1_12),
          .data_bias_13(data_bias_FC_1_13),
          .data_bias_14(data_bias_FC_1_14),
          .data_bias_15(data_bias_FC_1_15),
          .data_bias_16(data_bias_FC_1_16),
          .data_bias_17(data_bias_FC_1_17),
          .data_bias_18(data_bias_FC_1_18),
          .data_bias_19(data_bias_FC_1_19),
          .data_bias_20(data_bias_FC_1_20),
          .data_bias_21(data_bias_FC_1_21),
          .data_bias_22(data_bias_FC_1_22),
          .data_bias_23(data_bias_FC_1_23),
          .data_bias_24(data_bias_FC_1_24),
          .data_bias_25(data_bias_FC_1_25),
          .data_bias_26(data_bias_FC_1_26),
          .data_bias_27(data_bias_FC_1_27),
          .data_bias_28(data_bias_FC_1_28),
          .data_bias_29(data_bias_FC_1_29),
          .data_bias_30(data_bias_FC_1_30),
          .data_bias_31(data_bias_FC_1_31),
          .data_bias_32(data_bias_FC_1_32),
          .data_bias_33(data_bias_FC_1_33),
          .data_bias_34(data_bias_FC_1_34),
          .data_bias_35(data_bias_FC_1_35),
          .data_bias_36(data_bias_FC_1_36),
          .data_bias_37(data_bias_FC_1_37),
          .data_bias_38(data_bias_FC_1_38),
          .data_bias_39(data_bias_FC_1_39),
          .data_bias_40(data_bias_FC_1_40),
          .data_bias_41(data_bias_FC_1_41),
          .data_bias_42(data_bias_FC_1_42),
          .data_bias_43(data_bias_FC_1_43),
          .data_bias_44(data_bias_FC_1_44),
          .data_bias_45(data_bias_FC_1_45),
          .data_bias_46(data_bias_FC_1_46),
          .data_bias_47(data_bias_FC_1_47),
          .data_bias_48(data_bias_FC_1_48),
          .data_bias_49(data_bias_FC_1_49),
          .data_bias_50(data_bias_FC_1_50),
          .data_bias_51(data_bias_FC_1_51),
          .data_bias_52(data_bias_FC_1_52),
          .data_bias_53(data_bias_FC_1_53),
          .data_bias_54(data_bias_FC_1_54),
          .data_bias_55(data_bias_FC_1_55),
          .data_bias_56(data_bias_FC_1_56),
          .data_bias_57(data_bias_FC_1_57),
          .data_bias_58(data_bias_FC_1_58),
          .data_bias_59(data_bias_FC_1_59),
          .data_bias_60(data_bias_FC_1_60),
          .data_bias_61(data_bias_FC_1_61),
          .data_bias_62(data_bias_FC_1_62),
          .data_bias_63(data_bias_FC_1_63),
          .data_bias_64(data_bias_FC_1_64),
          .data_bias_65(data_bias_FC_1_65),
          .data_bias_66(data_bias_FC_1_66),
          .data_bias_67(data_bias_FC_1_67),
          .data_bias_68(data_bias_FC_1_68),
          .data_bias_69(data_bias_FC_1_69),
          .data_bias_70(data_bias_FC_1_70),
          .data_bias_71(data_bias_FC_1_71),
          .data_bias_72(data_bias_FC_1_72),
          .data_bias_73(data_bias_FC_1_73),
          .data_bias_74(data_bias_FC_1_74),
          .data_bias_75(data_bias_FC_1_75),
          .data_bias_76(data_bias_FC_1_76),
          .data_bias_77(data_bias_FC_1_77),
          .data_bias_78(data_bias_FC_1_78),
          .data_bias_79(data_bias_FC_1_79),
          .data_bias_80(data_bias_FC_1_80),
          .data_bias_81(data_bias_FC_1_81),
          .data_bias_82(data_bias_FC_1_82),
          .data_bias_83(data_bias_FC_1_83),
          .data_bias_84(data_bias_FC_1_84)
          
    	);
    		
    		
    Reg_acc_1 #(. DATA_WIDTH (DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE) ) reg_acc1
    (                                                            
    .clk (clk),                                                     
    .reset (reset),                                                
    .bias_sel (fc1_bias_sel),                                                   
    .enable_write (fc1_enable_write_next),                                             
    .Data_in_1   ( Data_out_FC_1_1),                               
    .Data_in_2   ( Data_out_FC_1_2),    
    .Data_in_3   ( Data_out_FC_1_3),    
    .Data_in_4   ( Data_out_FC_1_4),    
    .Data_in_5   ( Data_out_FC_1_5),    
    .Data_in_6   ( Data_out_FC_1_6),    
    .Data_in_7   ( Data_out_FC_1_7),    
    .Data_in_8   ( Data_out_FC_1_8),    
    .Data_in_9   ( Data_out_FC_1_9),    
    .Data_in_10   (Data_out_FC_1_10),   
    .Data_in_11   (Data_out_FC_1_11),   
    .Data_in_12   (Data_out_FC_1_12),   
    .Data_in_13   (Data_out_FC_1_13),   
    .Data_in_14   (Data_out_FC_1_14),   
    .Data_in_15   (Data_out_FC_1_15),   
    .Data_in_16   (Data_out_FC_1_16),   
    .Data_in_17   (Data_out_FC_1_17),   
    .Data_in_18   (Data_out_FC_1_18),   
    .Data_in_19   (Data_out_FC_1_19),   
    .Data_in_20   (Data_out_FC_1_20),   
    .Data_in_21   (Data_out_FC_1_21),   
    .Data_in_22   (Data_out_FC_1_22),   
    .Data_in_23   (Data_out_FC_1_23),   
    .Data_in_24   (Data_out_FC_1_24),   
    .Data_in_25   (Data_out_FC_1_25),   
    .Data_in_26   (Data_out_FC_1_26),   
    .Data_in_27   (Data_out_FC_1_27),   
    .Data_in_28   (Data_out_FC_1_28),   
    .Data_in_29   (Data_out_FC_1_29),   
    .Data_in_30   (Data_out_FC_1_30),   
    .Data_in_31   (Data_out_FC_1_31),   
    .Data_in_32   (Data_out_FC_1_32),   
    .Data_in_33   (Data_out_FC_1_33),   
    .Data_in_34   (Data_out_FC_1_34),   
    .Data_in_35   (Data_out_FC_1_35),   
    .Data_in_36   (Data_out_FC_1_36),   
    .Data_in_37   (Data_out_FC_1_37),   
    .Data_in_38   (Data_out_FC_1_38),   
    .Data_in_39   (Data_out_FC_1_39),   
    .Data_in_40   (Data_out_FC_1_40),   
    .Data_in_41   (Data_out_FC_1_41),   
    .Data_in_42   (Data_out_FC_1_42),   
    .Data_in_43   (Data_out_FC_1_43),   
    .Data_in_44   (Data_out_FC_1_44),   
    .Data_in_45   (Data_out_FC_1_45),   
    .Data_in_46   (Data_out_FC_1_46),   
    .Data_in_47   (Data_out_FC_1_47),   
    .Data_in_48   (Data_out_FC_1_48),   
    .Data_in_49   (Data_out_FC_1_49),   
    .Data_in_50   (Data_out_FC_1_50),   
    .Data_in_51   (Data_out_FC_1_51),   
    .Data_in_52   (Data_out_FC_1_52),   
    .Data_in_53   (Data_out_FC_1_53),   
    .Data_in_54   (Data_out_FC_1_54),   
    .Data_in_55   (Data_out_FC_1_55),   
    .Data_in_56   (Data_out_FC_1_56),   
    .Data_in_57   (Data_out_FC_1_57),   
    .Data_in_58   (Data_out_FC_1_58),   
    .Data_in_59   (Data_out_FC_1_59),   
    .Data_in_60   (Data_out_FC_1_60),   
    .Data_in_61   (Data_out_FC_1_61),   
    .Data_in_62   (Data_out_FC_1_62),   
    .Data_in_63   (Data_out_FC_1_63),   
    .Data_in_64   (Data_out_FC_1_64),   
    .Data_in_65   (Data_out_FC_1_65),   
    .Data_in_66   (Data_out_FC_1_66),   
    .Data_in_67   (Data_out_FC_1_67),   
    .Data_in_68   (Data_out_FC_1_68),   
    .Data_in_69   (Data_out_FC_1_69),   
    .Data_in_70   (Data_out_FC_1_70),   
    .Data_in_71   (Data_out_FC_1_71),   
    .Data_in_72   (Data_out_FC_1_72),   
    .Data_in_73   (Data_out_FC_1_73),   
    .Data_in_74   (Data_out_FC_1_74),   
    .Data_in_75   (Data_out_FC_1_75),   
    .Data_in_76   (Data_out_FC_1_76),   
    .Data_in_77   (Data_out_FC_1_77),   
    .Data_in_78   (Data_out_FC_1_78),   
    .Data_in_79   (Data_out_FC_1_79),   
    .Data_in_80   (Data_out_FC_1_80),   
    .Data_in_81   (Data_out_FC_1_81),   
    .Data_in_82   (Data_out_FC_1_82),   
    .Data_in_83   (Data_out_FC_1_83),   
    .Data_in_84   (Data_out_FC_1_84),   
    . data_bias_1   (data_bias_FC_1_1 ),    
    . data_bias_2   (data_bias_FC_1_2 ),    
    . data_bias_3   (data_bias_FC_1_3 ),    
    . data_bias_4   (data_bias_FC_1_4 ),    
    . data_bias_5   (data_bias_FC_1_5 ),    
    . data_bias_6   (data_bias_FC_1_6 ),    
    . data_bias_7   (data_bias_FC_1_7 ),    
    . data_bias_8   (data_bias_FC_1_8 ),    
    . data_bias_9   (data_bias_FC_1_9 ),    
    . data_bias_10  (data_bias_FC_1_10),    
    . data_bias_11  (data_bias_FC_1_11),    
    . data_bias_12  (data_bias_FC_1_12),    
    . data_bias_13  (data_bias_FC_1_13),    
    . data_bias_14  (data_bias_FC_1_14),    
    . data_bias_15  (data_bias_FC_1_15),    
    . data_bias_16  (data_bias_FC_1_16),    
    . data_bias_17  (data_bias_FC_1_17),    
    . data_bias_18  (data_bias_FC_1_18),    
    . data_bias_19  (data_bias_FC_1_19),    
    . data_bias_20  (data_bias_FC_1_20),    
    . data_bias_21  (data_bias_FC_1_21),    
    . data_bias_22  (data_bias_FC_1_22),    
    . data_bias_23  (data_bias_FC_1_23),    
    . data_bias_24  (data_bias_FC_1_24),    
    . data_bias_25  (data_bias_FC_1_25),    
    . data_bias_26  (data_bias_FC_1_26),    
    . data_bias_27  (data_bias_FC_1_27),    
    . data_bias_28  (data_bias_FC_1_28),    
    . data_bias_29  (data_bias_FC_1_29),    
    . data_bias_30  (data_bias_FC_1_30),    
    . data_bias_31  (data_bias_FC_1_31),    
    . data_bias_32  (data_bias_FC_1_32),    
    . data_bias_33  (data_bias_FC_1_33),    
    . data_bias_34  (data_bias_FC_1_34),    
    . data_bias_35  (data_bias_FC_1_35),    
    . data_bias_36  (data_bias_FC_1_36),    
    . data_bias_37  (data_bias_FC_1_37),    
    . data_bias_38  (data_bias_FC_1_38),    
    . data_bias_39  (data_bias_FC_1_39),    
    . data_bias_40  (data_bias_FC_1_40),    
    . data_bias_41  (data_bias_FC_1_41),    
    . data_bias_42  (data_bias_FC_1_42),    
    . data_bias_43  (data_bias_FC_1_43),    
    . data_bias_44  (data_bias_FC_1_44),    
    . data_bias_45  (data_bias_FC_1_45),    
    . data_bias_46  (data_bias_FC_1_46),    
    . data_bias_47  (data_bias_FC_1_47),    
    . data_bias_48  (data_bias_FC_1_48),    
    . data_bias_49  (data_bias_FC_1_49),    
    . data_bias_50  (data_bias_FC_1_50),    
    . data_bias_51  (data_bias_FC_1_51),    
    . data_bias_52  (data_bias_FC_1_52),    
    . data_bias_53  (data_bias_FC_1_53),    
    . data_bias_54  (data_bias_FC_1_54),    
    . data_bias_55  (data_bias_FC_1_55),    
    . data_bias_56  (data_bias_FC_1_56),    
    . data_bias_57  (data_bias_FC_1_57),    
    . data_bias_58  (data_bias_FC_1_58),    
    . data_bias_59  (data_bias_FC_1_59),    
    . data_bias_60  (data_bias_FC_1_60),    
    . data_bias_61  (data_bias_FC_1_61),    
    . data_bias_62  (data_bias_FC_1_62),    
    . data_bias_63  (data_bias_FC_1_63),    
    . data_bias_64  (data_bias_FC_1_64),    
    . data_bias_65  (data_bias_FC_1_65),    
    . data_bias_66  (data_bias_FC_1_66),    
    . data_bias_67  (data_bias_FC_1_67),    
    . data_bias_68  (data_bias_FC_1_68),    
    . data_bias_69  (data_bias_FC_1_69),    
    . data_bias_70  (data_bias_FC_1_70),    
    . data_bias_71  (data_bias_FC_1_71),    
    . data_bias_72  (data_bias_FC_1_72),    
    . data_bias_73  (data_bias_FC_1_73),    
    . data_bias_74  (data_bias_FC_1_74),    
    . data_bias_75  (data_bias_FC_1_75),    
    . data_bias_76  (data_bias_FC_1_76),    
    . data_bias_77  (data_bias_FC_1_77),    
    . data_bias_78  (data_bias_FC_1_78),    
    . data_bias_79  (data_bias_FC_1_79),    
    . data_bias_80  (data_bias_FC_1_80),    
    . data_bias_81  (data_bias_FC_1_81),    
    . data_bias_82  (data_bias_FC_1_82),    
    . data_bias_83  (data_bias_FC_1_83),    
    . data_bias_84  (data_bias_FC_1_84),  
    .Data_out_FC_1  (out_reg_acc1_1 ),
    .Data_out_FC_2  (out_reg_acc1_2 ),
    .Data_out_FC_3  (out_reg_acc1_3 ),
    .Data_out_FC_4  (out_reg_acc1_4 ),
    .Data_out_FC_5  (out_reg_acc1_5 ),
    .Data_out_FC_6  (out_reg_acc1_6 ),
    .Data_out_FC_7  (out_reg_acc1_7 ),
    .Data_out_FC_8  (out_reg_acc1_8 ),
    .Data_out_FC_9  (out_reg_acc1_9 ),
    .Data_out_FC_10 (out_reg_acc1_10),
    .Data_out_FC_11 (out_reg_acc1_11),
    .Data_out_FC_12 (out_reg_acc1_12),
    .Data_out_FC_13 (out_reg_acc1_13),
    .Data_out_FC_14 (out_reg_acc1_14),
    .Data_out_FC_15 (out_reg_acc1_15),
    .Data_out_FC_16 (out_reg_acc1_16),
    .Data_out_FC_17 (out_reg_acc1_17),
    .Data_out_FC_18 (out_reg_acc1_18),
    .Data_out_FC_19 (out_reg_acc1_19),
    .Data_out_FC_20 (out_reg_acc1_20),
    .Data_out_FC_21 (out_reg_acc1_21),
    .Data_out_FC_22 (out_reg_acc1_22),
    .Data_out_FC_23 (out_reg_acc1_23),
    .Data_out_FC_24 (out_reg_acc1_24),
    .Data_out_FC_25 (out_reg_acc1_25),
    .Data_out_FC_26 (out_reg_acc1_26),
    .Data_out_FC_27 (out_reg_acc1_27),
    .Data_out_FC_28 (out_reg_acc1_28),
    .Data_out_FC_29 (out_reg_acc1_29),
    .Data_out_FC_30 (out_reg_acc1_30),
    .Data_out_FC_31 (out_reg_acc1_31),
    .Data_out_FC_32 (out_reg_acc1_32),
    .Data_out_FC_33 (out_reg_acc1_33),
    .Data_out_FC_34 (out_reg_acc1_34),
    .Data_out_FC_35 (out_reg_acc1_35),
    .Data_out_FC_36 (out_reg_acc1_36),
    .Data_out_FC_37 (out_reg_acc1_37),
    .Data_out_FC_38 (out_reg_acc1_38),
    .Data_out_FC_39 (out_reg_acc1_39),
    .Data_out_FC_40 (out_reg_acc1_40),
    .Data_out_FC_41 (out_reg_acc1_41),
    .Data_out_FC_42 (out_reg_acc1_42),
    .Data_out_FC_43 (out_reg_acc1_43),
    .Data_out_FC_44 (out_reg_acc1_44),
    .Data_out_FC_45 (out_reg_acc1_45),
    .Data_out_FC_46 (out_reg_acc1_46),
    .Data_out_FC_47 (out_reg_acc1_47),
    .Data_out_FC_48 (out_reg_acc1_48),
    .Data_out_FC_49 (out_reg_acc1_49),
    .Data_out_FC_50 (out_reg_acc1_50),
    .Data_out_FC_51 (out_reg_acc1_51),
    .Data_out_FC_52 (out_reg_acc1_52),
    .Data_out_FC_53 (out_reg_acc1_53),
    .Data_out_FC_54 (out_reg_acc1_54),
    .Data_out_FC_55 (out_reg_acc1_55),
    .Data_out_FC_56 (out_reg_acc1_56),
    .Data_out_FC_57 (out_reg_acc1_57),
    .Data_out_FC_58 (out_reg_acc1_58),
    .Data_out_FC_59 (out_reg_acc1_59),
    .Data_out_FC_60 (out_reg_acc1_60),
    .Data_out_FC_61 (out_reg_acc1_61), 		
    .Data_out_FC_62	(out_reg_acc1_62),	
    .Data_out_FC_63	(out_reg_acc1_63),	
    .Data_out_FC_64	(out_reg_acc1_64),	
    .Data_out_FC_65	(out_reg_acc1_65),	
    .Data_out_FC_66	(out_reg_acc1_66),	
    .Data_out_FC_67	(out_reg_acc1_67),	
    .Data_out_FC_68	(out_reg_acc1_68),	
    .Data_out_FC_69	(out_reg_acc1_69),	
    .Data_out_FC_70	(out_reg_acc1_70),	
    .Data_out_FC_71	(out_reg_acc1_71),	
    .Data_out_FC_72	(out_reg_acc1_72),	
    .Data_out_FC_73	(out_reg_acc1_73),	
    .Data_out_FC_74	(out_reg_acc1_74),	
    .Data_out_FC_75	(out_reg_acc1_75),	
    .Data_out_FC_76	(out_reg_acc1_76),	
    .Data_out_FC_77	(out_reg_acc1_77),	
    .Data_out_FC_78	(out_reg_acc1_78),	
    .Data_out_FC_79	(out_reg_acc1_79),	
    .Data_out_FC_80	(out_reg_acc1_80),	
    .Data_out_FC_81	(out_reg_acc1_81),	
    .Data_out_FC_82	(out_reg_acc1_82),	
    .Data_out_FC_83	(out_reg_acc1_83),	
    .Data_out_FC_84	(out_reg_acc1_84));	
    		
    TOP_FC2  #(.DATA_WIDTH(DATA_WIDTH),
	           .ARITH_TYPE(ARITH_TYPE),
               .IFM_DEPTH(FC2_IFM_DEPTH))
    FC2
    (
     .clk (clk),
	 .reset (reset),
    /////////////Initialzation Weight Mmeory
     .riscv_data (memControl_riscv_data),
	 .riscv_address (memControl_riscv_address),
     .wm_enable_write (memControl_fc2_wm_enable_write),
     .bm_enable_write (memControl_fc2_bm_enable_write), 
	 /////////////////////
     .start_from_previous (fc1_start_to_next),
     .end_to_previous     (fc2_end_to_previous),
     .bias_sel (fc2_bias_sel),
     .ifm_enable_write_next (fc2_ifm_enable_write_next),
     .output_ready (output_ready),
	 .Data_in_1 ( out_reg_acc1_1  ),
     .Data_in_2 ( out_reg_acc1_2  ),
     .Data_in_3 ( out_reg_acc1_3  ),
     .Data_in_4 ( out_reg_acc1_4  ),
     .Data_in_5 ( out_reg_acc1_5  ),
     .Data_in_6 ( out_reg_acc1_6  ),
     .Data_in_7 ( out_reg_acc1_7  ),
     .Data_in_8 ( out_reg_acc1_8  ),
     .Data_in_9 ( out_reg_acc1_9  ),
     .Data_in_10 (out_reg_acc1_10),
     .Data_in_11 (out_reg_acc1_11),
     .Data_in_12 (out_reg_acc1_12),
     .Data_in_13 (out_reg_acc1_13),
     .Data_in_14 (out_reg_acc1_14),
     .Data_in_15 (out_reg_acc1_15),
     .Data_in_16 (out_reg_acc1_16),
     .Data_in_17 (out_reg_acc1_17),
     .Data_in_18 (out_reg_acc1_18),
     .Data_in_19 (out_reg_acc1_19),
     .Data_in_20 (out_reg_acc1_20),
     .Data_in_21 (out_reg_acc1_21),
     .Data_in_22 (out_reg_acc1_22),
     .Data_in_23 (out_reg_acc1_23),
     .Data_in_24 (out_reg_acc1_24),
     .Data_in_25 (out_reg_acc1_25),
     .Data_in_26 (out_reg_acc1_26),
     .Data_in_27 (out_reg_acc1_27),
     .Data_in_28 (out_reg_acc1_28),
     .Data_in_29 (out_reg_acc1_29),
     .Data_in_30 (out_reg_acc1_30),
     .Data_in_31 (out_reg_acc1_31),
     .Data_in_32 (out_reg_acc1_32),
     .Data_in_33 (out_reg_acc1_33),
     .Data_in_34 (out_reg_acc1_34),
     .Data_in_35 (out_reg_acc1_35),
     .Data_in_36 (out_reg_acc1_36),
     .Data_in_37 (out_reg_acc1_37),
     .Data_in_38 (out_reg_acc1_38),
     .Data_in_39 (out_reg_acc1_39),
     .Data_in_40 (out_reg_acc1_40),
     .Data_in_41 (out_reg_acc1_41),
     .Data_in_42 (out_reg_acc1_42),
     .Data_in_43 (out_reg_acc1_43),
     .Data_in_44 (out_reg_acc1_44),
     .Data_in_45 (out_reg_acc1_45),
     .Data_in_46 (out_reg_acc1_46),
     .Data_in_47 (out_reg_acc1_47),
     .Data_in_48 (out_reg_acc1_48),
     .Data_in_49 (out_reg_acc1_49),
     .Data_in_50 (out_reg_acc1_50),
     .Data_in_51 (out_reg_acc1_51),
     .Data_in_52 (out_reg_acc1_52),
     .Data_in_53 (out_reg_acc1_53),
     .Data_in_54 (out_reg_acc1_54),
     .Data_in_55 (out_reg_acc1_55),
     .Data_in_56 (out_reg_acc1_56),
     .Data_in_57 (out_reg_acc1_57),
     .Data_in_58 (out_reg_acc1_58),
     .Data_in_59 (out_reg_acc1_59),
     .Data_in_60 (out_reg_acc1_60),
     .Data_in_61 (out_reg_acc1_61),
     .Data_in_62 (out_reg_acc1_62),
     .Data_in_63 (out_reg_acc1_63),
     .Data_in_64 (out_reg_acc1_64),
     .Data_in_65 (out_reg_acc1_65),
     .Data_in_66 (out_reg_acc1_66),
     .Data_in_67 (out_reg_acc1_67),
     .Data_in_68 (out_reg_acc1_68),
     .Data_in_69 (out_reg_acc1_69),
     .Data_in_70 (out_reg_acc1_70),
     .Data_in_71 (out_reg_acc1_71),
     .Data_in_72 (out_reg_acc1_72),
     .Data_in_73 (out_reg_acc1_73),
     .Data_in_74 (out_reg_acc1_74),
     .Data_in_75 (out_reg_acc1_75),
     .Data_in_76 (out_reg_acc1_76),
     .Data_in_77 (out_reg_acc1_77),
     .Data_in_78 (out_reg_acc1_78),
     .Data_in_79 (out_reg_acc1_79),
     .Data_in_80 (out_reg_acc1_80),
     .Data_in_81 (out_reg_acc1_81),
     .Data_in_82 (out_reg_acc1_82),
     .Data_in_83 (out_reg_acc1_83),
     .Data_in_84 (out_reg_acc1_84),
     
     .data_bias_1 (data_bias_FC_2_1 ),
     .data_bias_2 (data_bias_FC_2_2 ),
     .data_bias_3 (data_bias_FC_2_3 ),
     .data_bias_4 (data_bias_FC_2_4 ),
     .data_bias_5 (data_bias_FC_2_5 ),
     .data_bias_6 (data_bias_FC_2_6 ),
     .data_bias_7 (data_bias_FC_2_7 ),
     .data_bias_8 (data_bias_FC_2_8 ),
     .data_bias_9 (data_bias_FC_2_9 ),
     .data_bias_10(data_bias_FC_2_10),
    
       
	 .reg_out_FC_1 ( Data_out_FC_2_1),       
     .reg_out_FC_2 ( Data_out_FC_2_2),    
     .reg_out_FC_3 ( Data_out_FC_2_3),    
     .reg_out_FC_4 ( Data_out_FC_2_4),    
     .reg_out_FC_5 ( Data_out_FC_2_5),    
     .reg_out_FC_6 ( Data_out_FC_2_6),    
     .reg_out_FC_7 ( Data_out_FC_2_7),    
     .reg_out_FC_8 ( Data_out_FC_2_8),    
     .reg_out_FC_9 ( Data_out_FC_2_9),    
     .reg_out_FC_10 (Data_out_FC_2_10) 
	 );
  Reg_acc_2 #(. DATA_WIDTH (DATA_WIDTH), .ARITH_TYPE(ARITH_TYPE)) reg_acc2
     (                                                            
     . clk (clk),                                                     
     . reset (reset),                                                
     . bias_sel (fc2_bias_sel),                                                   
     . enable_write (fc2_ifm_enable_write_next),                                             
     . Data_in_1   ( Data_out_FC_2_1),                               
     . Data_in_2   ( Data_out_FC_2_2),    
     . Data_in_3   ( Data_out_FC_2_3),    
     . Data_in_4   ( Data_out_FC_2_4),    
     . Data_in_5   ( Data_out_FC_2_5),    
     . Data_in_6   ( Data_out_FC_2_6),    
     . Data_in_7   ( Data_out_FC_2_7),    
     . Data_in_8   ( Data_out_FC_2_8),    
     . Data_in_9   ( Data_out_FC_2_9),    
     . Data_in_10   (Data_out_FC_2_10),  
      
    . data_bias_1   (data_bias_FC_2_1 ),    
    . data_bias_2   (data_bias_FC_2_2 ),    
    . data_bias_3   (data_bias_FC_2_3 ),    
    . data_bias_4   (data_bias_FC_2_4 ),    
    . data_bias_5   (data_bias_FC_2_5 ),    
    . data_bias_6   (data_bias_FC_2_6 ),    
    . data_bias_7   (data_bias_FC_2_7 ),    
    . data_bias_8   (data_bias_FC_2_8 ),    
    . data_bias_9   (data_bias_FC_2_9 ),    
    . data_bias_10  (data_bias_FC_2_10),     
     
    . Data_out_FC_1  (Data_out_1_final),
    . Data_out_FC_2  (Data_out_2_final),
    . Data_out_FC_3  (Data_out_3_final),
    . Data_out_FC_4  (Data_out_4_final),
    . Data_out_FC_5  (Data_out_5_final),
    . Data_out_FC_6  (Data_out_6_final),
    . Data_out_FC_7  (Data_out_7_final),
    . Data_out_FC_8  (Data_out_8_final),
    . Data_out_FC_9  (Data_out_9_final),
    . Data_out_FC_10 (Data_out_10_final)
    );	
endmodule

