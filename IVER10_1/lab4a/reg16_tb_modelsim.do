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
#############################################################################*

vlib work
vlog reg16.v reg16_tb.v
vsim -t ns work.reg16_tb
view wave
add wave -radix binary /clk
add wave -radix binary /sclr_n
add wave -radix binary /clk_ena
add wave -radix hex /datain
add wave -radix hex /reg_out
run 250 ns