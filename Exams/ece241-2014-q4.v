module top_module (
    input clk,
    input x,
    output z
); 
    reg [2:0] a = 3'b000;
    
    always @(posedge clk) begin 
        
        a[0]  <= x ^ a[0];
        a[1]  <= x & ~a[1];
        a[2]  <= x | ~a[2];
    	
    end
    assign z = ~|(a);
endmodule
