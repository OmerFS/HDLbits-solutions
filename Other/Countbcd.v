module top_module (
    input clk,
    input reset,  
    output [3:1] ena, 
    output [15:0] q);
    
    assign ena[1] = (q[3:0] == 4'd9);
    assign ena[2] = (q[7:4] == 4'd9 && q[3:0] == 4'd9);
    assign ena[3] = (q[11:8] == 4'd9 && q[7:4] == 4'd9 && q[3:0] == 4'd9 );
    
    bcdcount counter0 (clk, reset, 1'b1,q[3:0]);    
    bcdcount counter1 (clk, reset, ena[1],q[7:4]);
    bcdcount counter2 (clk, reset, ena[2],q[11:8]);
    bcdcount counter3 (clk, reset, ena[3],q[15:12]);

endmodule
module bcdcount (
    input clk,
    input reset,
    input enable,
    output reg [3:0] Q
);

    always @(posedge clk) begin
        if (reset) begin
            Q <= 4'b0000;
        end else if (enable) begin
            Q <= (Q == 4'd9) ? 4'b0000 : Q + 1;
        end
    end

endmodule
