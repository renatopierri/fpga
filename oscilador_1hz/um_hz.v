module um_hz (
	input clk_50mhz,rst_50mhz,
	output reg out_1hz
);
// generate 1 Hz from 50 MHz
reg [25:0] count_reg = 0;
//reg out_1hz = 0;

always @(posedge clk_50mhz or negedge rst_50mhz) begin
    if (rst_50mhz == 0) begin
        count_reg <= 0;
        out_1hz <= 0;
    end else begin
        if (count_reg < 50000000) begin
            count_reg <= count_reg + 1;
        end else begin
            count_reg <= 0;
            out_1hz <= ~out_1hz;
        end
    end
end
endmodule