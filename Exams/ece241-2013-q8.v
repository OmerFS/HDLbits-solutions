module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output  z ); 
    parameter A = 0 , B = 1, C =2;
    
    reg [1:0] state , next;

    always@(*) begin
        case(state)
            A:next = x ? B : A;
            B:next = x ? B : C;
            C:next = x ? B : A;
        endcase
    end

    always @(posedge clk , negedge aresetn) begin
        if (!aresetn)
            state <= A;
        else 
            state <= next;
    end
  
    assign z = (state == C && x == 1);

endmodule
