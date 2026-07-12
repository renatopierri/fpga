module gerador_enable #(
    parameter int unsigned CICLOS_1HZ   = 50_000_000,
    parameter int unsigned CICLOS_100HZ = 500_000
)(
    input  logic clk,
    input  logic reset,

    output logic enable_1hz,
    output logic enable_100hz
);

    /*
     * Duas instancias do mesmo gerador parametrizado.
     * O modulo nao cria clocks internos: gera enables
     * sincronizados ao clock principal.
     */

    gerador_pulso_periodico #(
        .CICLOS(CICLOS_1HZ)
    ) instancia_enable_1hz (
        .clk    (clk),
        .reset  (reset),
        .enable (enable_1hz)
    );

    gerador_pulso_periodico #(
        .CICLOS(CICLOS_100HZ)
    ) instancia_enable_100hz (
        .clk    (clk),
        .reset  (reset),
        .enable (enable_100hz)
    );

endmodule

