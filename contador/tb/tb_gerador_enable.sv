`timescale 1ns/1ps

module tb_gerador_enable;

    /*
     * Clock de 50 MHz:
     *
     * Período total = 20 ns
     * 10 ns em nível baixo
     * 10 ns em nível alto
     */
    localparam time PERIODO_CLOCK = 20ns;

    /*
     * Valores reduzidos usados somente na simulação.
     *
     * A lógica do módulo será a mesma da versão real, mas:
     *
     * enable_1hz   deverá ocorrer a cada 10 ciclos;
     * enable_100hz deverá ocorrer a cada 4 ciclos.
     */
    localparam int unsigned TB_CICLOS_1HZ   = 10;
    localparam int unsigned TB_CICLOS_100HZ = 4;

    /*
     * Sinais de estímulo enviados ao DUT.
     */
    logic clk;
    logic reset;

    /*
     * Sinais observados na saída do DUT.
     */
    logic enable_1hz;
    logic enable_100hz;

    /*
     * Instância do módulo que será testado.
     *
     * DUT = Device Under Test.
     *
     * Os valores padrão do gerador_enable são substituídos
     * pelos valores reduzidos definidos neste testbench.
     */
    gerador_enable #(
        .CICLOS_1HZ   (TB_CICLOS_1HZ),
        .CICLOS_100HZ (TB_CICLOS_100HZ)
    ) dut (
        .clk          (clk),
        .reset        (reset),
        .enable_1hz   (enable_1hz),
        .enable_100hz (enable_100hz)
    );

    /*
     * Geração contínua do clock de 50 MHz.
     */
    initial begin
        clk = 1'b0;

        forever begin
            #(PERIODO_CLOCK / 2);
            clk = ~clk;
        end
    end

    /*
     * Sequência inicial de reset.
     *
     * O reset permanece ativo durante três bordas de subida.
     * A desativação ocorre na borda de descida seguinte para
     * evitar disputa temporal com a lógica síncrona do DUT.
     */
    initial begin
        reset = 1'b1;

        repeat (3)
            @(posedge clk);

        @(negedge clk);
        reset = 1'b0;
    end

    /*
     * Controle provisório da simulação.
     *
     * Ainda não há testes automáticos neste arquivo.
     * O primeiro teste TDD será acrescentado na próxima etapa.
     */
    initial begin
        repeat (50)
            @(posedge clk);

        $display("Fim temporario da simulacao.");
        $finish;
    end

endmodule
