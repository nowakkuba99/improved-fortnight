module clk_50MHz_to_1Hz (
    input i_50MHz,
    output o_1Hz
);
reg [25:0] r_counter=0;
reg        r_state = 0;

parameter c_count_limit = 50000000 ; // 50 MHz to 1Hz convertion
always @(posedge i_50MHz)
 begin
    if(r_counter == c_count_limit)
    begin
        r_counter <= 0;
        r_state <= 1'b1;
    end
    else
    begin
        r_counter <= r_counter +1;
        r_state <= 0;
    end
end
    
assign o_1Hz = r_state;

endmodule