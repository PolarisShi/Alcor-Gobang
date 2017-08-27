clc, clear all, close all;
tic;

GG = {};
XXBB = {};
XXWW = {};
YYBB = {};
YYWW = {};

for iter = 1 : 100
iter
setGobang = zeros(15);


% pre-set
setlist = [];
XB = [];
YB = [];
XW = [];
YW = [];

for k = 1 : 225
    
    %BoW == 1, black
    %BoW == 0, white
    BoW = mod(k, 2);
    
    if BoW == 1
            X_bset = double(setGobang == 1);
            X_wset = double(setGobang == -1);
            X_eset = double(setGobang == 0);
    elseif BoW == 0
            X_bset = double(setGobang == -1);
            X_wset = double(setGobang == 1);
            X_eset = double(setGobang == 0);
    end
    X_turn1 = zeros(15);
    X_turn2 = zeros(15);
    X_turn3 = zeros(15);
    X_turn4 = zeros(15);
    X_turn5 = zeros(15);
    for kk = 1 : size(setlist, 1)
        if kk == 5
            X_turn5 = setGobang;
            X_turn5(setGobang == -1) = 1;
            X_turn5(setlist(end, 1), setlist(end, 2)) = 0;
            X_turn5(setlist(end - 1, 1), setlist(end - 1, 2)) = 0;
            X_turn5(setlist(end - 2, 1), setlist(end - 2, 2)) = 0;
            X_turn5(setlist(end - 3, 1), setlist(end - 3, 2)) = 0;
            break;
        elseif kk == 1
            X_turn1(setlist(end, 1), setlist(end, 2)) = 1;
        elseif kk == 2
            X_turn2(setlist(end - 1, 1), setlist(end - 1, 2)) = 1;
        elseif kk == 3
            X_turn3(setlist(end - 2, 1), setlist(end - 2, 2)) = 1;
        elseif kk == 4
            X_turn4(setlist(end - 3, 1), setlist(end - 3, 2)) = 1;
        end
    end
    x = [];
    x(:, :, 1) = X_bset;
    x(:, :, 2) = X_wset;
    x(:, :, 3) = X_eset;
    x(:, :, 4) = X_turn1;
    x(:, :, 5) = X_turn2;
    x(:, :, 6) = X_turn3;
    x(:, :, 7) = X_turn4;
    x(:, :, 8) = X_turn5;
    
    [setGobang, scoreGobang, ii, jj] = naiveAI(setGobang, BoW);
    
    y = zeros(15);
    y(ii, jj) = 1;
    
    setlist = [setlist; [ii, jj]];
    if BoW == 1
        XB = cat(4, XB, x);
        YB = cat(3, YB, y);
    elseif BoW == 0
        XW = cat(4, XW, x);
        YW = cat(3, YW, y);
    end
    %plotGobang(setGobang)
    %fprintf('%d, %d\n', ii, jj)
    gg = judge(setGobang, ii, jj);
    if gg ~= 0
        break;
    end
    %pause;
end


GG = [GG, gg];
XXBB = [XXBB, XB];
XXWW = [XXWW, XW];
YYBB = [YYBB, YB];
YYWW = [YYWW, YW];

if mod(iter, 100) == 0
    saldir = './data/';
    
    save([strcat(saldir, 'data_', num2str(iter / 100)), '.mat'], 'GG', 'XXBB', 'XXWW', 'YYBB', 'YYWW')
    GG = {};
    XXBB = {};
    XXWW = {};
    YYBB = {};
    YYWW = {};
end

end

toc;