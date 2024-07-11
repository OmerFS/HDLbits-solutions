module top_module(
    input clk,
    input areset,    
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah );

    // State declaration
    parameter LEFT = 0, RIGHT = 1, FALL = 2;
    reg [1:0] state, next_state;
    reg direction; 

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;  
            direction <= 0;
        end else begin
            case (state)
                LEFT: begin
                    if (!ground) begin
                        state <= FALL;
                        direction <= 0;
                    end else if (bump_left) begin
                        state <= RIGHT;
                        direction <= 1;
                    end
                end
                RIGHT: begin
                    if (!ground) begin
                        state <= FALL;
                        direction <= 1;
                    end else if (bump_right) begin
                        state <= LEFT;
                        direction <= 0;
                    end
                end
                FALL: begin
                    if (ground)
                        state <= direction ? RIGHT : LEFT;
                end
            endcase
        end
    end

    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah = (state == FALL);
    
endmodule
