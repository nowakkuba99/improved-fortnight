module LED_Switching (
    input Switch[9:0],
    output Led[9:0]
);
assign Led[9:0] = Switch[9:0];
    
endmodule