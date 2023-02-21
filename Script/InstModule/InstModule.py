#!/usr/bin/python3

import sys
import argparse
import re

class ModulePort(object):
    def __init__(self):
        self.name   = '' # Port name
        self.direct = '' # Port direction, include input, output and inout
        self.width  = None  # Bit width None: depends on parameter
        self.sign   = 'unsigned' # signed or unsigned, default: unsigned
        self.net    = 'wire' # Net, wire or reg

    def print_info(self):
        print('name: ', self.name)
        print('direct: ', self.direct)
        print('width: ', self.width)
        print('sign: ', self.sign)
        print('net: ', self.net)
        print('')


class ModuleParam(object):
    def __init__(self):
        self.name   = ''
        self.value  = None # default value

    def print_info(self):
        print('name: ', self.name)
        print('default: ', self.value)
        print('')


# Split words from a line.
def SplitWord(line):
    special = [' ', '\n', '\t']
    words = []
    word = []
    for s in line:
        if s in special:
            if len(word) == 0:
                pass
            else:
                word_str = ''.join(word)
                words.append(word_str)
                word = []
        else:
            word.append(s)  
    return words

def del_single_comment(line):
    m = re.search(r"//", line)
    if m:
        if m.start() == 0:
            line = ''
        else: 
            line = line[0:m.start()-1]
    else:
        line = line;
    return line

# calculate port width and filter string
def cal_port_width(line):
    width = '1'
    m = re.search(r"\[[^\]]*\]", line)
    if m:
        new_line = re.sub(r"\[[^\]]*\]", ' ', line)
        width_string = m.group()
        p = re.compile(r"\w+")
        nums = p.findall(width_string)
        width = width_string
        if len(nums) == 2:
            if nums[0].isdigit() and nums[1].isdigit():
                width = str(abs(int(nums[0]) - int(nums[1])) + 1)
    else:
        new_line = line
    return width, new_line

def generate_inst(module_name, params, ports, fill=True, tab_num=4):
    inst = ''
    tab = 4*' '
    # calculate longest string of name
    max_len = 0;
    for param in params:
        max_len = len(param.name) if len(param.name) > max_len else max_len
        max_len = len(param.value) if len(param.value) > max_len else max_len
    for port in ports:
        max_len = len(port.name) if len(port.name) > max_len else max_len
    tab_len = (((max_len + 1) // 4) + 1) * 4
    tab_len = max(tab_len, tab_num * 4)

    inst += module_name + ' '
    # params
    if len(params) != 0:
        inst += '#(\n'
        for i in range(len(params)):
            inst += tab + '.' + params[i].name + (tab_len - 1 - len(params[i].name)) * ' '
            # fill default value
            if fill:
                inst += '(' + params[i].value + (tab_len - 1 - len(params[i].value)) * ' ' + ')' 
            else:
                inst += '(' + (tab_len - 1) * ' ' + ')'
            if i == len(params) - 1:
                # last param
                inst += '\n) '
            else:
                inst += ',\n'
    # port
    assert(len(ports) != 0)
    inst += module_name + '_ (\n'
    for i in range(len(ports)):
        inst += tab + '.' + ports[i].name + (tab_len - 1 - len(ports[i].name)) * ' '
        # fill default value
        if fill:
            inst += '(' + ports[i].name + (tab_len - 1 - len(ports[i].name)) * ' ' + ')' 
        else:
            inst += '(' + (tab_len - 1) * ' ' + ')'
        inst += ' ' if i == len(ports) - 1 else ','
        # direct comment
        inst += ' // '
        if ports[i].direct == 'input':
            inst += 'i'
        elif ports[i].direct == 'output':
            inst += 'o'
        else:
            inst += 'io'
        # width comment
        inst += ' ' + ports[i].width + 'b '
        # signed comment
        inst += 'signed\n' if ports[i].sign == 'signed' else '\n'
        # last param 
        if i == len(ports) - 1:
            inst += ');'
    return inst 
    
def detect_module(file_name):
    module_name = ""
    params = []
    ports = []

    # read file and delate comment
    all_string = ''
    fd = open(file_name)
    for i in range(1000):
        line = fd.readline().strip("\n")
        # delate single comment
        line = del_single_comment(line) 
        if line != '':
            all_string = all_string + ' ' + line
    
    # delate all comment
    all_string = re.sub(r"/\*.*(\*/){0}.*\*/",' ', all_string)
    
    # find module body
    m = re.search(r"module[^;]*;", all_string)
    if m is None:
        print("no matched module")
        sys.exit(-1)
    module_string = m.group()

    # detect module name
    m = re.search(r"module *[^ #(]*", module_string)
    assert(m)
    module_name = m.group().split()[1]

    # detect parameter list
    p = re.compile(r"[^ ,)]* *= *[^ ,)]*")
    param_strings = p.findall(module_string)

    for param_string in param_strings:
        param = ModuleParam()
        splits = re.split(r"[= ]*", param_string)
        param.name = splits[0]
        param.value = splits[1]
        params.append(param)

    # detect port body
    m = re.search(r"\([^;\(]*\) *;", module_string)
    assert(m)
    port_body_string = m.group()

    # detect port
    p = re.compile(r"(input[^,\)]*|output[^,\)]*|inout[^,\)]*)")
    port_strings = p.findall(port_body_string)
    for port_string in port_strings:
        port = ModulePort()
        width, new_port_string = cal_port_width(port_string)
        port.width = width
        p = re.compile(r"\w+")
        strings = p.findall(new_port_string)
        # name
        port.name = strings[-1]
        # direct
        port.direct = strings[0]
        # net
        if "reg" in strings:
            port.net = "reg"
        # sign
        if "signed" in strings:
            port.sign = "signed"
        ports.append(port)

    return module_name, params, ports


if __name__ == '__main__':
    parser = argparse.ArgumentParser()  
    parser.add_argument('module_file', help="The module design file.")
    parser.add_argument('-f', '--fill_port', help="Also fill port.", action='store_true')
    parser.add_argument('-p', '--print_port', help="Print port info.", action='store_true')
    parser.add_argument('-l', '--tab_num', help="Tab length in brackets.", type=int, default='4')
    args = parser.parse_args()

    file_name = args.module_file
    module_name, params, ports = detect_module(file_name)

    # print
    if args.print_port:
        for param in params:
            param.print_info()
        for port in ports:
            port.print_info()

    inst = generate_inst(module_name, params, ports, fill=args.fill_port, tab_num=args.tab_num)

    print(inst)
