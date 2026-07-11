module gerador_pulso_periodico #(
    parameter int unsigned CICLOS = 50_000_000
)(
    input  logic clk,
    input  logic reset,

    output logic enable
);

    /*
     * Gerador parametrizado de pulso periodico.
     *
     * - Clock Enable Pattern:
     *   gera pulso de habilitacao, nao um novo clock.
     *
     * - One-cycle Pulse Pattern:
     *   enable fica ativo por exatamente um ciclo.
     *
     * - Parameterized Counter Pattern:
     *   o periodo do pulso vem do parametro CICLOS.
     */

    localparam int unsigned LARGURA_CONTADOR =
        (CICLOS <= 1) ? 1 : $clog2(CICLOS);

    logic [LARGURA_CONTADOR-1:0] contador;

    always_ff @(posedge clk) begin
        if (reset) begin
            contador <= '0;
            enable   <= 1'b0;
        end
        else begin
            enable <= 1'b0;

            if (contador == CICLOS - 1) begin
                contador <= '0;
                enable   <= 1'b1;
            end
            else begin
                contador <= contador + 1'b1;
            end
        end
    end

endmodule
