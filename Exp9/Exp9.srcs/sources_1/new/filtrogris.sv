module filtrogris(
 
input logic [23:0] color_in,
input logic SW,
output logic [23:0] color_out
 
    );
 logic [7:0]  red;  
logic [7:0]  green;
logic [7:0]  blue;    
logic [23:0] colorgris;
 
 
   
always_comb
 begin
    red=color_in[23:16];    
    green=color_in[15:8];  
    blue=color_in[7:0];  
       
    if (SW==1'b1)
      if((red >= green) && (red >= blue))  
            color_out= {red,red,red};
          else  
            if((green >= red) && (green >= blue))  
            color_out= {green,green,green};
            else
              color_out= {blue,blue,blue};
           
 else
      color_out = color_in; 
end

endmodule
