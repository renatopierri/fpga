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
     * Primeira extracao reutilizavel.
     *
     * Neste momento, somente enable_1hz e implementado.
     * O enable_100hz permanece em zero porque ainda sera
     * especificado por um novo teste RED.
     */

    gerador_pulso_periodico #(
        .CICLOS(CICLOS_1HZ)
    ) instancia_enable_1hz (
        .clk    (clk),
        .reset  (reset),
        .enable (enable_1hz)
    );

    assign enable_100hz = 1'b0;

endmodule
