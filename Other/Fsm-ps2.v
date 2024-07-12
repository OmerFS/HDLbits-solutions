module top_module(
    input clk,
    input [7:0] in,
    input reset,    
    output done); 
    
    parameter BYTE1 = 0,BYTE2 = 1,BYTE3 = 2,DONE = 3; 
    reg [3:0] count ,state,next;
    

    always @(*)begin
        case(state)
            BYTE1: next <= in[3] ? BYTE2:BYTE1;
            BYTE2: next <= BYTE3;
            BYTE3: next <= DONE;
            DONE:  next <= in[3] ? BYTE2:BYTE1; 
        endcase
    end

    always @(posedge clk) begin
        if(reset)
            state <= BYTE1;
        else
            state <= next;
    end
    
	assign done = (state == DONE);

endmodule
