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
vlog mult_control.v mult_control_tb.v
vsim -t ns -vopt work.mult_control_tb -voptargs=+acc
view wave
add wave -radix binary /clk
add wave -radix binary /reset_a
add wave -radix binary /count
add wave -radix binary /start
add wave -radix binary /input_sel
add wave -radix binary /shift_sel
add wave -radix unsigned /state_out
add wave -radix binary /done
add wave -radix binary /clk_ena
add wave -radix binary /sclr_n
add wave /mult_control_tb/mult_control1/current_state
run 400 ns