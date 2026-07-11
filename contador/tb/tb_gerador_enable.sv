`timescale 1ns/1ps

module tb_gerador_enable;

    /*
     * Clock de 50 MHz:
     *
     * Período total = 20 ns
     * 10 ns em nível baixo
     * 10 ns em nível alto
     */
    localparam time PERIODO_CLOCK = 20ns;

    /*
     * Valores reduzidos usados somente na simulação.
     *
     * Na placa real:
     * enable_1hz   usaria 50_000_000 ciclos;
     * enable_100hz usaria 500_000 ciclos.
     *
     * No teste, usamos números pequenos para a simulação
     * rodar rápido.
     */
    localparam int unsigned TB_CICLOS_1HZ   = 10;
    localparam int unsigned TB_CICLOS_100HZ = 4;

    logic clk;
    logic reset;

    logic enable_1hz;
    logic enable_100hz;

    /*
     * Instância do módulo testado.
     *
     * DUT = Device Under Test.
     */
    gerador_enable #(
        .CICLOS_1HZ   (TB_CICLOS_1HZ),
        .CICLOS_100HZ (TB_CICLOS_100HZ)
    ) dut (
        .clk          (clk),
        .reset        (reset),
        .enable_1hz   (enable_1hz),
        .enable_100hz (enable_100hz)
    );

    /*
     * Geração contínua do clock.
     */
    initial begin
        clk = 1'b0;

        forever begin
            #(PERIODO_CLOCK / 2);
            clk = ~clk;
        end
    end

    /*
     * Reset interno ativo em nível alto.
     *
     * reset = 1 → circuito resetado
     * reset = 0 → circuito funcionando
     */
    task automatic aplica_reset;
        begin
            reset = 1'b1;

            repeat (3)
                @(posedge clk);

            @(negedge clk);
            reset = 1'b0;

            $display("INFO: reset liberado em %0t.", $time);
        end
    endtask

    /*
     * Primeiro teste funcional:
     *
     * Depois do reset:
     *
     * - enable_1hz deve ficar em 0 nos ciclos anteriores ao pulso;
     * - no ciclo TB_CICLOS_1HZ, enable_1hz deve ficar em 1;
     * - no ciclo seguinte, enable_1hz deve voltar para 0.
     *
     * Como o DUT ainda não implementa essa lógica, o teste
     * deve falhar. Essa falha é o RED esperado.
     */
    task automatic testa_enable_1hz_um_ciclo;
        begin
            $display("INFO: mensagem gerada pelo testbench tb/tb_gerador_enable.sv.");
			$display("INFO: iniciando verificacao de enable_1hz utilizada nas etapas RED, YELLOW e GREEN.");

            /*
             * Verifica os ciclos antes do pulso esperado.
             */
            for (int ciclo = 1; ciclo < TB_CICLOS_1HZ; ciclo++) begin
                @(posedge clk);
                #1step;

                assert (enable_1hz === 1'b0)
                else
                    $fatal(1,
                           "ERRO: ciclo %0d: enable_1hz deveria estar 0 antes do pulso esperado. Valor lido: %b",
                           ciclo,
                           enable_1hz);
            end

            /*
             * Verifica o ciclo em que o pulso deve aparecer.
             */
            @(posedge clk);
            #1step;

            assert (enable_1hz === 1'b1)
            else
                $fatal(1,
                       "RED esperado: ciclo %0d: enable_1hz deveria estar 1 por um ciclo, mas foi lido %b.",
                       TB_CICLOS_1HZ,
                       enable_1hz);

            /*
             * Verifica se o pulso durou somente um ciclo.
             */
            @(posedge clk);
            #1step;

            assert (enable_1hz === 1'b0)
            else
                $fatal(1,
                       "ERRO: enable_1hz permaneceu ativo por mais de um ciclo. Valor lido: %b",
                       enable_1hz);

            $display("PASS: enable_1hz apareceu no ciclo esperado e durou exatamente um ciclo.");
        end
    endtask
	task automatic testa_enable_100hz_um_ciclo;
		begin
			$display("INFO: mensagem gerada pelo testbench tb/tb_gerador_enable.sv.");
			$display("INFO: iniciando verificacao de enable_100hz utilizada no novo ciclo RED, YELLOW e GREEN.");

			for (int ciclo = 1; ciclo < TB_CICLOS_100HZ; ciclo++) begin
				@(posedge clk);
				#1step;

				assert (enable_100hz === 1'b0)
				else
					$fatal(1,
						   "ERRO: ciclo %0d: enable_100hz deveria estar 0 antes do pulso esperado. Valor lido: %b",
						   ciclo,
						   enable_100hz);
			end

			@(posedge clk);
			#1step;

			assert (enable_100hz === 1'b1)
			else
				$fatal(1,
					   "RED esperado: ciclo %0d: enable_100hz deveria estar 1 por um ciclo, mas foi lido %b.",
					   TB_CICLOS_100HZ,
					   enable_100hz);

			@(posedge clk);
			#1step;

			assert (enable_100hz === 1'b0)
			else
				$fatal(1,
					   "ERRO: enable_100hz permaneceu ativo por mais de um ciclo. Valor lido: %b",
					   enable_100hz);

			$display("PASS: enable_100hz apareceu no ciclo esperado e durou exatamente um ciclo.");
		end
	endtask

    /*
     * Sequência principal da simulação.
     */
	initial begin
		reset = 1'b1;

		aplica_reset();
		testa_enable_1hz_um_ciclo();

		aplica_reset();
		testa_enable_100hz_um_ciclo();

		$display("Fim da simulacao: testes enable_1hz e enable_100hz concluidos.");
		$finish;
	end


endmodule