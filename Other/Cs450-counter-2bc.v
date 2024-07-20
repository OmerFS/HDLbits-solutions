module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output [1:0] state
);
    parameter SNT=2'd0 ,WNT=2'd1, WT=2'd2, ST=2'd3;
    reg[1:0] next;
    
    always @(*) begin 
        case(state)
          SNT: next = train_valid ? (train_taken ? WNT:SNT): SNT;
          WNT: next = train_valid ? (train_taken ? WT:SNT): WNT;
          WT:  next = train_valid ? (train_taken ? ST:WNT): WT;
          ST:  next = train_valid ? (train_taken ? ST:WT): ST;
        endcase
    end
            
    always @(posedge clk or posedge areset) begin
         if(areset)
               state <= WNT;
         else
               state <= next;
    end
  
endmodule
