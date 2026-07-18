module mux (
    input logic clk_50mhz,
    input logic enable_clock_600_Hz,

    input logic bit_0,
    input logic bit_1,
    input logic bit_2,
    input logic bit_3,
    input logic bit_4,
    input logic bit_5,
    input logic bit_6,
    input logic bit_7,
    input logic bit_8,
    input logic bit_9,
    input logic bit_10,
    input logic bit_11,
    input logic bit_12,
    input logic bit_13,
    input logic bit_14,
    input logic bit_15,
    input logic bit_16,
    input logic bit_17,
    input logic bit_18,
    input logic bit_19,
    input logic bit_20,
    input logic bit_21,
    input logic bit_22,
    input logic bit_23,

    output logic [3:0] bcd_mux,

    output logic dig1,
    output logic dig2,
    output logic dig3,
    output logic dig4,
    output logic dig5,
    output logic dig6
);

    /*
     * Indice do digito apresentado:
     *
     * 0: unidades
     * 1: dezenas
     * 2: centenas
     * 3: milhares
     * 4: dezenas de milhares
     * 5: centenas de milhares
     */
    logic [2:0] indice_digito = 3'd0;

    /*
     * Avanca um digito a cada pulso de 600 Hz.
     * O pulso e usado como clock enable; todo o circuito
     * permanece sincronizado com clk_50mhz.
     */
    always_ff @(posedge clk_50mhz) begin
        if (enable_clock_600_Hz) begin
            if (indice_digito == 3'd5) begin
                indice_digito <= 3'd0;
            end else begin
                indice_digito <= indice_digito + 3'd1;
            end
        end
    end

    /*
     * Seleciona um algarismo BCD por vez e habilita somente
     * o display correspondente. As linhas dig1 a dig6 sao
     * ativas em nivel baixo.
     */
    always_comb begin
        bcd_mux = 4'b0000;

        dig1 = 1'b1;
        dig2 = 1'b1;
        dig3 = 1'b1;
        dig4 = 1'b1;
        dig5 = 1'b1;
        dig6 = 1'b1;

        case (indice_digito)
            3'd0: begin
                bcd_mux = {bit_3, bit_2, bit_1, bit_0};
                dig1 = 1'b0;
            end

            3'd1: begin
                bcd_mux = {bit_7, bit_6, bit_5, bit_4};
                dig2 = 1'b0;
            end

            3'd2: begin
                bcd_mux = {bit_11, bit_10, bit_9, bit_8};
                dig3 = 1'b0;
            end

            3'd3: begin
                bcd_mux = {bit_15, bit_14, bit_13, bit_12};
                dig4 = 1'b0;
            end

            3'd4: begin
                bcd_mux = {bit_19, bit_18, bit_17, bit_16};
                dig5 = 1'b0;
            end

            3'd5: begin
                bcd_mux = {bit_23, bit_22, bit_21, bit_20};
                dig6 = 1'b0;
            end

            default: begin
                bcd_mux = 4'b0000;
            end
        endcase
    end

endmodule
