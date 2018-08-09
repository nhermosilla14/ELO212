module UART_RX_CTRL
#(	parameter INTER_BYTE_DELAY = 1000000,   // ciclos de reloj de espera entre el envio de 2 bytes consecutivos
	parameter DELAY_FOR_ALU = 100 // tiempo de espera para iniciar la transmision luego de registrar el dato a enviar
)(
        input  logic           clock,
	input  logic           reset,
	input  logic           rx_ready,
        input  logic  [7:0]    rx_data,
        output logic  [15:0]   OP1,
        output logic  [15:0]   OP2,
        output logic  [1:0]    CMD,
        output logic           trigger_tx_result,
        output logic  [3:0]    stateID
    );
         logic [7:0] d_op1_lsb, d_op1_msb, d_op2_lsb, d_op2_msb;
         logic [1:0] d_cmd;
         logic ret_op1_lsb, ret_op1_msb, ret_op2_lsb, ret_op2_msb, ret_cmd;  //trigger retenedores
         logic [7:0]  fdce_input;
         assign fdce_input = rx_data;
         assign OP1 = {d_op1_msb,d_op1_lsb};
         assign OP2 = {d_op2_msb,d_op2_lsb};
         assign CMD = d_cmd;
        
         localparam Wait_OP1_LSB      = 4'b0001;
         localparam Store_OP1_LSB     = 4'b0010;
         localparam Wait_OP1_MSB      = 4'b0011;
         localparam Store_OP1_MSB     = 4'b0100;
         localparam Wait_OP2_LSB      = 4'b0101;
         localparam Store_OP2_LSB     = 4'b0110;
         localparam Wait_OP2_MSB      = 4'b0111;
         localparam Store_OP2_MSB     = 4'b1000;
         localparam Wait_CMD          = 4'b1001;
         localparam Store_CMD         = 4'b1010;
         localparam Delay_1_cycle     = 4'b1011;
         localparam Trigger_TX_result = 4'b1100;
         
         logic [3:0] state, next_state;
 



 //   enum logic [3:0] {Wait_OP1_LSB, Store_OP1_LSB, Wait_OP1_MSB, Store_OP1_MSB, Wait_OP2_LSB, Store_OP2_LSB, Wait_OP2_MSB, Store_OP2_MSB, Wait_CMD, Store_CMD, Delay_1_cycle, Trigger_TX_result } state, next_state;
    assign stateID = state;
    // combo logic of FSM
    always_comb begin
        //default assignments
        next_state = state;
        ret_op1_lsb = 'd0;
        ret_op1_msb = 'd0;
        ret_op2_lsb = 'd0;
        ret_op2_msb = 'd0;
        ret_cmd = 'd0;
        trigger_tx_result = 'd0;
    	case (state)
         	Wait_OP1_LSB:  begin
		        if (rx_ready)
                            next_state = Store_OP1_LSB;
                        else
                            next_state = state;
		        end	
            
               Store_OP1_LSB:  begin
		            ret_op1_lsb = 'd1; 
                            next_state = Wait_OP1_MSB;
		        end	
        	
        	Wait_OP1_MSB:  begin
		        if (rx_ready)
                            next_state = Store_OP1_MSB;
                        else
                            next_state = state;
		        end	
        	
        	Store_OP1_MSB:  begin
		            ret_op1_msb = 'd1;
                            next_state = Wait_OP2_LSB;
		        end	
        	
        	Wait_OP2_LSB:  begin //5
		        if (rx_ready)
                            next_state = Store_OP2_LSB;
                        else
                            next_state = state;
		        end	
            
               Store_OP2_LSB:  begin
		            ret_op2_lsb = 'd1;
                            next_state = Wait_OP2_MSB;
		        end	
        	
        	Wait_OP2_MSB:  begin
		        if (rx_ready)
                            next_state = Store_OP2_MSB;
                        else
                            next_state = state;
		        end	
        	
        	Store_OP2_MSB:  begin
		            ret_op2_msb = 'd1;
                            next_state = Wait_CMD;
		        end	
        	
        	Wait_CMD:  begin //9
		        if (rx_ready)
                            next_state = Store_CMD;
                        else
                            next_state = state;
		        end	
        	
        	Store_CMD:  begin
		            ret_cmd = 'd1;
                            next_state = Delay_1_cycle;
		        end	
        	
        	Delay_1_cycle:  begin
		           next_state = Trigger_TX_result;
		        end	
        	
        	Trigger_TX_result:  begin
                           trigger_tx_result = 'd1;
		           next_state = Wait_OP1_LSB;
		        end	
    	
    	endcase
    end	

////////////////////////////////////////////    
// Flip flops para almacenar los datos de variables, operacion actual y resultados     
          
    FDCE7 #(8) FDCE_OP1_LSB(
        .clk(clock),
        .reset(reset),
        .valor_entrada(fdce_input),
        .retain(ret_op1_lsb),
        .valor_salida(d_op1_lsb)
        );
    FDCE7 #(8) FDCE_OP1_MSB(
        .clk(clock),
        .reset(reset),
        .valor_entrada(fdce_input),
        .retain(ret_op1_msb),
        .valor_salida(d_op1_msb)
        );
    FDCE7 #(8) FDCE_OP2_LSB(
        .clk(clock),
        .reset(reset),
        .valor_entrada(fdce_input),
        .retain(ret_op2_lsb),
        .valor_salida(d_op2_lsb)
        );
    FDCE7 #(8) FDCE_OP2_MSB(
        .clk(clock),
        .reset(reset),
        .valor_entrada(fdce_input),
        .retain(ret_op2_msb),
        .valor_salida(d_op2_msb)
        );
        
    FDCE7 #(2) FDCE_CMD(      
        .clk(clock),
        .reset(reset),
        .valor_entrada(fdce_input[1:0]),
        .retain(ret_cmd),
        .valor_salida(d_cmd)
        );
        
    //when clock ticks, update the state
    always_ff @(posedge clock) 
    begin
    	if(reset)
    		state <= Wait_OP1_LSB;
    	else
    		state <= next_state;
	end
endmodule
