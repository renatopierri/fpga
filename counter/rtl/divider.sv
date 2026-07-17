module divider (
    input  logic clk_50mhz,
    output logic enable_clock_001_Hz,
    output logic enable_clock_100_Hz
);

    /*
     * Este modulo nao cria novos clocks.
     * Ele gera pulsos de clock enable, sincronizados com clk_50mhz.
     */
	  
    /*
     * Contador de 19 bits:
     *
     * 50.000.000 Hz / 500.000 = 100 Hz
     *
     * Conta de 0 até 499.999.
     */
    logic [18:0] contador_100Hz = 19'd0;

    /*
     * Contador de 7 bits:
     *
     * 100 Hz / 100 = 1 Hz
     *
     * Conta de 0 até 99.
     */
    logic [6:0] contador_001Hz = 7'd0;


    /*
     * Atualização dos contadores.
     */
    always_ff @(posedge clk_50mhz) begin

        if (contador_100Hz == 19'd499_999) begin
            contador_100Hz <= 19'd0;

            if (contador_001Hz == 7'd99) begin
                contador_001Hz <= 7'd0;
            end else begin
                contador_001Hz <= contador_001Hz + 7'd1;
            end

        end else begin
            contador_100Hz <= contador_100Hz + 19'd1;
        end

    end


    /*
     * Pulso de 100 Hz.
     *
     * A condição permanece verdadeira enquanto
     * contador_100Hz estiver em 499.999.
     *
     * Como o contador só muda na próxima borda de subida,
     * o pulso possui duração de um ciclo completo:
     *
     * 20 ns.
     */
    assign enable_clock_100_Hz =
        (contador_100Hz == 19'd499_999);


    /*
     * Pulso de 1 Hz.
     *
     * Ocorre quando os dois contadores estão no
     * último estado.
     *
     * A largura também é de 20 ns.
     */
    assign enable_clock_001_Hz =
        (contador_100Hz == 19'd499_999) &&
        (contador_001Hz  == 7'd99);

endmodule