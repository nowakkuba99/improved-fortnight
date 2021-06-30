module out (
    input [3:0] i_in,
    output o_forward,
    output o_backwards
);

assign o_forward = i_in[2];
assign o_backwards = i_in[3];
    
endmodule