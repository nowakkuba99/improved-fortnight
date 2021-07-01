//Jakub Nowak 2021
//Stepper Motor Driver - Full Step Bipolar (4 leads: A,B,C,D)
//A B C D
//1 1 0 0   S1
//0 1 1 0   S2
//0 0 1 1   S3
//1 0 0 1   S4
module stepper_driver (
    input i_clk,
    input [3:0] i_control,
    //output o_A,
    //output o_B,
    //output o_C,
    //output o_D,
    output [3:0] o_Motor,
    output [1:0] o_pos,
	//output [7:0] o_debug,
	//output o_debug_en
);
//Testowo okres pomiedzy krokami 1s - zegar 1Hz wchodzi
localparam Ts = 1;
//Ilosc krokow - 200 kroków na obrót - 100 kroków = 180 stopni
parameter  p_count_limit = 100;
//Stany
localparam S1 = 3'b001;
localparam S2 = 3'b010;
localparam S3 = 3'b011;
localparam S4 = 3'b100;
//Aktualny krok
reg [7:0] r_counter =0;
//Aktualny Stan
reg [3:0] r_State = S1;
//Out
reg [3:0] r_out;
reg [1:0] r_pos;
//Kierunek
reg r_dir;
//Enable
reg r_en;
//Output assignment
assign o_Motor = r_out;
assign o_pos = r_pos;
//assign o_debug = r_counter;
//assign o_debug_en = r_en;
//Main hardware loop
always @(posedge i_clk) 
begin

 //Sprawdzenie pozycji
    if(r_counter == 0)
    begin
        r_pos <= 2'b00;
    end
    else
    if(r_counter == p_count_limit)
    begin
        r_pos <= 2'b01;
    end
    else
    begin
        r_pos <= 2'b10;
    end
	 
	 
    //Określenie kierunku
    if(i_control[2] == 1'b1 && i_control[3] == 1'b0 )
    begin
        r_dir <=1'b1;         //Do przodu
		if(r_counter < p_count_limit-1)
		begin
        r_en <= 1'b1;
		end
		else
		begin
		r_en <= 1'b0;
		end
    end
    else
    if (i_control[2] == 1'b0 && i_control[3] == 1'b1) 
    begin
        r_dir <=1'b0;         //Do tyłu
        if(r_counter > 1)
		begin
        r_en <= 1'b1;
		end
		else
		begin
		r_en <= 1'b0;
		end
    end
	else
	begin
	r_en <=0;
	end
   
    //Ustawienie wyjść
    case (r_State)
        S1: r_out <= 4'b1100;
        S2: r_out <= 4'b0110;
        S3: r_out <= 4'b0011;
        S4: r_out <= 4'b1001;
    endcase

    //Głowny case
    case (r_State)
        S1:
        begin
            if(r_dir == 1'b1 && r_en == 1'b1)
            begin
                r_State <=S2;
                r_counter <= r_counter +1;
            end
            else
            if(r_dir == 1'b0 && r_en == 1'b1)
            begin
                r_State <=S4;
                r_counter <= r_counter -1;
            end
        end

        S2:
        begin
            if(r_dir == 1'b1 && r_en == 1'b1)
            begin
                r_State <=S3;
                r_counter <= r_counter +1;
            end
            else
            if(r_dir == 1'b0 && r_en == 1'b1)
            begin
                r_State <=S1;
                r_counter <= r_counter -1;
            end
        end

        S3:
        begin
            if(r_dir == 1'b1 && r_en == 1'b1)
            begin
                r_State <=S4;
                r_counter <= r_counter +1;
            end
            else
            if(r_dir == 1'b0 && r_en == 1'b1)
            begin
                r_State <=S2;
                r_counter <= r_counter -1;
            end
        end

        S4:
        begin
            if(r_dir == 1'b1 && r_en == 1'b1)
            begin
                r_State <=S1;
                r_counter <= r_counter +1;
            end
            else
            if(r_dir == 1'b0 && r_en == 1'b1)
            begin
                r_State =S3;
                r_counter <= r_counter -1;
            end
        end    
     
    endcase
end


    
endmodule