import sys

class logic(object):

    def __init__(self, width, dec_int=0, bin_str='',name=' ', signed=0):
    """
    Class init
    :param width:   bit width
    :param dec_int: int value of decimal
    :param bin_str: string value of binary 
    :param name:    Logic name, it's useful in debug
    :param signed:  When signed is '1', logic is signed
    """
        self.width = width
        self.signed = signed
        self.name = name
        self._dec = ''
        self._bin = 0
        # inti
        if len(bin_str) == 0:
            self.dec = dec_int
        else:
            self.bin = bin_str

    @property
    def dec(self):
        return self._dec

    @dec.setter
    def dec(self, dec_int):
        # get complementary code
        bin_str = bin(dec_int & 0xffffffffffffffff)[2:]

        if (dec_int < 0) and self.signed == 0:
            print('Warning! ' + self.name + ': The logic is unsigned but value is negativa!')

        if (len(bin_str) > self.width) and (len(bin_str) < 64):
            # positive num overflow
            print('Warning! ' + self.name + ': positive overflow!')

        if (len(bin_str) == 64) and ('0' in bin_str[0:64-self.width]):
            # negative num overflow
            print('Warning! ' + self.name + ': negative overflow!')

        if len(bin_str) >= self.width:
            # negative number and big positive number
            self._bin = bin_str[-self.width:]
            if self.signed == 1:
                self._dec = int(self._bin[0]) * (2**(self.width - 1)) + int(self._bin[1:], 2)
            else:
                self._dec = int(self._bin, 2)
        else:
            # little positive num
            self._bin = ''.join([(self.width - len(bin_str)) * '0', bin_str])
            self._dec = int(self._bin, 2)

    @property
    def bin(self):
        return self._bin

    @bin.setter
    def bin(self, bin_str):
        if len(bin_str) > self.width:
            print('Warning! ' + self.name + ': OverFlow!')
            self._bin = bin_str[-self.width:]
        else:
            self._bin = ''.join([(self.width - len(bin_str)) * '0', bin_str])

        if self.signed == 1:
            self._dec = int(self._bin[0]) * (2**(self.width - 1)) + int(self._bin[1:], 2)
        else:
            self._dec = int(self._bin, 2)
        
    def __str__(self):
        return self.name + ': ' + str(self.width) + 'bits, ' + str(self.dec) + ', ' + self.bin 

    def __getitem__(self, n):
        if isinstance(n, int): # n是索引
            new = logic(1)
            new.signed = 0
            new.bin = self.bin[-n-1]
            return new
        if isinstance(n, slice): # n是切片
            if (n.start < 0) or (n.stop < 0):
                print('Error! ' + self.name + ': The start or stop of slice cannot be negative!')
                sys.exit(1)
            new = logic(abs(n.start - n.stop) + 1)
            new.signed = False
            new_bin = []
            if n.start > n.stop:
                for i in range(n.start, n.stop-1, -1):
                    new_bin.append(self.bin[-i-1])
            else:
                for i in range(n.start, n.stop+1, 1):
                    new_bin.append(self.bin[-i-1])
            new.bin = ''.join(new_bin)
            return new


if __name__ == '__main__':
    # test
    a = logic(8, bin_str='01101100', name='a')
    b = logic(4, dec_int=10, name='b')
    print(a)
    print(b)
    c = logic(12, name='c')
    c.dec = a.dec + b.dec
    print(c)
    c.bin = a.bin + b[0].bin
    print(c)
