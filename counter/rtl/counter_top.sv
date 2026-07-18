module counter_top (
    input logic clk_50mhz,

    output logic enable_clock_001_Hz,
    output logic enable_clock_100_Hz,

    output logic dig1,
    output logic dig2,
    output logic dig3,
    output logic dig4,
    output logic dig5,
    output logic dig6,

    output logic segment_a,
    output logic segment_b,
    output logic segment_c,
    output logic segment_d,
    output logic segment_e,
    output logic segment_f,
    output logic segment_g
);

    /*
     * Barramento interno que transporta os seis algarismos BCD
     * gerados pelo contador ate o multiplexador.
     */
    logic [23:0] contador_bcd;

    /*
     * Algarismo BCD selecionado pelo multiplexador para exibicao.
     */
    logic [3:0] bcd_mux;

    /*
     * Clock enable interno usado para a varredura dos displays.
     */
    logic enable_clock_600_Hz;

    /*
     * Gera os pulsos de clock enable de 1 Hz, 100 Hz e 600 Hz
     * a partir do clock principal de 50 MHz.
     */
    divider divider_inst (
        .clk_50mhz           (clk_50mhz),
        .enable_clock_001_Hz (enable_clock_001_Hz),
        .enable_clock_100_Hz (enable_clock_100_Hz),
        .enable_clock_600_Hz (enable_clock_600_Hz)
    );

    /*
     * Conta de 000000 ate 999999 em BCD. O pulso de 1 Hz
     * determina o instante de cada incremento.
     */
    bcd_counter bcd_counter_inst (
        .clk_50mhz           (clk_50mhz),
        .enable_clock_001_Hz (enable_clock_001_Hz),
        .bit_0               (contador_bcd[0]),
        .bit_1               (contador_bcd[1]),
        .bit_2               (contador_bcd[2]),
        .bit_3               (contador_bcd[3]),
        .bit_4               (contador_bcd[4]),
        .bit_5               (contador_bcd[5]),
        .bit_6               (contador_bcd[6]),
        .bit_7               (contador_bcd[7]),
        .bit_8               (contador_bcd[8]),
        .bit_9               (contador_bcd[9]),
        .bit_10              (contador_bcd[10]),
        .bit_11              (contador_bcd[11]),
        .bit_12              (contador_bcd[12]),
        .bit_13              (contador_bcd[13]),
        .bit_14              (contador_bcd[14]),
        .bit_15              (contador_bcd[15]),
        .bit_16              (contador_bcd[16]),
        .bit_17              (contador_bcd[17]),
        .bit_18              (contador_bcd[18]),
        .bit_19              (contador_bcd[19]),
        .bit_20              (contador_bcd[20]),
        .bit_21              (contador_bcd[21]),
        .bit_22              (contador_bcd[22]),
        .bit_23              (contador_bcd[23])
    );

    /*
     * Seleciona um dos seis algarismos BCD a cada pulso de
     * 600 Hz e habilita a linha dig correspondente.
     */
    mux mux_inst (
        .clk_50mhz           (clk_50mhz),
        .enable_clock_600_Hz (enable_clock_600_Hz),
        .bit_0               (contador_bcd[0]),
        .bit_1               (contador_bcd[1]),
        .bit_2               (contador_bcd[2]),
        .bit_3               (contador_bcd[3]),
        .bit_4               (contador_bcd[4]),
        .bit_5               (contador_bcd[5]),
        .bit_6               (contador_bcd[6]),
        .bit_7               (contador_bcd[7]),
        .bit_8               (contador_bcd[8]),
        .bit_9               (contador_bcd[9]),
        .bit_10              (contador_bcd[10]),
        .bit_11              (contador_bcd[11]),
        .bit_12              (contador_bcd[12]),
        .bit_13              (contador_bcd[13]),
        .bit_14              (contador_bcd[14]),
        .bit_15              (contador_bcd[15]),
        .bit_16              (contador_bcd[16]),
        .bit_17              (contador_bcd[17]),
        .bit_18              (contador_bcd[18]),
        .bit_19              (contador_bcd[19]),
        .bit_20              (contador_bcd[20]),
        .bit_21              (contador_bcd[21]),
        .bit_22              (contador_bcd[22]),
        .bit_23              (contador_bcd[23]),
        .bcd_mux              (bcd_mux),
        .dig1                 (dig1),
        .dig2                 (dig2),
        .dig3                 (dig3),
        .dig4                 (dig4),
        .dig5                 (dig5),
        .dig6                 (dig6)
    );

    /*
     * Converte o algarismo BCD selecionado nos sete sinais
     * compartilhados pelos seis displays.
     */
    bcd_7_segments bcd_7_segments_inst (
        .bcd_mux   (bcd_mux),
        .segment_a (segment_a),
        .segment_b (segment_b),
        .segment_c (segment_c),
        .segment_d (segment_d),
        .segment_e (segment_e),
        .segment_f (segment_f),
        .segment_g (segment_g)
    );

endmodule
