//Jakub Nowak 2021 - Led Dimmer State Machine
//To turn on press UP or DOWN, to turn off press both 
//Max level is 6 and min is 1
//i_name - input signal, o_name - output signal, r_name - register
module LED_Dimmer_State_Machine (
    input i_clk,
    input i_up,
    input i_down,
    output [5:0] o_level
);

//Current State
reg [2:0] r_State = OFF;
//Out value
reg [5:0] r_out;

//Avaiable States
localparam OFF      = 3'b000;
localparam ONE      = 3'b001;
localparam TWO      = 3'b010;
localparam THREE    = 3'b011;
localparam FOUR     = 3'b100;
localparam FIVE     = 3'b101;
localparam SIX      = 3'b110;
localparam INIT     = TWO;
//Output assignment
assign o_level = r_out;

//State Machine in always
always @(posedge i_clk) 
begin
    case (r_State)
        OFF:  r_out <=   6'b0;
        ONE:  r_out <=   6'b000001;
        TWO:  r_out <=   6'b000011;
        THREE:  r_out <= 6'b000111;
        FOUR:  r_out <=  6'b001111;
        FIVE:  r_out <=  6'b011111;
        SIX:  r_out <=   6'b111111;
    endcase
        case (r_State)
        OFF:
        begin
             if(i_up == 1'b1|| i_down== 1'b1)
                begin
                    r_State <= INIT;
                end
        end
        ONE:
        begin
            if (i_up== 1'b1 && i_down== 1'b0) 
            begin
                r_State <= TWO;    
            end
            else
            if (i_up== 1'b1 && i_down== 1'b1) 
            begin
                r_State <= OFF;    
            end
        end 
        TWO:
        begin
            if (i_up== 1'b1 && i_down== 1'b0) 
            begin
                r_State <= THREE;    
            end
            else
            if (i_up== 1'b0 && i_down== 1'b1) 
            begin
                r_State <= ONE;    
            end
            else
            if (i_up== 1'b1 && i_down== 1'b1) 
            begin
                r_State <= OFF;    
            end
        end 
        THREE:
        begin
            if (i_up== 1'b1 && i_down== 1'b0) 
            begin
                r_State <= FOUR;    
            end
            else
            if (i_up== 1'b0 && i_down== 1'b1) 
            begin
                r_State <= TWO;    
            end
            else
            if (i_up== 1'b1 && i_down== 1'b1) 
            begin
                r_State <= OFF;    
            end
        end 
        FOUR:
        begin
            if (i_up== 1'b1 && i_down== 1'b0) 
            begin
                r_State <= FIVE;    
            end
            else
            if (i_up== 1'b0 && i_down== 1'b1) 
            begin
                r_State <= THREE;    
            end
            else
            if (i_up== 1'b1 && i_down== 1'b1) 
            begin
                r_State <= OFF;    
            end
        end 
        FIVE:
        begin
            if (i_up== 1'b1 && i_down== 1'b0) 
            begin
                r_State <= SIX;    
            end
            else
            if (i_up== 1'b0 && i_down== 1'b1) 
            begin
                r_State <= FOUR;    
            end
            else
            if (i_up== 1'b1 && i_down== 1'b1) 
            begin
                r_State <= OFF;    
            end
        end 
        SIX:
        begin
            if (i_up== 1'b0 && i_down== 1'b1) 
            begin
                r_State <= FIVE;    
            end
            else
            if (i_up== 1'b1 && i_down== 1'b1) 
            begin
                r_State <= OFF;    
            end
        end 
        endcase

end
    
endmodule