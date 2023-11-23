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
vlog shifter.v shifter_tb.v
vsim -t ns -vopt work.shifter_tb -voptargs=+acc
view wave
add wave -radix binary /shift_cntrl
add wave -radix hex /inp
add wave -radix hex /shift_out
run 600 ns