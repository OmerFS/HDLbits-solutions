module top_module (
    input clk,
    input reset,      
    input data,
    output reg [3:0] count,
    output counting,
    output done,
    input ack );
    
    parameter S0 =4'd0, S1 = 4'd1, S11 = 4'd2, S110 = 4'd3, 
              B1 = 4'd4, B2 = 4'd5, B3 = 4'd6, B4 = 4'd7, 
              C = 4'd8, D = 4'd9;
              
    reg [3:0] state, next_state;
    reg [9:0] cnt;
    
    always @(*) begin
        case (state)
            S0:    next_state = data ? S1 : S0;
            S1:    next_state = data ? S11 : S0;
            S11:   next_state = data ? S11 : S110;
            S110:  next_state = data ? B1 : S0;
            B1:    next_state = B2;
            B2:    next_state = B3;
            B3:    next_state = B4; 
            B4:    next_state = C;	 
            C:     next_state = (count==0 && cnt==10'd999)? D : C;
            D:     next_state = ack ? S0 : D;
            default: next_state = S0;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset) begin
            state <= S0;
            cnt <= 0;
        end else begin
            state <= next_state;
            if (state == B1 || state == B2 || state == B3 || state == B4)
                count <= {count[2:0],data};
            else if(state==C)begin
                if(cnt == 10'd999)begin
                    cnt <= 0;
                    count <= (0<count) ? count - 4'd1 : count;
                end else begin
                    cnt <= cnt + 10'd1;
                end
            end
        end
    end
    
    assign counting = (state == C);
    assign done = (state == D);

endmodule
