/*******************************************************************************
* Copyright (C) 2018-2022 Intel Corporation
* 
* This code and the related documents are Intel copyrighted materials, and 
* your use of them is governed by the express license under which they were 
* provided to you ("License"). Unless the License provides otherwise, you may 
* not use, modify, copy, publish, distribute, disclose or transmit this 
* code or the related documents without Intel's prior written permission.
*
* This code and the related documents are provided as is, with no express 
* or implied warranties, other than those that are expressly stated in the 
* License.
*
*******************************************************************************/

`timescale 1ns / 100ps
`define ClkPeriod 20

module count_moda_tb;

reg clk, rst, updown;
wire [7:0] q;

initial
begin
  clk=0;
  forever clk=#(`ClkPeriod/2)~clk;
end

initial
begin
  rst = 1;
  updown = 1;
  #2220 updown = 0;
  #20 rst = 1;
end

count_moda u1(.clk(clk), .updown(updown), .aclr_n(rst), .q(q));
endmodule