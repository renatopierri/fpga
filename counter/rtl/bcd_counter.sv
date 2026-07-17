module bcd_counter (
    input logic enable_clock_001_Hz,
	 input logic clk_50mhz,

    output logic bit_0,
    output logic bit_1,
    output logic bit_2,
    output logic bit_3,
    output logic bit_4,
    output logic bit_5,
    output logic bit_6,
    output logic bit_7,
    output logic bit_8,
    output logic bit_9,
    output logic bit_10,
    output logic bit_11,
    output logic bit_12,
    output logic bit_13,
    output logic bit_14,
    output logic bit_15,
    output logic bit_16,
    output logic bit_17,
    output logic bit_18,
    output logic bit_19,
    output logic bit_20,
    output logic bit_21,
    output logic bit_22,
    output logic bit_23	 
);

    /*
     * Seis algarismos BCD:
     *
     * unidades: 	bits 03 a 00
     * dezenas:  	bits 07 a 04
	  * centenas:	bits 11 a 08
	  * milhares:	bits 15 a 12
	  * dez milh:	bits 19 a 16
	  * cent milh:	bits 24 a 20
	  *
     */
	  
    logic [3:0] unidades = 4'd0;
    logic [3:0] dezenas  = 4'd0;
	 logic [3:0] centenas  = 4'd0;
	 logic [3:0] milhares  = 4'd0;
	 logic [3:0] dez_milhar  = 4'd0;
	 logic [3:0] cent_milhar  = 4'd0;

    /*
     * Incrementa o contador a cada borda de subida
     * de enable_clock_001_Hz.
     */

    always_ff @(posedge clk_50mhz) begin
        if (enable_clock_001_Hz) begin
            if (unidades == 4'd9) begin
                unidades <= 4'd0;
                if (dezenas == 4'd9) begin
                    dezenas <= 4'd0;						  
						if (centenas == 4'd9) begin
							centenas <= 4'd0;
							if (milhares == 4'd9) begin
								milhares <= 4'd0;								  
									if (dez_milhar == 4'd9) begin
										dez_milhar <= 4'd0;								  
											if (cent_milhar == 4'd9) begin
												  cent_milhar <= 4'd0;
											end else begin
												  cent_milhar <= cent_milhar + 4'd1; 
											end
										end else begin
										dez_milhar <= dez_milhar + 4'd1;
									end								  
								end else begin
								milhares <= milhares + 4'd1;
							end							  
							end else begin
							centenas <= centenas + 4'd1;	
						end
                end else begin
                    dezenas <= dezenas + 4'd1;
                end
            end else begin
                unidades <= unidades + 4'd1;
            end
        end
    end

    /*
     * Disponibiliza os seis algarismos BCD
     * nas 24 saídas individuais.
     */
    assign bit_0 = unidades[0];
    assign bit_1 = unidades[1];
    assign bit_2 = unidades[2];
    assign bit_3 = unidades[3];

    assign bit_4 = dezenas[0];
    assign bit_5 = dezenas[1];
    assign bit_6 = dezenas[2];
    assign bit_7 = dezenas[3];
	 
    assign bit_8 = centenas[0];
    assign bit_9 = centenas[1];
    assign bit_10 = centenas[2];
    assign bit_11 = centenas[3];

    assign bit_12 = milhares[0];
    assign bit_13 = milhares[1];
    assign bit_14 = milhares[2];
    assign bit_15 = milhares[3];

    assign bit_16 = dez_milhar[0];
    assign bit_17 = dez_milhar[1];
    assign bit_18 = dez_milhar[2];
    assign bit_19 = dez_milhar[3];

    assign bit_20 = cent_milhar[0];
    assign bit_21 = cent_milhar[1];
    assign bit_22 = cent_milhar[2];
    assign bit_23 = cent_milhar[3]; 

endmodule