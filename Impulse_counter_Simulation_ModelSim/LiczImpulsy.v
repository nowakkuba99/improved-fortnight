//PROGRAM LICZNIKA 02.12.2020 
module LiczImpulsy(CLK,RST,EN,DIR,BCD);	//Zegar restet wlacznik kierunek 
input CLK;	//Sygnal zegara
input RST;	//Reset
input EN;	//Wlacz liczenie
input DIR;	//Kierunek liczenia
output [3:0]BCD; //Wyjscie - (Od 0 do 9) 4 bity 0 1 2 3  od największego do najmniejszego 
reg [3:0]BCD;	//Register bo sekwencyjny

always @ (posedge CLK)	//Postivie edge (narastajace zbocze (kiedy))
	if (RST == 1)
		BCD = 4'd0;	// Na 4 bitach zapisz dziesietnie 0
	else
		if (EN == 1)
			if(DIR == 1)					//Odejmij
				if(BCD < 9)
					BCD <= BCD + 4'd1	;	//Dodaj 1
				else
					BCD = 4'd0;				// Jesli jest 9 to wyzeruj
			else
				if(BCD > 0)
					BCD <= BCD - 4'd1;
				else
					BCD = 4'd9;
endmodule 