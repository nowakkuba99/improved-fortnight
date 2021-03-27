//Licznik Mod100
//IN CLK SIA SIB SW
//OUT UNITY TENS
module Counter(SIA,SIB,SW,UNITY,TENS);
input SIA;
input SIB;
input SW;
output [3:0]UNITY;
output [3:0]TENS;
reg [3:0]UNITY;
reg [3:0]TENS;

always@(posedge SIA, posedge SW)
begin
	if(SW)
	begin
		UNITY <= 4'd0;
		TENS <= 4'd0;
	end
	else
	begin
		if(SIB == 0)	//ruch w prawo
			if(UNITY<9)
				UNITY <= UNITY +4'd1;//Dodaj 1 do jednosci
			else
			begin
				if(TENS<9)
					TENS <= TENS +4'd1;//Dodaj 1 do dziesiatek
				else
					TENS = 4'd0;		//Wyzeruj dziesiaki
				UNITY = 4'd0;			//Wyzeruj jednosci
			end
		else				//ruch w lewo
			if(UNITY>0)
				UNITY <= UNITY - 4'd1;
			else
			begin
				if(TENS>0)
					TENS <= TENS - 4'd1;
				else
					TENS = 4'd9;
				UNITY = 4'd9;
			end
	end
	
end

endmodule 