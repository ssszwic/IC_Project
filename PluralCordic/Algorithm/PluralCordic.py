from VerilogTools import logic
import matplotlib
matplotlib.use('TkAgg')
import matplotlib.pyplot as plt
import math
import numpy as np


def PluralCordic(re, im):
    itr = 12
    x = re
    y = im
    z = 0

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
        # print(x)
        # print(y)
        # print(z)
        # print('')

    km = 0.60725293501
    amplitude = abs(x * km)

    # theta = z
    if x == 0 and y == 0:
        theta = 0
    else:
        theta = z

    return amplitude, theta


def PluralCordicFix(re, im):
    # re: 1+3+5
    # im: 1+3+5
    # amplitude: 0+4+5
    # tehta: 1+9+0
    itr = 10
    exp = -1      # x, y extra bit
    z_exp = 4       # z extra bit
    km_exp = 9
    # x.y: 1+5+(5+itr-1+exp)=19
    x_value = logic(itr + exp + 10, signed=1, name='x')
    y_value = logic(itr + exp + 10, signed=1, name='y')
    # z: 1+9+z_exp=14
    z_value = logic(10 + z_exp, signed=1, name='z')

    x_value.bin = 2 * re[8].bin + re.bin + (itr-1+exp) * '0'
    y_value.bin = 2 * im[8].bin + im.bin + (itr-1+exp) * '0'
    z_value.dec = 0

    # print(x_value)
    # print(y_value)
    # print(z_value)
    # print("")
    delta = 2 * math.pi / (2**10)

    # z_adds
    z_adds = [2048, 1209, 639, 324, 163, 81, 41, 20, 10, 5]


    # 1+5+(5+itr-1+exp)=19
    tmp1 = logic(itr + exp + 10, signed=1, name='tmp1')
    tmp2 = logic(itr + exp + 10, signed=1, name='tmp2')
    for cnt in range(0, itr):
        # right shift cnt bit
        tmp1.bin = x_value >> cnt
        tmp2.bin = y_value >> cnt
        # z_add = round((math.atan(2**(-cnt)) / delta) * (2**z_exp))
        z_add = z_adds[cnt]
        if ((x_value.dec < 0) and (y_value.dec >= 0)) or ((y_value.dec < 0) and (x_value.dec >= 0)):
            x_value.dec = x_value.dec - tmp2.dec
            y_value.dec = y_value.dec + tmp1.dec
            z_value.dec = z_value.dec - z_add
        else:
            x_value.dec = x_value.dec + tmp2.dec
            y_value.dec = y_value.dec - tmp1.dec
            z_value.dec = z_value.dec + z_add
        # print(x_value)
        # print(y_value)
        # print(z_value)
        # print(x_value.dec/(2**(5+itr-1+exp)))
        # print(y_value.dec/(2**(5+itr-1+exp)))
        # print((z_value.dec/(2**z_exp))*delta)
        # print('')
    # print('')

    # amplitude: 0+4+5
    # theta: 1+9+0
    amplitude = logic(9, name='amplitude')
    theta = logic(10, signed=1, name='theta')
    
    # abs
    # 0+5+(5+itr-1+exp)=18
    x_abs = logic(itr + exp + 9, name='x_abs')
    if x_value.dec < 0:
        x_abs.dec = -x_value.dec
    else:
        x_abs.dec = x_value.dec
    # multi km
    # 0+0+km_exp=9
    km = logic(km_exp, name='km')
    km.dec = 311
    # 0+4+(km_exp + 5+itr-1+exp)=26
    amplitude_km = logic(km_exp + itr + exp + 8, name='amplitude_km')
    amplitude_km.dec = km.dec * x_abs.dec
    # round
    # 0+4+6
    amplitude_rd = logic(10, name='amplitude_rd')
    amplitude_rd.dec = amplitude_km[km_exp+itr+exp+7:km_exp+itr+exp-2].dec + 1
    amplitude.dec = amplitude_rd[9:1].dec

    # 1+9+z_exp
    # special case: x=0, y=0
    # 1+9+z_exp=14
    theta_tmp = logic(1+9+z_exp, signed=1, name='theta_tmp')
    if x_value.dec == 0 and y_value.dec == 0:
        theta_tmp.dec = 0
    else:
        theta_tmp.dec = z_value.dec
 
    # round
    # 1+9+1=11
    theta_rd = logic(11, signed=1, name='theta_rd')
    theta_rd.dec = theta_tmp[9+z_exp:z_exp-1].dec + 1
    theta.dec = theta_rd[10:1].dec

    return amplitude, theta


if __name__ == '__main__':
    # Tb
    # re: 1+3+5
    # im: 1+3+5
    # amplitude: 0+4+5
    # tehta: 1+9+0
    delta_theta = 2 * math.pi / (2**10)
    delta_data = 2**(-5)

    res = np.linspace(-8, 8 - delta_data, 2**(9))
    ims = np.linspace(-8, 8 - delta_data, 2**(9))

    ampli = np.zeros(len(res) * len(ims), dtype=np.float32)
    ampli_real = np.zeros(len(res) * len(ims), dtype=np.float32)

    theta = np.zeros(len(res) * len(ims), dtype=np.float32)
    theta_real = np.zeros(len(res) * len(ims), dtype=np.float32)
    # amplia, thetaa = PluralCordic(1, 1)
    # print(amplia)
    re = logic(9, signed=1, name='re')
    im = logic(9, signed=1, name='im')

    # re.dec = int(res[0]/delta_data)
    # im.dec = int(ims[256]/delta_data)
    # print('re:', res[0])
    # print('im:', ims[256])
    # ampli_logic, theta_logic = PluralCordicFix(re, im)
    # print(ampli_logic.dec * delta_data)
    # print(theta_logic.dec * delta_theta)

    re.dec = int(res[0]/delta_data)
    im.dec = int(ims[0]/delta_data)
    ampli_logic, theta_logic = PluralCordicFix(re, im)

    h = 0
    for i in range(0, len(res)):
        for j in range(0, len(ims)):
            re.dec = int(res[i]/delta_data)
            im.dec = int(ims[j]/delta_data)
            ampli_logic, theta_logic = PluralCordicFix(re, im)
            ampli[h] = ampli_logic.dec * delta_data
            theta[h] = theta_logic.dec * delta_theta

            ampli_real[h] = math.sqrt(res[i]**2 + ims[j]**2)
            if res[i] == 0:
                if ims[j] > 0:
                    theta_real[h] = math.pi/2
                elif ims[j] < 0:
                    theta_real[h] = -math.pi/2
                else:
                    theta_real[h] = 0
            else:
                theta_real[h] = math.atan(ims[j]/res[i])
            h = h + 1
        

    err_ampli = abs(ampli_real - ampli)
    err_theta = abs(theta_real - theta)
    print('Requirement Error:', 2**(-5))
    print('ampli max err:', max(err_ampli))
    if max(err_ampli) < 2**(-5):
        print("Successful!, meet accuracy requirements!")
    else:
        print("Failed to meet accuracy requirements!")
    print('')

    print('Requirement Error:', delta_theta)
    print('theta max err:', max(err_theta))
    if max(err_theta) < delta_theta:
        print("Successful!, meet accuracy requirements!")
    else:
        print("Failed to meet accuracy requirements!")
    print('')

    plt.subplot(1,2,1)
    plt.plot(err_ampli)
    plt.title('ampli err')
    plt.subplot(1,2,2)
    plt.plot(err_theta)
    plt.title('theta err')

    plt.show()
    

