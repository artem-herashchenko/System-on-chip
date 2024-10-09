module component_tutorial (CLOCK_50, KEY, SW,
                           HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
    input CLOCK_50;
    input [0:0] KEY;
	 input [3:0] SW;
    output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
    wire [23:0] to_HEX;
    embedded_system U0 (
        .clk_clk(CLOCK_50),
        .reset_reset_n(KEY[0]),
		  .switches_export(SW),
        .to_hex_readdata(to_HEX),
        );
		  
    hex7seg h0(to_HEX[3:0], HEX0);
    hex7seg h1(to_HEX[7:4], HEX1);
    hex7seg h2(to_HEX[11:8], HEX2);
	 hex7seg h3(to_HEX[15:12], HEX3);
	 hex7seg h4(to_HEX[19:16], HEX4);
	 hex7seg h5(to_HEX[23:20], HEX5);
endmodule