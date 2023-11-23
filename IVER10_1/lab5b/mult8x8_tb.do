#############################################################################
# Copyright (C) 2018-2022 Intel Corporation
# 
# This code and the related documents are Intel copyrighted materials, and 
# your use of them is governed by the express license under which they were 
# provided to you ("License"). Unless the License provides otherwise, you may 
# not use, modify, copy, publish, distribute, disclose or transmit this 
# code or the related documents without Intel's prior written permission.
#
# This code and the related documents are provided as is, with no express 
# or implied warranties, other than those that are expressly stated in the 
# License.
#
#############################################################################

vlib work
vlog ../lab1a/adder.v
vlog ../lab1b/mult4x4.v
vlog ../lab2a/mux4.v
vlog ../lab2b/shifter.v
vlog ../lab3/seven_segment_cntrl.v
vlog ../lab4a/reg16.v
vlog ../lab4b/counter.v
vlog ../lab5a/mult_control.v
vlog mult8x8.v mult8x8_tb.v
vsim -t ns -vopt work.mult8x8_tb -voptargs=+acc
view wave
add wave -height 20 -divider "Control Signals"
add wave -radix binary /clk
add wave -radix binary /start
add wave -radix binary /reset_a
add wave -height 20 -divider "Multiplicands"
add wave -radix unsigned /dataa
add wave -radix unsigned /datab
add wave -height 20 -divider "Product & Done Flag"
add wave -radix unsigned /product8x8_out
add wave -radix binary /done_flag
add wave -height 20 -divider "7-segment Display"
add wave -radix binary /seg_a
add wave -radix binary /seg_b
add wave -radix binary /seg_c
add wave -radix binary /seg_d
add wave -radix binary /seg_e
add wave -radix binary /seg_f
add wave -radix binary /seg_g
add wave -height 20 -divider "Addt'l Signals"
add wave /mult8x8_tb/mult8x8_1/u6/current_state
run 5 us
