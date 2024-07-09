module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); //
    
    MUXDFF a1(KEY[0],KEY[1],SW[3],KEY[2], KEY[3],LEDR[3],);
    MUXDFF a2(KEY[0],KEY[1],SW[2],KEY[2],LEDR[3],LEDR[2],);
    MUXDFF a3(KEY[0],KEY[1],SW[1],KEY[2],LEDR[2],LEDR[1],);
    MUXDFF a4(KEY[0],KEY[1],SW[0],KEY[2],LEDR[1],LEDR[0],);

endmodule

module MUXDFF (
    input clk,
    input e,
    input r,
    input l,
    input w,
    output reg out,
    output reg outz
	);
    wire x,y;
    assign x = e ? w : out;
    assign y = l ? r : x;
    
    always @(posedge clk) begin
    	out <= y;
    end
    

endmodule
