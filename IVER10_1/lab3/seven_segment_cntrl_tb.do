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
vlog seven_segment_cntrl.v seven_segment_cntrl_tb.v
vsim -t ns -vopt work.seven_segment_cntrl_tb -voptargs=+acc
view wave
add wave -radix binary /inp
add wave -radix binary /seg_a
add wave -radix binary /seg_b
add wave -radix binary /seg_c
add wave -radix binary /seg_d
add wave -radix binary /seg_e
add wave -radix binary /seg_f
add wave -radix binary /seg_g
run 500 ns