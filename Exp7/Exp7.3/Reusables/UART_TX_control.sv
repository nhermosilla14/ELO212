module UART_TX_control
#(	parameter INTER_BYTE_DELAY = 1000000,   // ciclos de reloj de espera entre el envio de 2 bytes consecutivos
	parameter DELAY_FOR_ALU = 100 // tiempo de espera para iniciar la transmision luego de registrar el dato a enviar
)(
	input  logic           clock,
	input  logic           reset,
	input  logic           result_enable,             // Push Button
	input  logic [15:0]    dataIn16,       // Dato que se desea transmitir de 16 bits
	output logic [7:0]     tx_data,        // Datos entregados al driver UART para transmision
	output logic           tx_start,       // Pulso para iniciar transmision por la UART
	output logic           busy            // Indica si hay una transmision en proceso
    );
    
    logic [15:0]  tx_data16;
    logic [31:0]  hold_state_timer;
   
    enum logic [2:0] {IDLE, WAIT_FOR_ALU, SEND_BYTE_0, DELAY_BYTE_0, SEND_BYTE_1, DELAY_BYTE_1   } state, next_state;

    // combo logic of FSM
    always_comb begin
        //default assignments
        next_state = state;
		busy = 1'b1;
		tx_start = 1'b0;
		tx_data = tx_data16[7:0];
    	
    	case (state)
                IDLE: 	begin
       			busy = 1'b0;
 			if(result_enable) begin
                		next_state = WAIT_FOR_ALU;
			end
			end
		WAIT_FOR_ALU:  begin
                        if(hold_state_timer >= DELAY_FOR_ALU)
                                next_state=SEND_BYTE_0;
                        end
                SEND_BYTE_0:	begin
                        next_state = DELAY_BYTE_0;
			tx_start = 1'b1;
        		end
          
                DELAY_BYTE_0: 	begin
//tx_data = tx_data16[15:8];
                        if(hold_state_timer >= INTER_BYTE_DELAY) 
               		        next_state = SEND_BYTE_1;
			end

                SEND_BYTE_1: begin
                        tx_data = tx_data16[15:8];
		        next_state = DELAY_BYTE_1;
			tx_start = 1'b1;
			end
								
        	DELAY_BYTE_1: begin
		        if(hold_state_timer >= INTER_BYTE_DELAY)
                                next_state = IDLE;
			end	
    	endcase
    end	

    //when clock ticks, update the state
    always_ff @(posedge clock) begin
    	if(reset)
    		state <= IDLE;
    	else
    		state <= next_state;
	end
	
	// registra los datos a enviar (el resultado de la ALU)
	always_ff @(posedge clock) begin
		if(state == WAIT_FOR_ALU)
			tx_data16 <= dataIn16;
	end
	
	//activa timer para retener un estado por cierto numero de ciclos de reloj
	always_ff @(posedge clock) begin
    	if(state == DELAY_BYTE_0 || state == DELAY_BYTE_1 || state == WAIT_FOR_ALU) begin
    		hold_state_timer <= hold_state_timer + 1;
    	end else begin
    		hold_state_timer <= 0;
    	end
	end

endmodule
