module top_module (
    input clk,
    input areset,
    input x,
    output reg z
); 
    reg [1:0] state,next_state;
    parameter A=0,B=1,C=2;
    

    always@(*)begin
        case(state)
            A:next_state <= x ? B:A;
            B:next_state <= x ? C:B;
            C:next_state <= x ? C:B;
        endcase
    end

   always@(posedge clk or posedge areset)begin
        if(areset)
            state <= A;
        else
            state <= next_state;
    end
    

    always @(*) begin
        case (state)
            A: z = 1'b0;     // Pass through the input if in initial state
            B: z = 1'b1;     // Invert the first 1 encountered
            C: z = 1'b0;     // Pass through the remaining bits
            default: z = 1'b0;
        endcase
    end

endmodule
