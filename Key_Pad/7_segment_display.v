//Jakub Nowak 2021 - 7 segment display driver
//Accepts numbers from 0 to 9
module Seven_segment_display_4bits (
    input [3:0] i_3bit_bin_num,
    output [6:0] o_signal
);
reg [6:0] r_out;

assign o_signal = ~r_out;

always @(i_4bit_bin_num)
begin
    case (i_4bit_bin_num)
        4'h0: r_out <= 7'b0111111;
        4'h1: r_out <= 7'b0000110;
        4'h2: r_out <= 7'b1011011;
        4'h3: r_out <= 7'b1001111;
        4'h4: r_out <= 7'b1100110;
        4'h5: r_out <= 7'b1101101;
        4'h6: r_out <= 7'b1111101;
        4'h7: r_out <= 7'b0000111;
        4'h8: r_out <= 7'b1111111;
        4'h9: r_out <= 7'b1101111;
        default: r_out <= 7'b0;
    endcase
    
end
endmodule