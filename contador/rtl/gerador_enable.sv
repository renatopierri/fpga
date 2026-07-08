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
     * Implementação temporária.
     *
     * Os sinais permanecem em zero para permitir que o módulo
     * compile antes de sua lógica ser desenvolvida.
     *
     * Os primeiros testes deverão falhar porque nenhum pulso
     * será produzido.
     */
    always_comb begin
        enable_1hz   = 1'b0;
        enable_100hz = 1'b0;
    end

endmodule
