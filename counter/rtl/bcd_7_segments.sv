module bcd_7_segments (
    input logic [3:0] bcd_mux,

    output logic segment_a,
    output logic segment_b,
    output logic segment_c,
    output logic segment_d,
    output logic segment_e,
    output logic segment_f,
    output logic segment_g
);

    /*
     * Conversor combinacional de BCD para sete segmentos.
     *
     * A ordem do vetor e:
     * {A, B, C, D, E, F, G}
     *
     * Os segmentos sao ativos em nivel alto:
     * 1 = segmento aceso
     * 0 = segmento apagado
     */
    always_comb begin
        case (bcd_mux)
            4'd0: begin
                {segment_a, segment_b, segment_c, segment_d,
                 segment_e, segment_f, segment_g} = 7'b1111110;
            end

            4'd1: begin
                {segment_a, segment_b, segment_c, segment_d,
                 segment_e, segment_f, segment_g} = 7'b0110000;
            end

            4'd2: begin
                {segment_a, segment_b, segment_c, segment_d,
                 segment_e, segment_f, segment_g} = 7'b1101101;
            end

            4'd3: begin
                {segment_a, segment_b, segment_c, segment_d,
                 segment_e, segment_f, segment_g} = 7'b1111001;
            end

            4'd4: begin
                {segment_a, segment_b, segment_c, segment_d,
                 segment_e, segment_f, segment_g} = 7'b0110011;
            end

            4'd5: begin
                {segment_a, segment_b, segment_c, segment_d,
                 segment_e, segment_f, segment_g} = 7'b1011011;
            end

            4'd6: begin
                {segment_a, segment_b, segment_c, segment_d,
                 segment_e, segment_f, segment_g} = 7'b1011111;
            end

            4'd7: begin
                {segment_a, segment_b, segment_c, segment_d,
                 segment_e, segment_f, segment_g} = 7'b1110000;
            end

            4'd8: begin
                {segment_a, segment_b, segment_c, segment_d,
                 segment_e, segment_f, segment_g} = 7'b1111111;
            end

            4'd9: begin
                {segment_a, segment_b, segment_c, segment_d,
                 segment_e, segment_f, segment_g} = 7'b1111011;
            end

            default: begin
                {segment_a, segment_b, segment_c, segment_d,
                 segment_e, segment_f, segment_g} = 7'b0000000;
            end
        endcase
    end

endmodule
