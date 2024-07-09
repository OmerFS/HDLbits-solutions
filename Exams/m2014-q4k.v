module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
    wire q1,q2,q3;

    fret a1(clk,resetn,in,q1);
    fret a2(clk,resetn,q1,q2);
    fret a3(clk,resetn,q2,q3);
    fret a4(clk,resetn,q3,out);
    

endmodule
module fret(input clk,input resetn, input d,output reg q);
    always @(posedge clk) begin
        if(~resetn)
           q  <= 0;
         else 
        	q <= d;
    end
endmodule
