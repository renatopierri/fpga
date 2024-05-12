module junta(
	input entra, clear,
	output [1:0] cout
);

wire liga_saida_clk; 


debounce u1 (.Entrada(entra), .Saida(liga_saida_clk));
tstnato u2 (.clk(liga_saida_clk), .aclr_n (clear), .count_out(cout));

endmodule