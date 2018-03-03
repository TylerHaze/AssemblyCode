
module nios_system (
	clk_clk,
	leds_export,
	reset_reset_n,
	switches_export,
	x_export,
	a_export);	

	input		clk_clk;
	output	[7:0]	leds_export;
	input		reset_reset_n;
	input	[7:0]	switches_export;
	output	[31:0]	x_export;
	output	[7:0]	a_export;
endmodule
