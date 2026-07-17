`timescale 1ns/1ps

module tb_bcd_counter;

    /*
     * O mesmo sinal é conectado ao clock principal
     * e ao clock enable para simplificar a simulação.
     */
    logic clk_50mhz = 1'b0;

    logic bit_0;
    logic bit_1;
    logic bit_2;
    logic bit_3;
    logic bit_4;
    logic bit_5;
    logic bit_6;
    logic bit_7;
    logic bit_8;
    logic bit_9;
    logic bit_10;
    logic bit_11;
    logic bit_12;
    logic bit_13;
    logic bit_14;
    logic bit_15;
    logic bit_16;
    logic bit_17;
    logic bit_18;
    logic bit_19;
    logic bit_20;
    logic bit_21;
    logic bit_22;
    logic bit_23;

    /*
     * Agrupa as 24 saídas individuais para facilitar
     * a comparação dos seis algarismos BCD.
     */
    logic [23:0] contador_bcd;

    assign contador_bcd = {
        bit_23, bit_22, bit_21, bit_20,
        bit_19, bit_18, bit_17, bit_16,
        bit_15, bit_14, bit_13, bit_12,
        bit_11, bit_10, bit_9,  bit_8,
        bit_7,  bit_6,  bit_5,  bit_4,
        bit_3,  bit_2,  bit_1,  bit_0
    };

    /*
     * Instância do contador.
     *
     * Para simplificar o teste, o mesmo clock é conectado
     * às entradas clk_50mhz e enable_clock_001_Hz.
     */
    bcd_counter dut (
        .enable_clock_001_Hz (clk_50mhz),
        .clk_50mhz           (clk_50mhz),

        .bit_0  (bit_0),
        .bit_1  (bit_1),
        .bit_2  (bit_2),
        .bit_3  (bit_3),
        .bit_4  (bit_4),
        .bit_5  (bit_5),
        .bit_6  (bit_6),
        .bit_7  (bit_7),
        .bit_8  (bit_8),
        .bit_9  (bit_9),
        .bit_10 (bit_10),
        .bit_11 (bit_11),
        .bit_12 (bit_12),
        .bit_13 (bit_13),
        .bit_14 (bit_14),
        .bit_15 (bit_15),
        .bit_16 (bit_16),
        .bit_17 (bit_17),
        .bit_18 (bit_18),
        .bit_19 (bit_19),
        .bit_20 (bit_20),
        .bit_21 (bit_21),
        .bit_22 (bit_22),
        .bit_23 (bit_23)
    );

    /*
     * Clock de 50 MHz:
     *
     * período = 20 ns
     * nível baixo = 10 ns
     * nível alto  = 10 ns
     */
    always #10 clk_50mhz = ~clk_50mhz;

    /*
     * Converte um número decimal entre 0 e 999999
     * para seis algarismos BCD.
     */
    function automatic logic [23:0] decimal_para_bcd(
        input int unsigned valor
    );

        logic [3:0] unidades;
        logic [3:0] dezenas;
        logic [3:0] centenas;
        logic [3:0] milhares;
        logic [3:0] dez_milhar;
        logic [3:0] cent_milhar;

        begin
            unidades   = valor % 10;
            dezenas    = (valor / 10) % 10;
            centenas   = (valor / 100) % 10;
            milhares   = (valor / 1_000) % 10;
            dez_milhar = (valor / 10_000) % 10;
            cent_milhar = (valor / 100_000) % 10;

            decimal_para_bcd = {
                cent_milhar,
                dez_milhar,
                milhares,
                centenas,
                dezenas,
                unidades
            };
        end

    endfunction

    int unsigned numero_pulso;
    int unsigned valor_decimal_esperado;
    logic [23:0] valor_bcd_esperado;

    initial begin

        /*
         * Confere o estado inicial.
         */
        #1;

        assert (contador_bcd === 24'h000000)
        else begin
            $fatal(
                1,
                "ERRO INICIAL: esperado 000000, obtido %06h",
                contador_bcd
            );
        end

        $display("Estado inicial correto: 000000");

        /*
         * Produz e verifica 1.100.000 pulsos.
         */
        for (
            numero_pulso = 1;
            numero_pulso <= 1_100_000;
            numero_pulso++
        ) begin

            /*
             * Aguarda uma borda de subida do clock.
             */
            @(posedge clk_50mhz);

            /*
             * Espera 1 ns para que as atribuições não
             * bloqueantes do DUT sejam efetivadas.
             */
            #1;

            /*
             * Depois de 999999, o valor esperado volta
             * para zero.
             */
            valor_decimal_esperado = numero_pulso % 1_000_000;
            valor_bcd_esperado =
                decimal_para_bcd(valor_decimal_esperado);

            /*
             * Asserção geral:
             *
             * verifica todas as 1.100.000 contagens.
             */
            assert (contador_bcd === valor_bcd_esperado)
            else begin
                $fatal(
                    1,
                    {
                        "ERRO NO PULSO %0d: ",
                        "esperado BCD %06h, obtido %06h"
                    },
                    numero_pulso,
                    valor_bcd_esperado,
                    contador_bcd
                );
            end

            /*
             * Asserção do vai um das unidades:
             *
             * 000009 -> 000010
             */
            if (numero_pulso == 10) begin
                assert (contador_bcd === 24'h000010)
                else begin
                    $fatal(
                        1,
                        "ERRO no vai um das unidades: obtido %06h",
                        contador_bcd
                    );
                end

                $display(
                    "Vai um das unidades correto: 000009 -> 000010"
                );
            end

            /*
             * Asserção do vai um das dezenas:
             *
             * 000099 -> 000100
             */
            if (numero_pulso == 100) begin
                assert (contador_bcd === 24'h000100)
                else begin
                    $fatal(
                        1,
                        "ERRO no vai um das dezenas: obtido %06h",
                        contador_bcd
                    );
                end

                $display(
                    "Vai um das dezenas correto: 000099 -> 000100"
                );
            end

            /*
             * Asserção do vai um das centenas:
             *
             * 000999 -> 001000
             */
            if (numero_pulso == 1_000) begin
                assert (contador_bcd === 24'h001000)
                else begin
                    $fatal(
                        1,
                        "ERRO no vai um das centenas: obtido %06h",
                        contador_bcd
                    );
                end

                $display(
                    "Vai um das centenas correto: 000999 -> 001000"
                );
            end

            /*
             * Asserção do vai um dos milhares:
             *
             * 009999 -> 010000
             */
            if (numero_pulso == 10_000) begin
                assert (contador_bcd === 24'h010000)
                else begin
                    $fatal(
                        1,
                        "ERRO no vai um dos milhares: obtido %06h",
                        contador_bcd
                    );
                end

                $display(
                    "Vai um dos milhares correto: 009999 -> 010000"
                );
            end

            /*
             * Asserção do vai um das dezenas de milhares:
             *
             * 099999 -> 100000
             */
            if (numero_pulso == 100_000) begin
                assert (contador_bcd === 24'h100000)
                else begin
                    $fatal(
                        1,
                        {
                            "ERRO no vai um das dezenas ",
                            "de milhares: obtido %06h"
                        },
                        contador_bcd
                    );
                end

                $display(
                    {
                        "Vai um das dezenas de milhares correto: ",
                        "099999 -> 100000"
                    }
                );
            end

            /*
             * Antes da virada final, confirma 999999.
             */
            if (numero_pulso == 999_999) begin
                assert (contador_bcd === 24'h999999)
                else begin
                    $fatal(
                        1,
                        "ERRO: esperado 999999, obtido %06h",
                        contador_bcd
                    );
                end

                $display("Valor 999999 alcançado corretamente.");
            end

            /*
             * Asserção do estouro das centenas de milhares:
             *
             * 999999 -> 000000
             */
            if (numero_pulso == 1_000_000) begin
                assert (contador_bcd === 24'h000000)
                else begin
                    $fatal(
                        1,
                        {
                            "ERRO na virada de 999999 para 000000: ",
                            "obtido %06h"
                        },
                        contador_bcd
                    );
                end

                $display(
                    {
                        "Vai um das centenas de milhares correto: ",
                        "999999 -> 000000"
                    }
                );
            end

        end

        assert (contador_bcd === 24'h100000)
        else begin
            $fatal(
                1,
                {
                    "ERRO FINAL: após 1.100.000 pulsos, ",
                    "esperado 100000, obtido %06h"
                },
                contador_bcd
            );
        end

        $display("");
        $display("==============================================");
        $display("TESTE CONCLUÍDO COM SUCESSO");
        $display("1.100.000 pulsos verificados.");
        $display("Estado final correto: 100000");
        $display("==============================================");

        $finish;

    end

endmodule