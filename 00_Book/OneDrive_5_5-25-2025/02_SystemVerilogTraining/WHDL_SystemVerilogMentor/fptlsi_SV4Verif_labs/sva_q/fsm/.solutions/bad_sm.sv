/*******************************
*  RTL sm
*/

module sm( input wire clk, rst, 
           input wire [3:0] opcode, 
           output wire a_wen_, wd_wen_, rd_wen_, inca);

parameter DLY = 1;
typedef enum logic[3:0] {
  IDLE, WT_WD_1, WT_WD_2, WT_BLK_1, WT_BLK_2,
  WT_BLK_3, WT_BLK_4, WT_BLK_5, RD_WD_1, RD_WD_2
  } state_values;

state_values  state, n_state;  

// state machine output logic
assign a_wen_ = !( state == WT_WD_1  || 
                   state == WT_BLK_1 ||
                   state == RD_WD_1 );
assign wd_wen_ = !( state == WT_WD_2  ||
                    state == WT_BLK_2 ||
                    state == WT_BLK_3 ||
                    state == WT_BLK_4 ||
                    state == WT_BLK_5 );
assign rd_wen_ = !( state == RD_WD_2);
assign inca = ( state == WT_BLK_3 ||    
                state == WT_BLK_4 ||    
                state == WT_BLK_5 );    

// sequential logic
always @ (posedge clk or posedge rst)
  if (rst)
     state <= IDLE;
  else
    state <= #DLY n_state;

// next state logic
always @ (state or opcode)
  case (state)                                                  
     IDLE:           // IDLE                                    
           case (opcode)                                        
             0,1: // nop                                        
                     n_state = IDLE;                            
             2: // wt_wd                                        
                     n_state = WT_WD_1;                         
             3: // wt_blk                                       
                     n_state = WT_BLK_1;                        
             4: // rd_wd                                        
                     n_state = RD_WD_1;                         
             default: begin                                     
                     n_state = IDLE;                            
                     $display ($time,,"illegal op received");   
                     end                                        
           endcase                                              
     WT_WD_1:                                                   
         n_state = IDLE;                                     
     WT_WD_2:                                                   
         n_state = IDLE;                                        
     WT_BLK_1:                                                  
         n_state = WT_BLK_2;                                    
     WT_BLK_2:                                                  
         n_state = WT_BLK_3;                                    
     WT_BLK_3:                                  
         n_state = WT_BLK_4;                                    
     WT_BLK_4:                                                  
         n_state = IDLE;                                    
     WT_BLK_5:                                                  
         n_state = IDLE;                                        
     RD_WD_1:                                                   
         n_state = IDLE;                                     
     RD_WD_2:                                                   
         n_state = IDLE;                                        
     default:                                                   
         n_state = IDLE;                                        
  endcase 




                                                         
endmodule

