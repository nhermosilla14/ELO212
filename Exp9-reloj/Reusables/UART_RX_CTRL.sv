module UART_RX_CTRL(
        input  logic           clock,
	input  logic           reset,
	input  logic           rx_ready,
        input  logic  [7:0]    rx_data,
        output logic  [11:0]   video_data,
        output logic  [1:0]    stateID,
        output logic           rx_ready_12
    );
         logic [7:0] data_lsb, data_msb;
         logic [7:0]  fdce_input;
         logic ret_lsb, ret_msb;
         assign fdce_input = rx_data;
         assign video_data = {data_msb,data_lsb}[11:0];
     
        
         enum logic [1:0] {WAIT_MSB, STORE_MSB, WAIT_LSB, STORE_LSB} state, next_state;
        
    assign stateID = state;
    // combo logic of FSM
    always_comb begin
        //default assignments
        next_state = state;
        ret_msb = 'd0;
        ret_lsb = 'd0;
    	case (state)
         	WAIT_MSB:  begin
		        if (rx_ready)
                            next_state = STORE_MSB;
                        else
                            next_state = state;
		        end	
            
               STORE_MSB:  begin
		            ret_msb = 'd1; 
                            next_state = WAIT_LSB;
		        end	
        	
        	WAIT_LSB:  begin
		        if (rx_ready)
                            next_state = STORE_LSB;
                        else
                            next_state = state;
		        end	
        	
        	STORE_LSB:  begin
		            ret_lsb = 'd1;
                            next_state = WAIT_MSB;
		        end	
    	endcase
    end	

////////////////////////////////////////////    
// Flip flops para almacenar los datos de variables, operacion actual y resultados     
          
    FDCE7 #(8) FDCE_LSB(
        .clk(clock),
        .reset(reset),
        .valor_entrada(fdce_input),
        .retain(ret_lsb),
        .valor_salida(data_lsb)
        );
    FDCE7 #(8) FDCE_MSB(
        .clk(clock),
        .reset(reset),
        .valor_entrada(fdce_input),
        .retain(ret_msb),
        .valor_salida(data_msb)
        );
        
    //when clock ticks, update the state
    always_ff @(posedge clock) 
    begin
    	if(reset)
    		state <= WAIT_MSB;
    	else
    		state <= next_state;
	end
endmodule
