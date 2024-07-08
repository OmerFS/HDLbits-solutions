module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out
); 
    reg [31:0] q;
    always @(posedge clk) begin
    	q <= in;
        if(!reset)begin
            out <= {q & ~in} | out;    
        end
        else begin
            out <= 32'h00000000;
        end
    end

endmodule
