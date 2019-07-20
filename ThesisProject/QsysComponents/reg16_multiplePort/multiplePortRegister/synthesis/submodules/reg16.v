module reg16 (clock, resetn, D, D2, byteenable, byteenable2, Q, Q2);
input clock, resetn;
input[1:0] byteenable, byteenable2;
input[15:0] D, D2;
output reg[15:0] Q, Q2;


always @(posedge clock)
	if(!resetn)begin
		Q <= 16'b0;
		Q2 <= 16'b0;
		end
	else
	begin
	// Enable writing to each byte separately
	if (byteenable[0]) Q[7:0] <= D[7:0];
	if (byteenable[1]) Q[15:8] <= D[15:8];

	if (byteenable2[0]) Q2[7:0] <= D2[7:0];
	if (byteenable2[1]) Q2[15:8] <= D2[15:8];
	
	end
	
endmodule

