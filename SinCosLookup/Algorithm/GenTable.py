from unicodedata import name
from VerilogTools import logic
import numpy as np
import math

if __name__ == '__main__':
    # 1+1+11
    sin = logic(13, signed=1, name='sin')
    cos = logic(13, signed=1, name='cos')

    # vertor to store table
    sin_table = []
    cos_table = []

    delta = 2 * math.pi / (2**10)

    for i in range(0, 2**10):
        sin.dec = round(math.sin(i*delta) * (2 ** 11))
        sin_table.append(sin.bin)
        cos.dec = round(math.cos(i*delta) * (2 ** 11))
        cos_table.append(cos.bin)

    fw_str = ""

    # Variable Declarations
    for l in range(32):
        fw_str = fw_str + "reg\t\tsigned\t\t[12:0]\t\tsin" + str(l) + "\t\t;\n"
    for l in range(32):
        fw_str = fw_str + "reg\t\tsigned\t\t[12:0]\t\tcos" + str(l) + "\t\t;\n"

    # 32 * Mux32_1
    # start part
    # i Mux_num
    # j data_num
    # k index
    i = 0
    j = 0
    k = 0
    for i in range(32):
        # start block
        fw_str = fw_str + "// Mux32_1: " + str(i) + "\n"
        fw_str = fw_str + "always@(posedge sys_clk or negedge sys_rst_n) begin\n"
        fw_str = fw_str + "\tif(~sys_rst_n) begin\n"
        fw_str = fw_str + "\t\tsin" + str(i) + "\t<=\t13'b0;\n"
        fw_str = fw_str + "\t\tcos" + str(i) + "\t<=\t13'b0;\n"
        fw_str = fw_str + "\tend\n"
        fw_str = fw_str + "\telse if(trig) begin\n"

        # case block
        fw_str = fw_str + "\t\tcase(data_in[4:0])\n"
        for k in range(32):
            fw_str = fw_str + "\t\t\t5'd" + str(k) + ": begin\n"
            fw_str = fw_str + "\t\t\t\tsin" + str(i) + "\t<=\t13'b" + sin_table[j] + ";\n"
            fw_str = fw_str + "\t\t\t\tcos" + str(i) + "\t<=\t13'b" + cos_table[j] + ";\n"
            fw_str = fw_str + "\t\t\tend\n"  
            j = j + 1
        # default
        fw_str = fw_str + "\t\t\tdefault: begin\n"
        fw_str = fw_str + "\t\t\t\tsin" + str(i) + "\t<=\t13'd0;\n"
        fw_str = fw_str + "\t\t\t\tcos" + str(i) + "\t<=\t13'd0;\n"
        fw_str = fw_str + "\t\t\tend\n"
        fw_str = fw_str + "\t\tendcase\n"

        # end block
        fw_str = fw_str + "\tend\n"
        fw_str = fw_str + '\telse begin\n'
        fw_str = fw_str + "\t\tsin" + str(i) + "\t<= \tsin" + str(i) + ";\n"
        fw_str = fw_str + "\t\tcos" + str(i) + "\t<= \tcos" + str(i) + ";\n"
        fw_str = fw_str + "\tend\n"
        fw_str = fw_str + "end\n"
        fw_str = fw_str + "\n"
    

    # final Mux32_1
    fw_str = fw_str + "// finial Mux32_1\n"
    fw_str = fw_str + "always@(posedge sys_clk or negedge sys_rst_n) begin\n"
    fw_str = fw_str + "\tif(~sys_rst_n) begin\n"
    fw_str = fw_str + "\t\tsin_out\t<=\t13'b0;\n"
    fw_str = fw_str + "\t\tcos_out\t<=\t13'b0;\n"
    fw_str = fw_str + "\tend\n"
    fw_str = fw_str + "\telse if(trig_reg) begin\n"

    h = 0
    fw_str = fw_str + "\t\tcase(data_in_reg[9:5])\n"
    for h in range(32):
        fw_str = fw_str + "\t\t\t5'd" + str(h) + ": begin\n"
        fw_str = fw_str + "\t\t\t\tsin_out\t<=\tsin" + str(h) + ";\n"
        fw_str = fw_str + "\t\t\t\tcos_out\t<=\tcos" + str(h) + ";\n"
        fw_str = fw_str + "\t\t\tend\n"
    
    # default
    fw_str = fw_str + "\t\t\tdefault: begin\n"
    fw_str = fw_str + "\t\t\t\tsin_out\t<=\t13'd0;\n"
    fw_str = fw_str + "\t\t\t\tcos_out\t<=\t13'd0;\n"
    fw_str = fw_str + "\t\t\tend\n"

    fw_str = fw_str + "\t\tendcase\n"
    fw_str = fw_str + "\tend\n"
    fw_str = fw_str + "end\n"


    print(fw_str)




