//Jakub Nowak 2021 - Star Hiding State Machine
//Press - hide the star, Pull - show the star
module Star_State_Machine (
    input i_clk,
    input i_press,
    input i_pull,
    input [1:0] i_grill_pos,
    input [1:0] i_star_pos,
    output [3:0] o_output,
);
//Current State
reg [3:0] r_State;
//Out value
reg [3:0] r_out;

//Avaiable States
localparam S1 = 4'b0001;        //Inicjalizacja
localparam S2 = 4'b0010;        //Stan początkowy, Gwiazda do góry
localparam S3 = 4'b0011;        //Otwieranie Grilla, Gwiazda do góry
localparam S4 = 4'b0100;        //Zamykanie Grilla, Gwiazda do góry
localparam S5 = 4'b0101;        //Ruch Grilla (STOP), Gwiazda do góry
localparam S6 = 4'b0110;        //Grill Otwarty, Gwiazda do góry
localparam S7 = 4'b0111;        //Grill Otwarty, Chowanie gwiazdy
localparam S8 = 4'b1000;        //Grill Otwarty, Wyjazd gwiazdy
localparam S9 = 4'b1001;        //Grill Otwarty, Ruch Gwiazdy (STOP)
localparam S10 = 4'b1010;       //Grill Otwarty, Gwiazda schowana
localparam S11 = 4'b1011;       //Zamykanie Grilla, Gwiazda schowana
localparam S12 = 4'b1100;       //Otwieranie Grilla, Gwiazda schowana
localparam S13 = 4'b1101;       //Ruch Grilla (STOP), Gwiazda schowana
localparam S14 = 4'b1110;       //Stan końcowy, Gwiazda schowana
//Output assignment
assign o_output = r_out;
//State Machine in always
always @(posedge i_clk) 
begin
    case (r_State)
        S1: r_out<= 4'b0;
        S2: r_out<= 4'b0;
        S3: r_out<= 4'b1000;
        S4: r_out<= 4'b0100;
        S5: r_out<= 4'b0;
        S6: r_out<= 4'b0;
        S7: r_out<= 4'b0010;
        S8: r_out<= 4'b0001;
        S9: r_out<= 4'b0;
        S10: r_out<= 4'b0;
        S11: r_out<= 4'b0100;
        S12: r_out<= 4'b1000;
        S13: r_out<= 4'b0;
        S14: r_out<= 4'b0;
    endcase
    case (r_State)
    S1:
    begin
        if(i_grill_pos == 2'b0 && i_star_pos == 2'b0)
        begin
            r_State <= S2;                              //Przejscie nr 1
        end
        else
        if(i_grill_pos == 2'b10 && i_star_pos == 2'b0)
        begin
            r_State <= S5;                              //Przejscie nr 2
        end
        else
        if(i_grill_pos == 2'b01 && i_star_pos == 2'b0)
        begin
            r_State <= S6;                              //Przejscie nr 3
        end
        else
        if(i_grill_pos == 2'b01 && i_star_pos == 2'b10)
        begin
            r_State <= S9;                              //Przejscie nr 4
        end
        else
        if(i_grill_pos == 2'b01 && i_star_pos == 2'b01)
        begin
            r_State <= S10;                             //Przejscie nr 5
        end
        else
        if(i_grill_pos == 2'b10 && i_star_pos == 2'b01)
        begin
            r_State <= S13;                             //Przejscie nr 6
        end
        else
        if(i_grill_pos == 2'b0 && i_star_pos == 2'b01)
        begin
            r_State <= S14;                             //Przejscie nr 7
        end
    end
    S2:
    begin
        if(i_pull == 1'b1 && i_press == 1'b0 && i_grill_pos == 2'b0 && i_star_pos == 2'b0)
        begin
            r_State <= S3;                              //Przejscie nr 9
        end
    end
    S3:
    begin
        if(i_pull == 1'b0 && i_grill_pos != 2'b01 && i_star_pos == 2'b0)
        begin
            r_State <= S5;                              //Przejscie nr 11
        end
        else
        if(i_pull == 1'b1 && i_press == 1'b0 && i_grill_pos == 2'b01 && i_star_pos == 2'b0)
        begin
            r_State <= S6;                              //Przejscie nr 12
        end
    end
    S4:
    begin
        if(i_press == 1'b0 && i_grill_pos != 2'b0 && i_star_pos == 2'b0)
        begin
            r_State <= S5;                              //Przejscie nr 14
        end
        else
        if(i_pull == 1'b0 && i_press == 1'b1 && i_grill_pos == 2'b0 && i_star_pos == 2'b0)
        begin
            r_State <= S2;                              //Przejscie nr 15
        end
    end
    S5:
    begin
        if(i_pull == 1'b1 && i_press == 1'b0 && i_star_pos == 2'b0)
        begin
            r_State <= S3;                              //Przejscie nr 17
        end
        else
        if(i_pull == 1'b0 && i_press == 1'b1 && i_star_pos == 2'b0)
        begin
            r_State <= S4;                              //Przejscie nr 18  
        end
    end
    S6:
    begin
        if(i_pull == 1'b0 && i_press == 1'b1 && i_grill_pos == 2'b01 && i_star_pos == 2'b0)
        begin
            r_State <= S4;                              //Przejscie nr 20
        end
        else
        if(i_pull == 1'b1 && i_press == 1'b0 && i_grill_pos == 2'b01 && i_star_pos == 2'b0)
        begin
            r_State <= S7;                              //Przejscie nr 21
        end
    end
    S7:
    begin
        if(i_pull == 1'b0&& i_grill_pos == 2'b01 && i_star_pos != 2'b01)
        begin
            r_State <= S9;                              //Przejscie nr 23
        end
    end  
    endcase
end
endmodule