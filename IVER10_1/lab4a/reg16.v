module reg16 (
	input [15:0] datain,		
	input clk, sclr_n, clk_ena,	
	output reg [15:0] reg_out	
);

	// Criando o processo sequencial, sensível ao clock e utilizando 
	// declarações if-else aninhadas para habilitar o clock síncrono e 
	// controle de clear.
	always@(posedge clk) begin
		if (clk_ena)
			if(!sclr_n)
				reg_out <= 16'b0 ;
			else
				reg_out <= datain;
	end 
endmodule