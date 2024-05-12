module tstnato(
  input clk_50mhz,rst_50mhz,  //gerador de clock 0,5hz - 1 segundo alto, 1 segundo baixo

 aclr_n,      
  output reg [1:0] count_out  
);
// Gerador de clock para testes
reg [25:0] count_reg = 0;
reg out_1hz = 0;
reg clk;
always @(posedge clk_50mhz or negedge rst_50mhz) begin
    if (rst_50mhz == 0) begin
        count_reg <= 0;
        out_1hz <= 0;
    end else begin
        if (count_reg < 50000000) begin
            count_reg <= count_reg + 1;
        end else begin
            count_reg <= 0;
            out_1hz <= ~out_1hz;
				clk <= out_1hz; // Aqui o clock é injetado no somador
        end
    end
end
	//Fim do gerador de clock
	
	// Somador de 2 bits
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


























