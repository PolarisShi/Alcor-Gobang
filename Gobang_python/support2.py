from numpy import *
import numpy as np
import copy
import math


def Alcor(X, stackedAETheta, netconfig, outputSize):

    
    X_flat = np.ndarray.flatten(X[0].T);
    for ii in range(1, 8):
        X_flat = np.hstack((X_flat, np.ndarray.flatten(X[ii].T)));
        pass
    p = stackedAEPredict(stackedAETheta, outputSize, netconfig, X_flat);
    X_judge = X[2];
    for k in range(225):
        M = np.max(p);
        pred = np.where(p == M);
        pred = int(pred[0]);
        xlabel = (pred + 1) % 15 - 1;
        ylabel = (pred + 1) / 15;
        if X_judge[xlabel, ylabel] == 1:
            break;
        else:
            p[pred] = -10;
            pass
        pass
    ii = xlabel;
    jj = ylabel;
    return ii, jj

def sigmoid(z):
    g = copy.deepcopy(z)
    g[np.where(g <= 0)] = 0
    return g
    pass

def params2stack(params, netconfig):
    depth = shape(netconfig)[0] - 1
    stackw = []
    stackb = []
    for ii in range(depth):
        stackw.extend([0])
        stackb.extend([0])
        pass
    prevLayerSize = netconfig[0]
    curPos = 0
    for d in range(depth):
        wlen = (netconfig[d + 1] * prevLayerSize)
        stackw[d] = copy.deepcopy(params[curPos : curPos + wlen])
        stackw[d].shape = (prevLayerSize, netconfig[d + 1])
        stackw[d] = stackw[d].T
        curPos = curPos+wlen

        blen = (netconfig[d + 1])
        stackb[d] = copy.deepcopy(params[curPos : curPos + blen])
        curPos = curPos+blen

        prevLayerSize = netconfig[d + 1]
        pass
    return stackw, stackb
    pass

def stackedAEPredict(theta, outputSize, netconfig, X):
    hiddenSize = netconfig[-1]
    theta = theta.T;
    softmaxTheta = copy.deepcopy(theta[0 : hiddenSize * outputSize])
    softmaxTheta.shape = (hiddenSize, outputSize)
    softmaxTheta = softmaxTheta.T
    
    stackw, stackb = params2stack(theta[hiddenSize * outputSize : len(theta)], netconfig)
    depth = len(stackw)
    z = []
    a = []
    z.extend([0])
    a.extend([0])
    a[0] = copy.deepcopy(X)
    for d in range(depth):
        z.extend([0])
        a.extend([0])
        z[d + 1] = np.dot(a[d], stackw[d].T ) + stackb[d].T
        a[d + 1] = sigmoid(z[d + 1])
        pass
    p = dot(a[depth], softmaxTheta.T)
    
    return p
    pass

