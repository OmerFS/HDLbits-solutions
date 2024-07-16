module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);
    parameter S0  = 0,S1  = 1 , S2  = 2  , S3  = 3 , S4  = 4 ,S5 = 5 , S6 = 6 ,DISC = 7 ,FLAG = 8 ,ERROR = 9;
    reg[3:0] state ,next;
    
    always @(*) begin
        case(state)
          S0:begin next <= in ? S1 : S0; end
        	S1:begin next <= in ? S2 : S0;  end
        	S2:begin next <= in ? S3 : S0;  end
        	S3:begin next <= in ? S4 : S0;  end
       		S4:begin next <= in ? S5 : S0; end
        	S5:begin next <= in ? S6 : DISC;  end
          S6:begin next <= in ? ERROR : FLAG;  end
        	DISC:begin next <= in ? S1:S0;  end
        	FLAG:begin next <= in ? S1:S0;  end
        	ERROR:begin next <= in ? ERROR : S0;  end
        	default: next <= S0;
        endcase
    end
    
    always @(posedge clk)begin
        if(reset)
            state <= S0;
        else
            state <= next;
    end
    
    assign disc = ( state== DISC );
    assign flag = ( state== FLAG );
    assign err =  ( state== ERROR );

endmodule
