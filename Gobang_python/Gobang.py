# Initialization
from __future__ import print_function
from numpy import *
import numpy as np
import copy
import math
import support
import support2
import pickle

AlcorBoW = 2;

setGobang = np.zeros([15, 15]);
setlist = [];
if AlcorBoW == 1:
    Theta = open('stackedAEThetaBlack.pkl', 'rb')
    #Theta = open('/storage/emulated/0/qpython/work/Gobang/stackedAEThetaBlack.pkl', 'rb')
    pass
elif AlcorBoW == 2:
    Theta = open('stackedAEThetaWhite.pkl', 'rb')
    #Theta = open('/storage/emulated/0/qpython/work/Gobang/stackedAEThetaWhite.pkl', 'rb')
    pass
stackedAETheta = pickle.load(Theta);
netconfig = [1800, 500, 500, 300];
outputSize = 225;


for kk in range(225):
    if (kk + AlcorBoW) % 2 == 0:
        setGobang, scoreGobang, ii, jj = support.naiveAI(setGobang, mod(AlcorBoW + 1, 2));
        setlist.extend([0]);
        setlist[kk] = [[ii], [jj]];
        pass
    else:
        if AlcorBoW == 1:
            X_bset = double(setGobang == 1);
            X_wset = double(setGobang == -1);
            X_eset = double(setGobang == 0);
            pass
        elif AlcorBoW == 2:
            X_bset = double(setGobang == -1);
            X_wset = double(setGobang == 1);
            X_eset = double(setGobang == 0);
            pass
        X_turn1 = np.zeros([15, 15]);
        X_turn2 = np.zeros([15, 15]);
        X_turn3 = np.zeros([15, 15]);
        X_turn4 = np.zeros([15, 15]);
        X_turn5 = np.zeros([15, 15]);
        for kk2 in range(len(setlist)):
            if kk2 == 4:
                X_turn5 = copy.deepcopy(setGobang);
                X_turn5[setGobang == -1] = 1;
                X_turn5[setlist[-1][0], setlist[-1][1]] = 0;
                X_turn5[setlist[-2][0], setlist[-2][1]] = 0;
                X_turn5[setlist[-3][0], setlist[-3][1]] = 0;
                X_turn5[setlist[-4][0], setlist[-4][1]] = 0;
                break
                pass
            elif kk2 == 0:
                X_turn1[setlist[-1][0], setlist[-1][1]] = 1;
                pass
            elif kk2 == 1:
                X_turn2[setlist[-2][0], setlist[-2][1]] = 1;
                pass
            elif kk2 == 2:
                X_turn3[setlist[-3][0], setlist[-3][1]] = 1;
                pass
            elif kk2 == 3:
                X_turn4[setlist[-4][0], setlist[-4][1]] = 1;
                pass
            pass
        X = [];
        X.extend([X_bset]);
        X.extend([X_wset]);
        X.extend([X_eset]);
        X.extend([X_turn1]);
        X.extend([X_turn2]);
        X.extend([X_turn3]);
        X.extend([X_turn4]);
        X.extend([X_turn5]);
        ii, jj = support2.Alcor(X, stackedAETheta, netconfig, outputSize);
        if setGobang[ii, jj] == 0:
            setGobang[ii, jj] = pow(-1, (AlcorBoW + 1) % 2);
            pass
        else:
            print("ERROR!!!")
            pass
        setlist.extend([0]);
        setlist[kk] = [[ii], [jj]];
        pass
    support.plotGobang(setGobang);
    gg = support.judge(setGobang, ii, jj);
    if gg == 1:
        print('Black Win!!')
        break
    elif gg == -1:
        print('White Win!!')
        break
    pass


