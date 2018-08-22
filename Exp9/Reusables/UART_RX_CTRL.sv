module UART_RX_CTRL(
        input  logic           clock,
	input  logic           reset,
	input  logic           rx_ready,
        input  logic  [7:0]    rx_data,
        output logic  [11:0]   video_data,
        output logic  [2:0]    stateID,
        output logic           rx_ready_12
    );
         logic [7:0] data_br, data_bg, data_bb;
         logic [7:0]  fdce_input;
         logic ret_br, ret_bg, ret_bb;
         assign fdce_input = rx_data;
         assign video_data = {data_br[7:4],data_bg[7:4],data_bb[7:4]};
     
        
         enum logic [2:0] {WAIT_BR, STORE_BR, WAIT_BG, STORE_BG, WAIT_BB, STORE_BB, SEND_RX_READY } state, next_state;
        
    assign stateID = state;
    // combo logic of FSM
    always_comb begin
        //default assignments
        next_state = state;
        ret_br = 'd0;
        ret_bg = 'd0;
        ret_bb = 'd0;
        rx_ready_12 = 1'b0;
    	case (state)
         	WAIT_BR:  begin
		        if (rx_ready)
                            next_state = STORE_BR;
                        else
                            next_state = state;
		        end	
            
               STORE_BR:  begin
		            ret_br = 'd1; 
                            next_state = WAIT_BG;
		        end	
        	
        	WAIT_BG:  begin
		        if (rx_ready)
                            next_state = STORE_BG;
                        else
                            next_state = state;
		        end	
        	
        	STORE_BG:  begin
		            ret_bg = 'd1;
                            next_state = WAIT_BB;
		        end
              	
                WAIT_BB:  begin
		        if (rx_ready)
                            next_state = STORE_BB;
                        else
                            next_state = state;
		        end	
            
               STORE_BB:  begin
		            ret_bb = 'd1; 
                            next_state = SEND_RX_READY;
		        end	                  
                
               SEND_RX_READY: begin
                            rx_ready_12 = 1'b1;
                            next_state = WAIT_BR;
                        end
    	endcase
    end	

////////////////////////////////////////////    
// Flip flops para almacenar los datos de variables, operacion actual y resultados     
          
    FDCE7 #(8) FDCE_BR(
        .clk(clock),
        .reset(reset),
        .valor_entrada(fdce_input),
        .retain(ret_br),
        .valor_salida(data_br)
        );
    FDCE7 #(8) FDCE_BG(
        .clk(clock),
        .reset(reset),
        .valor_entrada(fdce_input),
        .retain(ret_bg),
        .valor_salida(data_bg)
        );
    FDCE7 #(8) FDCE_BB(
        .clk(clock),
        .reset(reset),
        .valor_entrada(fdce_input),
        .retain(ret_bb),
        .valor_salida(data_bb)
        );     
    //when clock ticks, update the state
    always_ff @(posedge clock) 
    begin
    	if(reset)
    		state <= WAIT_BR;
    	else
    		state <= next_state;
	end
endmodule
