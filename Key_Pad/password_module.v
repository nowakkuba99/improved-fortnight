//Jakub Nowak 2021 - Password state machine
//To start press KEY0 - LED will light up
//When good 3 digit combination has been pressed 2 LED's light up
//When bad combination was given 1 led flashes for 5 seconds
// CODE : 259 
//i_name - input signal, o_name - output signal, r_name - register
module password_machine (
    input i_clk,
    input i_clk_1Hz,
    input i_key,
    input [3:0] i_digit,
    output [3:0] o_disp,
    output [1:0] o_led 
);
//Current State
reg [2:0] r_State = WAIT;
//Out value
reg [1:0] r_out;
reg [3:0] r_digit_to_display;
reg [1:0] r_led_state;
//Avaiable States
localparam WAIT     = 3'b000;
localparam ONE      = 3'b001;
localparam TWO      = 3'b010;
localparam THREE    = 3'b011;
localparam GOOD     = 3'b100;
localparam BAD      = 3'b101;
localparam DIGIT1   = 4'b0010;
localparam DIGIT2   = 4'b0101;
localparam DIGIT3   = 4'b1001;

//State Machine in always
always @(posedge i_clk) 
begin
    case (r_State)
        WAIT:  r_out <=   2'b0;
        ONE:  r_out <=   2'b0;
        TWO:  r_out <=   2'b0;
        THREE:  r_out <= 2'b0;
        BAD:  r_out <=  2'b10;
        GOOD:  r_out <=  2'b01;
    endcase
        case (r_State)
        WAIT:
        begin
             if(i_key == 1'b0)
             begin
                r_State <= ONE;
             end
        end
        ONE:
        begin
            
        end 
        TWO:
        begin
           
        end 
        THREE:
        begin
        
        end 
        GOOD:
        begin
            
        end 
        BAD:
        begin
           
        end 
        endcase

end
    
endmodule