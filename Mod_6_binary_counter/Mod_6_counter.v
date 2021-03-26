module Mod_6_counter (
    input i_clk,
    output [2:0] led
);
//Register holding the current value
reg [2:0] r_count = 3'b0;
//Assigning the counter value to the input
assign led = r_count;

always @(posedge i_clk) 
begin
    if (r_count == 3'b110)
     begin
         r_count <= 3'b0;
    end
    else
        r_count <= r_count + 1;    
end
endmodule