module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);
    parameter IDLE = 1'd0 ,COUNTER  =1'd1;
    reg state , next;
    reg [9:0] counter;
    
    always @(*) begin
        case(state)
            IDLE:next = load ? COUNTER : IDLE;
            COUNTER:next = COUNTER;
            default:next = IDLE;
        endcase
    end
    
    always @(posedge clk) begin 
        state <= next;
        if(load)
            counter <= data;
        else begin
            if(state==COUNTER)
            	counter <= (counter==0)? 10'd0 :counter - 10'd1;
        end
            
    end
    
    assign tc = (counter==0 &&  state == COUNTER);
    
endmodule
