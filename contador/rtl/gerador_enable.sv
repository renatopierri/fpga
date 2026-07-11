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
     * Versao GREEN refatorada.
     *
     * Esta versao mantem o comportamento validado pelo primeiro teste:
     *
     * - reset interno ativo em nivel alto;
     * - enable_1hz gerado no intervalo parametrizado;
     * - enable_1hz ativo por exatamente um ciclo de clock.
     *
     * O enable_100hz permanece em zero porque ainda nao existe
     * teste funcional para ele. Ele sera implementado em um novo
     * ciclo RED, YELLOW, GREEN.
     *
     * Padroes preservados e explicitados:
     *
     * - Clock Enable Pattern:
     *   gera pulso de enable, nao um novo clock.
     *
     * - One-cycle Pulse Pattern:
     *   a saida volta para zero por padrao a cada ciclo.
     *
     * - Parameterized Counter Pattern:
     *   o periodo do pulso e definido por parametro.
     */

    localparam int unsigned LARGURA_CONTADOR_1HZ =
        (CICLOS_1HZ <= 1) ? 1 : $clog2(CICLOS_1HZ);

    logic [LARGURA_CONTADOR_1HZ-1:0] contador_1hz;

    always_ff @(posedge clk) begin
        if (reset) begin
            contador_1hz <= '0;
            enable_1hz   <= 1'b0;
            enable_100hz <= 1'b0;
        end
        else begin
            enable_1hz   <= 1'b0;
            enable_100hz <= 1'b0;

            if (contador_1hz == CICLOS_1HZ - 1) begin
                contador_1hz <= '0;
                enable_1hz   <= 1'b1;
            end
            else begin
                contador_1hz <= contador_1hz + 1'b1;
            end
        end
    end

endmodule
