#!/usr/bin/python3

import sys
import argparse

class ModulePort(object):
    def __init__(self):
        self.note = '' # If note isn't empty, it is just a comment.
        self.name = '' # Port name
        self.direct = '' # Port direction, include input, output and inout
        self.length = 1 # Bit width
        self.sign = 'unsigned' # signed or unsigned, default: unsigned
        self.net = 'wire' # Net, wire or reg

    def param_print(self):
        if len(self.note) == 0:
            print('name: ', self.name)
            print('direct: ', self.direct)
            print('length: ', self.length)
            print('sign: ', self.sign)
            print('net: ', self.net)
        else:
            print('note: ', self.note)
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


if __name__ == '__main__':

    parser = argparse.ArgumentParser()  
    parser.add_argument('module_file', help="The module design file.")
    parser.add_argument('-p', '--port', help="Also instance port.", action='store_true')
    parser.add_argument('-f', '--file', help="Save a instance file.", action='store_true')
    parser.add_argument('-l', '--length', help="Tab length in brackets.", type=int, default='6')
    args = parser.parse_args()

    file_name = args.module_file
    fp = open(file_name, 'r')
    ports = []    
    module_name = ''

    # Find module name
    find_module = False
    for i in range(1000):
        line = fp.readline()
        words = SplitWord(line)
        if len(words) != 0:
            if words[0] == 'module':
                tmp = []
                for s in words[1]:
                    if s != '(':
                        tmp.append(s)
                    else:
                        break;
                module_name = ''.join(tmp)        
                find_module = True
                break;
        else:
            pass
    if not find_module:
        print('Error, the file has no module in the first 1000 lines.')
        sys.exit(1)
   
    over = False
    for i in range(1000):
        port = ModulePort()    
        line = fp.readline()
        words = SplitWord(line)

        if over:
            break

        # ignore blank lines
        if len(words) == 0:
            continue

        # save all note, include ahead 'Tab' 
        if words[0][0] == '/':
            port.note = line[0:-1]
            ports.append(port)
            continue
        
        # When find ')', dectect is over
        for word in words:
            if '//' in word:
                break
            if ')' in word:
                over = True

        if (words[0] == 'input') or (words[0] == 'output'):
            port.direct = words[0]
            for word in words[1:]:
                if word == 'signed':
                    port.sign = 'signed'
                elif ':' in word:
                    left = []
                    right = []
                    flag = True
                    for s in word:
                        if (s != '[') and (s != ':') and flag: 
                            left.append(s)
                        elif s == '[':
                            pass
                        elif s == ':':
                            flag = False
                        elif s != ']':
                            right.append(s)
                        else:
                            break
                    port.length = abs(int(''.join(left)) - int(''.join(right))) + 1
                elif 'reg' in word:
                    port.net = 'reg'
                elif 'wire' in word:
                    port.net = 'wire'
                else:
                    tmp = []
                    for s in word:
                        if (s != ',') and (s != ')'):
                            tmp.append(s)
                        else:
                            break
                    port.name = ''.join(tmp)
                    break
            ports.append(port)

    if not over:
        print('Error, the file has no module end in the first 1000 lines.')

    fp.close()


    # write string
    fw_str = ''

    fw_str = fw_str + module_name + ' ' + module_name + '_inst(\n'
    tab_len = args.length

    for i in range(len(ports)):
        if len(ports[-1-i].note) == 0:
            last_port_name = ports[-1-i].name
            break

    for port in ports:
        # It is just a comment.
        if len(port.note) != 0:
            fw_str = fw_str + port.note + '\n'
        else:
            fw_str = fw_str + '\t' + '.' + port.name
            # alignment
            tab_num = tab_len - (len(port.name) + 1)//4
            for i in range(tab_num):
                fw_str = fw_str + '\t'
            
            # also instance port
            if args.port:
                fw_str = fw_str + '(' + port.name
                for i in range(tab_num):
                    fw_str = fw_str + '\t'
            else:
                fw_str = fw_str + '('
                for i in range(tab_len):
                    fw_str = fw_str + '\t'

            # last port
            if port.name == last_port_name:
                fw_str = fw_str + ')'
            else:
                fw_str = fw_str + '),'

            #add comment
            fw_str = fw_str + '\t' + '// ' + port.direct[0] + ' ' + str(port.length) + 'b' + '\n'

    # last line
    fw_str = fw_str + ');'

    print(fw_str)

    # Write a instance file
    new_file_name = file_name[0:-2] + '_inst' + file_name[-2:]
    if args.file:
        fw = open(new_file_name, 'w') 
        fw.write("// This is a instance file generated by scripy file 'InstModule'.\n")
        fw.write(fw_str)
        fw.close()
