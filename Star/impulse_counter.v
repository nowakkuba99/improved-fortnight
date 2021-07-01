//Jakub Nowak 2021
//Counting the impulses from the motor to get the position of grill
module impulse_counter (
    input i_sensor,
    input [3:0] i_dir,
    output [1:0] o_pos
);
//48 impulses per inch of movement
parameter p_count_limit = 144;      //3 inches
//Counter register
reg [7:0] r_counter=0;
//out
reg [1:0] r_out=0;
//Output assignment
assign o_pos = r_out; 

always @(posedge i_sensor)
begin
    if(i_dir[0] == 1 && i_dir[1] == 0)          //Ruch do przodu - otwieranie
    begin
        r_counter <= r_counter +1;
    end
    else
    if (i_dir[0] == 0 && i_dir[1] == 1)         //Ruch do tyłu - zamykanie 
    begin  
        r_counter <= r_counter -1;
    end

    if(r_counter == 0)
    begin
        r_out <= 2'b00;
    end
    else
    if(r_counter == p_count_limit)
    begin
        r_out <= 2'b01;
    end
    else
    begin
        r_out <= 2'b10;
    end
end
    
endmodule