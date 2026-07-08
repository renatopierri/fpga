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
     * Versao YELLOW.
     *
     * Esta implementacao passa o primeiro teste do enable_1hz,
     * mas ainda esta propositalmente feia e incompleta.
     *
     * Pontos ruins de proposito:
     *
     * - nome de variavel ruim;
     * - indentacao pouco caprichada;
     * - enable_100hz ainda nao implementado;
     * - codigo escrito apenas para vencer o primeiro teste.
     *
     * O objetivo e criar uma etapa clara para refatoracao.
     */

localparam int unsigned tamanho_da_coisa_1hz =
    (CICLOS_1HZ <= 1) ? 1 : $clog2(CICLOS_1HZ);

logic [tamanho_da_coisa_1hz-1:0] treco_que_conta_1hz;

always_ff @(posedge clk) begin
if (reset) begin
    treco_que_conta_1hz <= '0;
        enable_1hz <= 1'b0;
    enable_100hz <= 1'b0;
end
else begin
        enable_1hz <= 1'b0;
enable_100hz <= 1'b0;

    if (treco_que_conta_1hz == CICLOS_1HZ - 1) begin
        treco_que_conta_1hz <= '0;
            enable_1hz <= 1'b1;
    end
    else begin
            treco_que_conta_1hz <= treco_que_conta_1hz + 1'b1;
    end
end
end

endmodule

