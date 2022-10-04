from VerilogTools import logic
import matplotlib
matplotlib.use('TkAgg')
import matplotlib.pyplot as plt
import math
import numpy as np


def SinCosCordic(theta):
    # theta: [0, 2*pi]

    # limit theta range [0, math.pi/2]
    if theta > 1.5 * math.pi:
        # quadrant 4
        theta_new = 2 * math.pi - theta
    elif theta > math.pi:
        # quadrant 3
        theta_new = theta - math.pi
    elif theta > math.pi / 2:
        # quadrant 2
        theta_new = math.pi - theta
    else:
        # quadrant 1
        theta_new = theta

    km = 0.60725293501

    x = km
    y = 0
    z = theta_new

    itr = 12

    for cnt in range(0, itr):
        tmp1 = x * (2**(-cnt))
        tmp2 = y * (2**(-cnt))
        if z > 0:
            x = x - tmp2
            y = y + tmp1
            z = z - math.atan(2**(-cnt))
        else:
            x = x + tmp2
            y = y - tmp1
            z = z + math.atan(2**(-cnt))
        print(x)
        print(y)


    # reduction quadrant
    if theta > 1.5 * math.pi:
        # quadrant 4
        sin, cos = -y, x
    elif theta > math.pi:
        # quadrant 3
        sin, cos = -y, -x
    elif theta > math.pi / 2:
        # quadrant 2
        sin, cos = y, -x
    else:
        # quadrant 1
        sin, cos = y, x

    return sin, cos


def SinCosCordicFix(theta):
    # theta: 10bit 0+0+10
    # return: 12bit 1+0+11
    # [0,2*pi) mapping [0, 2^10)
    # z extra bit
    itr = 18
    z_exp = 12
    # x, y extra bit
    exp = 3
    # z: 1+10+z_exp
    z_value = logic(11 + z_exp, signed=1, name='z')
    quadrand = logic(2, name='quadrand')
    if theta.dec > 768:
        # quadrand 4
        z_value.dec = 1024 - theta.dec
        quadrand.dec = 0
    elif theta.dec > 512:
        # quadrand 3
        z_value.dec = theta.dec - 512
        quadrand.dec = 1
    elif theta.dec > 256:
        # quadrand 2
        z_value.dec = 512 - theta.dec
        quadrand.dec = 2
    else:
        # quadrand 1
        z_value.dec = theta.dec
        quadrand.dec = 3
    # left shift z_exp
    z_value.bin = z_value[9:0].bin + z_exp * '0'


    # mapping
    delta = 2 * math.pi / (2**10)

    # 1+1+(itr - 1 + exp)
    x_value = logic(1 + itr + exp, signed=1, name='x')
    y_value = logic(1 + itr + exp, signed=1, name='y')
    # km fix point
    km = round(0.60725293501 * (2**(itr - 1 + exp)))
    x_value.dec = km
    y_value.dec = 0

    # 1+1+(itr - 1 + exp)
    tmp1 = logic(1 + itr + exp, signed=1, name='tmp1')
    tmp2 = logic(1 + itr + exp, signed=1, name='tmp2')
    for cnt in range(0, itr):
        # right shift cnt bit
        tmp1.bin = x_value >> cnt
        tmp2.bin = y_value >> cnt
        z_add = round((math.atan(2**(-cnt)) / delta) * (2**z_exp))
        if z_value.dec > 0:
            x_value.dec = x_value.dec - tmp2.dec
            y_value.dec = y_value.dec + tmp1.dec
            z_value.dec = z_value.dec - z_add
        else:
            x_value.dec = x_value.dec + tmp2.dec
            y_value.dec = y_value.dec - tmp1.dec
            z_value.dec = z_value.dec + z_add
        # print('x: ', x_value.dec/(2**(itr - 1 + exp)))
        # print('y: ', y_value.dec/(2**(itr - 1 + exp)))
        

    # deduction quadrant
    # sin 1+1+11
    sin = logic(13, signed=1, name='sin')
    cos = logic(13, signed=1, name='cos')
    if quadrand.dec == 0:
        sin.dec = -y_value[itr + exp:itr + exp - 12].dec
        cos.dec = x_value[itr + exp:itr + exp - 12].dec
    elif quadrand.dec == 1:
        sin.dec = -y_value[itr + exp:itr + exp - 12].dec
        cos.dec = -x_value[itr + exp:itr + exp - 12].dec
    elif quadrand.dec == 2:
        sin.dec = y_value[itr + exp:itr + exp - 12].dec
        cos.dec = -x_value[itr + exp:itr + exp - 12].dec
    else:
        sin.dec = y_value[itr + exp:itr + exp - 12].dec
        cos.dec = x_value[itr + exp:itr + exp - 12].dec

    return sin, cos


if __name__ == '__main__':
    # Tb
    delta = 2 * math.pi / (2**10)
    theta = np.linspace(0, 2 * math.pi - delta, 2**10)

    sin = np.zeros(len(theta), dtype=np.float32)
    cos = np.zeros(len(theta), dtype=np.float32)
    sin_real = np.zeros(len(theta), dtype=np.float32)
    cos_real = np.zeros(len(theta), dtype=np.float32)

    theta_logic = logic(10, name='theta_logic')
    sin_logic = logic(13, signed=1, name='sin_logic')
    cos_logic = logic(13, signed=1, name='cos_logic')

    theta_logic.dec = 0
    sin_logic, cos_logic = SinCosCordicFix(theta_logic)

    for i in range(len(theta)):
        theta_logic.dec = i
        sin_logic, cos_logic = SinCosCordicFix(theta_logic)
        sin[i] = sin_logic.dec / (2**(11))
        cos[i] = cos_logic.dec / (2**(11))
        sin_real[i] = math.sin(theta[i])
        cos_real[i] = math.cos(theta[i])

    err_sin = abs(sin_real - sin)
    err_cos = abs(cos_real - cos)
    print('sin max err:', max(err_sin))
    print('cos max err:', max(err_cos))

    if max(max(err_sin), max(err_sin)) <= 2**(-11):
        print("Successful!, meet accuracy requirements!")
    else:
        print("Failed to meet accuracy requirements!")

    L1, = plt.plot(theta, err_sin)
    L2, = plt.plot(theta, err_cos)
    plt.legend([L1, L2], ['sin', 'cos'], loc='upper right')
    plt.show()
    