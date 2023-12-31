module mux4(
	input [3:0] mux_in_a, mux_in_b,
	input mux_sel,
	output reg[3:0] mux_out
);

	//Criando processo sensivel a todas entradas
	always@(mux_in_a, mux_in_b, mux_sel) begin
		if (mux_sel == 1'b0)
			mux_out = mux_in_a;
		else
			mux_out = mux_in_b;
		end
endmodule