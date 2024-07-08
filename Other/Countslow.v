module top_module (
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q);
    
    always @(posedge clk) begin
        if(slowena) begin
        	if (q == 9) 
            	q <= 4'd0;
        	else 
            	q <= q +1'd1 ;
        end
        if  (reset)
            q <= 4'd0;
    end

endmodule
