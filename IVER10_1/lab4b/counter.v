module counter (
	input clk, aclr_n,			
	output reg [1:0] count_out	
);
	// Cria um processo sequencial sensível ao clock, com clear assíncrono.
	// Utilizando a instrução "if-else" para testar primeiro a atuação do sinal de controle assíncrono.
	// A contagem na borda ascendente do clock não irá acontecer, caso o clear esteja ativo.
	always@(posedge clk, negedge aclr_n) begin
		if (aclr_n == 1'b0)
			count_out <= 2'b0;
		else  
			count_out <= count_out + 1'b1;
    end 
endmodule 