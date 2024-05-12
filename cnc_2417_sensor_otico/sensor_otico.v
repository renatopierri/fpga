module sensor_otico(
	input x1, x2, x3, x4, x5, x6,
	output s1, s2, s3
);

assign s1 = (x1 ^ x2);
assign s2 = (x3 ^ x4);
assign s3 = (x5 ^ x6);
endmodule