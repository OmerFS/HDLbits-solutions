module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm = 0,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);
    

    wire Q1,Q2,Q3,Q4,Q5;
    reg prev_condition;
    
    
    assign Q1 = (ss[3:0] == 4'h9) & ena ; 
    assign Q2 = (Q1 && ss[7:4] == 4'd5) ; 
    assign Q3 = (Q2 && mm[3:0] == 4'd9);
    assign Q4 = (Q3 && mm[7:4] == 4'd5);
    assign Q5 = (Q4 && hh == 8'h11);
     
    bcdcount9 am      (clk ,reset,ena ,ss[3:0]);
    bcdcount5 am0     (clk ,reset, Q1 ,ss[7:4]);
    bcdcount9 am1     (clk ,reset, Q2 ,mm[3:0]);
    bcdcount5 am2     (clk ,reset, Q3 ,mm[7:4]);
    bcdcount12 am3    (clk ,reset, Q4 ,hh);
    
    always @(posedge clk or posedge reset) begin
    if (reset) begin
        pm <= 1'b0; // Initialize the toggled bit
        prev_condition <= 1'b0; // Initialize the previous condition
    end else begin
        prev_condition <= Q5; // Store the previous value of the condition

        if (Q5 && !prev_condition) begin // Detect rising edge of condition
            pm <= ~pm; // Toggle the bit
        end
    end
end
      

     
endmodule
module bcdcount12 (
    input clk,
    input reset,
    input enable,
    output reg [7:0] Q 
);

always @(posedge clk) begin
    if (reset) begin
        Q <= 8'h12; // Start at 1
    end else if (enable) begin
        if (Q == 8'h12) begin
            Q <= 8'h01; // Wrap around to 1 after 12
        end else begin
            if (Q[3:0] == 4'h9) begin
                Q[3:0] <= 4'h0;
                Q[7:4] <= Q[7:4] + 1;
            end else begin
                Q <= Q + 1;
            end
        end
    end
end

endmodule
module bcdcount9 (
    input clk,
    input reset,
    input enable,
    output reg [3:0] Q
);

always @(posedge clk) begin
    if (reset) begin
        Q <= 4'd0;
    end else if (enable) begin
        Q <= (Q == 4'd9) ? 4'd0: Q + 1;
    end
end
endmodule
module bcdcount5 (
    input clk,
    input reset,
    input enable,
    output reg [3:0] Q
);

always @(posedge clk) begin
    if (reset) begin
        Q <= 4'd0;
    end else if (enable) begin
        Q <= (Q == 4'd5) ? 4'd0: Q + 1;
    end
end
endmodule
