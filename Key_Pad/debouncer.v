module Debounce_Switch (
    input i_clk,
    input i_switch,
    output o_switch
);
    parameter c_Debounce_limit = 500000 ; // 10 ms at 50 MHz

    reg [17:0] r_Count = 0 ;
    reg        r_prev_state = 1'b0;

    always @(posedge i_clk) 
    begin
    if(i_switch !== r_prev_state && r_Count < c_Debounce_limit)    
    begin
        r_Count <= r_Count +1;
    end
    else if (r_Count == c_Debounce_limit) 
    begin
        r_Count <= 0;
        r_prev_state <= i_switch;    
    end
    else 
        r_Count <=0;
    end

    assign o_switch = r_prev_state;
endmodule