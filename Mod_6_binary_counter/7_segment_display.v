module Seven_segment_display_3bits (
    input [2:0] i_3bit_bin_num,
    output [6:0] o_signal
);
reg [6:0] r_out;

assign o_signal = ~r_out;

always @(i_3bit_bin_num)
begin
    case (i_3bit_bin_num)
        3'h0: r_out <= 7'b0111111;
        3'h1: r_out <= 7'b0000110;
        3'h2: r_out <= 7'b1011011;
        3'h3: r_out <= 7'b1001111;
        3'h4: r_out <= 7'b1100110;
        3'h5: r_out <= 7'b1101101;
        3'h6: r_out <= 7'b1111101;
        default: r_out <= 7'b0;
    endcase
    
end
endmodule