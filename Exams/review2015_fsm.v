module top_module (
    input clk,
    input reset,     
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );
    
    
    parameter S0=0,S1=1,S11=2,S110=3,S1101=4,B=5,C=6,D=7;
    reg[2:0]state,next_state;
    reg[1:0] cnt;
	
    always@(*)
    begin
        case(state)
            S0:next_state=data?S1:S0;
            S1:next_state=data?S11:S0;
            S11:next_state=data?S11:S110;
            S110:next_state=data?B:S0;
            B:next_state = (cnt == 2'd3) ? C : B;
            C:next_state = (done_counting) ? D : C;
            D:next_state = ack ? S0 : D;
            default:next_state=S0;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset) begin
            state <= S0;
            cnt <= 0;
        end else begin
            state <= next_state;
            if (state == B) begin
                if (cnt == 2'd3) begin
                    cnt <= 0;
                end else begin
                    cnt <= cnt + 1;
                end
            end
        end
    end
    

    
    assign shift_ena= (state == B);
    assign counting = (state == C);
    assign done = (state == D);
    
endmodule
