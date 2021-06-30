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
reg [3:0]


    
endmodule