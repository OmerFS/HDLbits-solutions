module top_module(
    input clk,
    input in,
    input reset,  
    output [7:0] out_byte,
    output done
); 
    parameter IDLE = 4'd0, START = 4'd1, B0 = 4'd2, B1 = 4'd3, B2 = 4'd4, B3 = 4'd5, B4 = 4'd6, B5 = 4'd7, B6 = 4'd8, B7 = 4'd9, PARITY = 4'd10, STOP = 4'd11, WAIT = 4'd12;
    reg [7:0] out_byte_reg;
    reg [3:0] current_state,next_state;
    wire odd;
    

    // Next state logic
    always @(*) begin
        case(current_state)
            IDLE:
                next_state = in ? IDLE : START;
            START:
                next_state = B0;
            B0:
                next_state = B1;
            B1:
                next_state = B2;
            B2:
                next_state = B3;
            B3:
                next_state = B4;
            B4:
                next_state = B5;
            B5:
                next_state = B6;
            B6:
                next_state = B7;
            B7:
                next_state = PARITY;
            PARITY:
                next_state = in ? STOP : WAIT;
            WAIT:
                next_state = in ? IDLE : WAIT;
            STOP:
                next_state = in ? IDLE : START;
            default:
                next_state = IDLE;
        endcase
    end
	
    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Output data
    always @(posedge clk) begin
        if (reset || next_state == IDLE || next_state == START) begin
            out_byte_reg <= 8'd0;
        end else if (next_state >= B0 && next_state <= B7) begin
            out_byte_reg[next_state - B0] <= in; // Capture each bit in the respective state
        end
    end

    parity u_parity (
        .clk(clk),
        .reset(reset || next_state == IDLE || next_state == START),
        .in(in),
        .odd(odd)
    );

    assign done = (current_state == STOP) && ~odd;
    assign out_byte = done ? out_byte_reg : 8'b0;

endmodule
