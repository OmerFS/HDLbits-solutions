module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
); 
    wire [3:0] Q0, Q1, Q2;
	
    bcdcount counter0 (clk, reset, c_enable[0],Q0);    
    bcdcount counter1 (clk, reset, c_enable[1],Q1);
    bcdcount counter2 (clk, reset, c_enable[2],Q2);
	
    assign c_enable[0] = 1'b1; // The fastest counter always enabled
	assign c_enable[1] = (Q0 == 4'd9); // Middle counter enabled when Q0 reaches 9
    assign c_enable[2] = (Q0 == 4'd9) && (Q1 == 4'd9); // Slowest counter enabled when Q0 and Q1 both reach 9

    assign  OneHertz = ((Q0 == 4'd9) && (Q1 == 4'd9) && (Q2 == 4'd9)) ; // Assert OneHertz for one clock cycle


endmodule
