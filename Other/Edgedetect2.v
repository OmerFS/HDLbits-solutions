 module top_module (
      input clk,
      input [7:0] in,
     output reg [7:0] anyedge
 );
     
     reg[7:0] q;
     always@(posedge clk) begin
       q <= in;
         anyedge <= {~q & in} | {q & ~in} ;
     end
    
 endmodule
