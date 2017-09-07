from __future__ import print_function
from numpy import *
import numpy as np
import copy
import math
import random

def naiveAI(setGobang, BoW):
    if BoW == 0:
        setGobang = -1 * setGobang;
        pass
    scoreGobang = scoreCalc(setGobang);
    
    for kk in range(10000):
        [ii, jj] = where(scoreGobang == np.max(scoreGobang));
        r = random.randint(0, len(ii) - 1);
        ii = ii[r];
        jj = jj[r];
        if setGobang[ii, jj] == 0:
            setGobang[ii, jj] = 1;
            break
        else:
            scoreGobang[ii, jj] = 0;
            pass
        pass
    if BoW == 0:
        setGobang = -1 * setGobang;
        pass
    return setGobang, scoreGobang, ii, jj

def scoreCalc(setGobang):
    scoreGobang = zeros([15, 15]);
    for ii in range(15):
        for jj in range(15):
            # x axis
            for k1 in range(ii - 4, ii + 1):
                if k1 < 0 or k1 + 4 > 14:
                    scoreGobang[ii, jj] = scoreGobang[ii, jj] + 0;
                    pass
                else:
                    Tuple = setGobang[range(k1, k1 + 4 + 1), jj];
                    scoreGobang[ii, jj] = scoreGobang[ii, jj] + scoreTable(Tuple);
                    pass
                pass
            # y axis
            for k2 in range(jj - 4, jj + 1):
                if k2 < 0 or k2 + 4 > 14:
                    scoreGobang[ii, jj] = scoreGobang[ii, jj] + 0;
                    pass
                else:
                    Tuple = setGobang[ii, range(k2, k2 + 4 + 1)];
                    scoreGobang[ii, jj] = scoreGobang[ii, jj] + scoreTable(Tuple);
                    pass
                pass
            # y = -x
            for k3 in range(1, 6):
                if (ii + 5 - k3 - 4 < 0) or (ii + 5 - k3 > 14) or (jj - 5 + k3 < 0) or (jj - 5 + k3 + 4 > 14):
                    scoreGobang[ii, jj] = scoreGobang[ii, jj] + 0;
                    pass
                else:
                    rot_setGobang = np.rot90(setGobang);
                    ss1 = setGobang[range(ii + 5 - k3 - 4, ii + 5 - k3 + 1), :];
                    ss2 = ss1[:, range(jj - 5 + k3, jj - 5 + k3 + 4 + 1)];
                    rot_s = np.rot90(ss2);
                    Tuple = rot_s[range(5), range(5)];
                    scoreGobang[ii, jj] = scoreGobang[ii, jj] + scoreTable(Tuple);
                    pass
                pass
            # y = x
            for k4 in range(1, 6):
                if (ii - 5 + k4 < 0) or (ii - 5 + k4 + 4 > 14) or (jj - 5 + k4 < 0) or (jj - 5 + k4 + 4 > 14):
                    scoreGobang[ii, jj] = scoreGobang[ii, jj] + 0;
                    pass
                else:
                    Tuple = setGobang[range(ii - 5 + k4, ii - 5 + k4 + 4 + 1), range(jj - 5 + k4, jj - 5 + k4 + 4 + 1)];
                    scoreGobang[ii, jj] = scoreGobang[ii, jj] + scoreTable(Tuple);
                    pass
                pass
            pass
        pass
    return scoreGobang
    
def scoreTable(Tuple):
    scoreTableSet = double([7, 35, 800, 15000, 800000, 15, 400, 6000, 100000, 0, 0]);
    if sum(Tuple == 0) == 5:
        score = scoreTableSet[0];
    elif sum(Tuple == 1) == 1 and sum(Tuple == -1) == 0:
        score = scoreTableSet[1];
    elif sum(Tuple == 1) == 2 and sum(Tuple == -1) == 0:
        score = scoreTableSet[2];
    elif sum(Tuple == 1) == 3 and sum(Tuple == -1) == 0:
        score = scoreTableSet[3];
    elif sum(Tuple == 1) == 4 and sum(Tuple == -1) == 0:
        score = scoreTableSet[4];
    elif sum(Tuple == 1) == 0 and sum(Tuple == -1) == 1:
        score = scoreTableSet[5];
    elif sum(Tuple == 1) == 0 and sum(Tuple == -1) == 2:
        score = scoreTableSet[6];
    elif sum(Tuple == 1) == 0 and sum(Tuple == -1) == 3:
        score = scoreTableSet[7];
    elif sum(Tuple == 1) == 0 and sum(Tuple == -1) == 4:
        score = scoreTableSet[8];
    elif sum(Tuple == 1) > 0 and sum(Tuple == -1) > 0:
        score = scoreTableSet[9];
        pass
    return score

def judge(setGobang, ii, jj):
    gg = 0;
    for k1 in range(ii - 4, ii + 1):
        if k1 >= 0 and k1 + 4 <= 14:
            Tuple = setGobang[range(k1, k1 + 4 + 1), jj];
            if sum(Tuple == 1) == 5:
                gg = 1;
                break
            elif sum(Tuple == -1) == 5:
                gg = -1;
                break
            pass
        pass
    for k2 in range(jj - 4, jj + 1):
        if k2 >= 0 and k2 + 4 <= 14:
            Tuple = setGobang[ii, range(k2, k2 + 4 + 1)];
            if sum(Tuple == 1) == 5:
                gg = 1;
                break
            elif sum(Tuple == -1) == 5:
                gg = -1;
                break
            pass
        pass
    for k3 in range(1, 6):
        if (ii + 5 - k3 - 4 >= 0) and (ii + 5 - k3 <= 14) and (jj - 5 + k3 >= 0) and (jj - 5 + k3 + 4 <= 14):
            rot_setGobang = np.rot90(setGobang);
            ss1 = setGobang[range(ii + 5 - k3 - 4, ii + 5 - k3 + 1), :];
            ss2 = ss1[:, range(jj - 5 + k3, jj - 5 + k3 + 4 + 1)];
            rot_s = np.rot90(ss2);
            Tuple = rot_s[range(5), range(5)];
            if sum(Tuple == 1) == 5:
                gg = 1;
                break
            elif sum(Tuple == -1) == 5:
                gg = -1;
                break
            pass
        pass
    for k4 in range(1, 6):
        if (ii - 5 + k4 >= 0) and (ii - 5 + k4 + 4 <= 14) and (jj - 5 + k4 >= 0) and (jj - 5 + k4 + 4 <= 14):
            Tuple = setGobang[range(ii - 5 + k4, ii - 5 + k4 + 4 + 1), range(jj - 5 + k4, jj - 5 + k4 + 4 + 1)];
            if sum(Tuple == 1) == 5:
                gg = 1;
                break
            elif sum(Tuple == -1) == 5:
                gg = -1;
                break
            pass
        pass
    return gg


def plotGobang(setGobang):

    for t in range(60):
        print('')
        pass
    
    
    for ii in range(15):
        print(15 - ii, '', end = '');
        if ii > 5:
            print(' ', end = '');
            pass

        for jj in range(15):
            if setGobang[ii, jj] == 0:
                print('+ ', end = '');
                pass
            elif setGobang[ii, jj] == 1:
                print('@ ', end = '');
                pass
            elif setGobang[ii, jj] == -1:
                print('O ', end = '');
                pass
            pass
        print('')
        pass
    
    print('   ', end = '');
    for ii in range(15):
        if ii < 9:
            print(ii + 1, '', end = '');
            pass
        else:
            print(ii + 1, end = '');
            pass
        pass
    print('')

    






