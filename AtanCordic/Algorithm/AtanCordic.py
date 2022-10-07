from VerilogTools import logic
import matplotlib
matplotlib.use('TkAgg')
import matplotlib.pyplot as plt
import math
import numpy as np


def AtanCordic(data):
    x = 1
    y = data
    z = 0

    itr = 12

    for cnt in range(0, itr):
        tmp1 = x * (2**(-cnt))
        tmp2 = y * (2**(-cnt))
        if ((x < 0) and (y >= 0)) or ((y < 0) and (x >= 0)):
            x = x - tmp2
            y = y + tmp1
            z = z - math.atan(2**(-cnt))
        else:
            x = x + tmp2
            y = y - tmp1
            z = z + math.atan(2**(-cnt))

    theta = z;

    return theta


def AtanCordicFix(data):
    # data: 17bit 1+8+8
    # return: 10bit 10
    # [0,2*pi) mapping [0, 2^10)
    itr = 12
    z_exp = 4  # z extra bit
    exp = -10     # x, y extra bit
    # x,y: 1+9+(8+itr-1+exp)
    x_value = logic(itr + exp + 17, signed=1, name='x')
    y_value = logic(itr + exp + 17, signed=1, name='y')
    # z: 1+8+z_exp
    z_value = logic(10 + z_exp, signed=1, name='z')

    x_value.bin = 9 * '0' + '1' + (itr + exp + 7) * '0'
    y_value.bin = 1 * data[16].bin + data.bin + (itr + exp - 1) * '0'
    z_value.dec = 0
    # print(data)

    # print(x_value)
    # print(y_value)
    # print(z_value)

    # mapping
    delta = 2 * math.pi / (2**10)

    # z_adds
    # z_adds = [524288, 309505, 163534, 83012, 41667, 20854, 10430, 
    # 5215, 2608, 1304, 652, 326, 163, 81, 41, 20, 10, 5]

    # 1+9+(8+itr-1+exp)
    tmp1 = logic(itr + exp + 17, signed=1, name='tmp1')
    tmp2 = logic(itr + exp + 17, signed=1, name='tmp2')
    for cnt in range(0, itr):
        # right shift cnt bit
        tmp1.bin = x_value >> cnt
        tmp2.bin = y_value >> cnt
        z_add = round((math.atan(2**(-cnt)) / delta) * (2**z_exp))
        # z_add = z_adds[cnt]
        if ((x_value.dec < 0) and (y_value.dec >= 0)) or ((y_value.dec < 0) and (x_value.dec >= 0)):
            x_value.dec = x_value.dec - tmp2.dec
            y_value.dec = y_value.dec + tmp1.dec
            z_value.dec = z_value.dec - z_add
        else:
            x_value.dec = x_value.dec + tmp2.dec
            y_value.dec = y_value.dec - tmp1.dec
            z_value.dec = z_value.dec + z_add
        # print(x_value.dec/(2**(exp+itr+7)))
        # print(y_value.dec/(2**(exp+itr+7)))
        # print((z_value.dec/(2**z_exp))*delta)
        # print(z_value[z_exp+9:z_exp].dec*delta)
        # print('')

    # [-pi/2, pi/2] -> [0, 2*pi)
    theta = logic(10, name='theta')
    if z_value.dec < 0:
        theta.dec = z_value[z_exp+9:z_exp].dec + 1024
    else:
        theta.dec = z_value[z_exp+9:z_exp].dec

    return theta


if __name__ == '__main__':
    # Tb
    delta_theta = 2 * math.pi / (2**10)
    delta_data = 2**(-8)
    # 1+8+8
    data = np.linspace(-256, 256 - delta_data, 2**(17))
    data_logic = logic(17, signed=1, name='data')

    theta = np.zeros(len(data), dtype=np.float32)
    theta_real = np.zeros(len(data), dtype=np.float32)

    # data_logic.dec = 10
    # print(AtanCordicFix(data_logic).dec * delta_theta)
    # print(math.atan(data_logic.dec * delta_data))

    for i in range(0, len(data)):
        data_logic.dec = round(data[i] / delta_data)
        theta[i] = AtanCordicFix(data_logic).dec
        # theta[i] = theta[i] * delta_theta
        theta_real[i] = math.atan(data[i])
        if theta_real[i] < 0:
            theta_real[i] = theta_real[i] + 2 * math.pi
        theta_real[i] = round(theta_real[i] / delta_theta)
        

    err = abs(theta_real - theta)
    # print('max err:', max(err))
    # index = np.where(err==np.max(err))[0][0]
    # print('index:', index)
    # print('data:', data[index])
    # print('data_logic:', data[index] / delta_data)
    # print('theta:', theta[index])
    # print('theta_real:', theta_real[index])

    if max(err) <= 1:
        print("Successful!, meet accuracy requirements!")
    else:
        print("Failed to meet accuracy requirements!")

    L1, = plt.plot(data, err)
    plt.legend([L1], ['atan'], loc='upper right')
    plt.show()
    

