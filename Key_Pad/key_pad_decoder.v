//Jakub Nowak 2021 - 4x3 Key Pad decoder
//On press the number is saved in binary format and passed along
//Available numbers: 1,2,3,4,5,6,7,8,9,0,* = 10,# = 11
//i_name - input signal, o_name - output signal, r_name - register
module key_pad (
    input i_clk,
    output [2:0] o_col,
    input [3:0] i_row,
    output [3:0] o_digit
);
//Out value
reg [3:0] r_out;
reg [3:0] r_col;
// Count register
reg [17:0] r_count;
//Output assignment
assign o_digit = r_out;
assign o_col = r_col;
//State machine
always @(posedge i_clk)
begin
   // 1ms - 50 000
			if (r_count == 18'b1100001101010000) begin
				//Column 1
				r_col <= 3'b011;
				r_count <= r_count + 1'b1;
			end
			
			// Check Rows 10 cycles later - 50 010
			else if(r_count == 18'b1100001101011010) begin
				//R1
				if (i_row == 4'b0111) begin
					r_out <= 4'b0001;		//1
				end
				//R2
				else if(i_row == 4'b1011) begin
					r_out <= 4'b0100; 		//4
				end
				//R3
				else if(i_row == 4'b1101) begin
					r_out <= 4'b0111; 		//7
				end
				//R4
				else if(i_row == 4'b1110) begin
					r_out <= 4'b1010; 		//* - 10
				end
				r_count <= r_count + 1'b1;
			end

			// 2ms - 100 000
			else if(r_count == 18'b11000011010100000) begin
				//C2
				r_col<= 3'b101;
				r_count <= r_count + 1'b1;
			end
			
			// Check Rows 10 cycles later - 100 010
			else if(r_count == 18'b11000011010101010) begin
				//R1
				if (i_row == 4'b0111) begin
					r_out <= 4'b0010; 		//2
				end
				//R2
				else if(i_row == 4'b1011) begin
					r_out <= 4'b0101; 		//5
				end
				//R3
				else if(i_row == 4'b1101) begin
					r_out <= 4'b1000; 		//8
				end
				//R4
				else if(i_row == 4'b1110) begin
					r_out <= 4'b0000; 		//0
				end
				r_count <= r_count + 1'b1;
			end

			// 3ms - 150 000
			else if(r_count == 18'b100100100111110000) begin
				//C3
				r_col<= 3'b110;
				r_count <= r_count + 1'b1;
			end
			
			// Check Rows 10 cycles later - 150 010
			else if(r_count == 18'b100100100111111010) begin
				//R1
				if(i_row == 4'b0111) begin
					r_out <= 4'b0011; 		//3	
				end
				//R2
				else if(i_row == 4'b1011) begin
					r_out <= 4'b0110; 		//6
				end
				//R3
				else if(i_row == 4'b1101) begin
					r_out <= 4'b1001; 		//9
				end
				//R4
				else if(i_row == 4'b1110) begin
					r_out <= 4'b1011; 		//#
				end

				r_count <= 18'b000000000000000000;
			end
			// Add 1 to count
			else begin
				r_count <= r_count + 1'b1;
			end
end 
endmodule