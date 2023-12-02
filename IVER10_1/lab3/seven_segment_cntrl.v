module seven_segment_cntrl (
  input [2:0] inp,            
  output reg seg_a, seg_b, seg_c, seg_d,  
  output reg seg_e, seg_f, seg_g      
);
  
  always@ (inp) begin
    
    case(inp)
      // 7-segment display apresenta '0' quando entrada é igual a "000"
      // 7-segment display apresenta '1' quando entrada é igual a "001"
      // 7-segment display apresenta '2' quando entrada é igual a "010"
      // 7-segment display apresenta '3' quando entrada é igual a "011"
      // 7-segment display apresenta 'E' quando entrada tiver outros valores
		
      3'B000  : {seg_a,seg_b,seg_c,seg_d,seg_e,seg_f,seg_g} = 7'b1111110;  
      3'B001  : {seg_a,seg_b,seg_c,seg_d,seg_e,seg_f,seg_g} = 7'b0110000;  
      3'B010  : {seg_a,seg_b,seg_c,seg_d,seg_e,seg_f,seg_g} = 7'b1101101;
      3'B011  : {seg_a,seg_b,seg_c,seg_d,seg_e,seg_f,seg_g} = 7'b1111001;
      default : {seg_a,seg_b,seg_c,seg_d,seg_e,seg_f,seg_g} = 7'b1001111;
    endcase
  end 
endmodule 