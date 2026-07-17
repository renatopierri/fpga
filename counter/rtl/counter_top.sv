module counter_top (
    input  logic clk_50mhz,
    output logic enable_clock_001_Hz,
    output logic enable_clock_100_Hz,
	 
	 output logic b_0,
    output logic b_1,
    output logic b_2,
    output logic b_3,
    output logic b_4,
    output logic b_5,
    output logic b_6,
    output logic b_7
);

    /*
     * Entidade de topo provisoria.
     *
     * Nesta etapa, ela apenas instancia o divisor e disponibiliza
     * seus pulsos de clock enable nos pinos de saida da FPGA.
     */
    divider divider_inst (
        .clk_50mhz          (clk_50mhz),
        .enable_clock_001_Hz(enable_clock_001_Hz),
        .enable_clock_100_Hz(enable_clock_100_Hz)
    );
	 
	 bcd_counter bcd_counter_inst(
	   .clk_50mhz (clk_50mhz),
		.enable_clock_001_Hz (enable_clock_001_Hz),
		.bit_0 (b_0),
		.bit_1 (b_1),
		.bit_2 (b_2),
		.bit_3 (b_3),
		.bit_4 (b_4),
		.bit_5 (b_5),
		.bit_6 (b_6),
		.bit_7 (b_7)
	 );
endmodule