module LED_Switching (
    input [9:0] Switch,
    output [9:0] Led
);
assign Led = Switch;
    
endmodule