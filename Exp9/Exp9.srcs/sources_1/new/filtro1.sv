module filtro1(
input logic [23:0] color_in,
input logic [5:0] SW,
output logic [23:0] color_out
    );
   
logic [7:0]  red;  
logic [7:0]  green;
logic [7:0]  blue;    
   
always_comb    
     
     begin
        case(SW[1:0])
     
            2'b00: red = color_in[7:0]  ;
           
            2'b01: red = color_in[15:8]   ;
           
            2'b10: red = color_in[23:16]  ;
           
            2'b11: red = 8'b0  ;
           
           
           
        endcase
 
        case(SW[3:2])
       
            2'b00: green = color_in[7:0]  ;
                   
            2'b01: green = color_in[15:8]   ;
                               
            2'b10: green = color_in[23:16]  ;
                   
            2'b11: green = 8'b0  ;
       
           
        endcase
       
        case(SW[5:4])
               
           2'b00: blue = color_in[7:0]  ;
                           
           2'b01: blue = color_in[15:8]   ;
                                       
           2'b10: blue = color_in[23:16]  ;
                           
           2'b11: blue = 8'b0  ;
               
        endcase
        color_out = {blue,green,red};
 end      
       
endmodule
