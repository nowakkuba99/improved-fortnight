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
    output [3:0] o_Big
);
//Testowo okres pomiedzy krokami 1s - zegar 1Hz wchodzi
localparam Ts = 1;
//Aktualny Stan
localparam S1 = 3'b001;
localparam S2 = 3'b010;
localparam S3 = 3'b011;
localparam S4 = 3'b100;
//Aktualny Stan
reg [3:0] r_State = S1;
//Out
reg [3:0] r_out;
//Kierunek
reg r_dir;
//Enable
reg r_en;
//Output assignment
assign o_Big = r_out;

//Main hardware loop
always @(posedge i_clk) 
begin
    case (r_State)
        S1: r_out <= 4'b1100;
        S2: r_out <= 4'b0110;
        S3: r_out <= 4'b0011;
        S4: r_out <= 4'b1001;
    endcase

    //Określenie kierunku
    if(i_control[0] == 1'b1 && i_control[1] == 1'b0)
    begin
        r_dir <=1'b1;         //Do przodu
        r_en <= 1'b1;
    end
    else
    if (i_control[0] == 1'b0 && i_control[1] == 1'b1) 
    begin
        r_dir <=1'b0;         //Do tyłu
        r_en <= 1'b1;
    end
    else
    begin
        r_en <= 1'b0; 
    end
    case (r_State)
        S1:
        begin
            if(r_dir == 1'b1 && r_en == 1'b1)
            begin
                r_State <=S2;
            end
            else
            if(r_dir == 1'b0 && r_en == 1'b1)
            begin
                r_State <S4;
            end
        end

        S2:
        begin
            if(r_dir == 1'b1 && r_en == 1'b1)
            begin
                r_State <=S3;
            end
            else
            if(r_dir == 1'b0 && r_en == 1'b1)
            begin
                r_State <S1;
            end
        end

        S3:
        begin
            if(r_dir == 1'b1 && r_en == 1'b1)
            begin
                r_State <=S4;
            end
            else
            if(r_dir == 1'b0 && r_en == 1'b1)
            begin
                r_State <S2;
            end
        end

        S4:
        begin
            if(r_dir == 1'b1 && r_en == 1'b1)
            begin
                r_State <=S1;
            end
            else
            if(r_dir == 1'b0 && r_en == 1'b1)
            begin
                r_State <S3;
            end
        end    
     
    endcase
end


    
endmodule