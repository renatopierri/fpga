module debounce(
	Entrada,
	Saida
);

input wire	Entrada;
output wire	Saida;

wire	U1_b;
wire	U1_e;
wire	U1_d;

assign	Saida = U1_d;
assign	U1_d = ~(U1_b & Entrada);
assign	U1_b = ~(U1_e & U1_d);
assign	U1_e =  ~Entrada;
endmodule
