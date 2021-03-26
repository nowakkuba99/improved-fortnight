module mux_4_inputs (
    input i_a,
    input i_b,
    input i_c,
    input i_d,
    input i_control_0,
    input i_control_1,
    output o_signal
);

assign o_signal = i_control_0 ? (i_control_1 ? i_d:i_b) : (i_control_1 ? i_c:i_a);
endmodule