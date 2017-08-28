clc, clear all, close all;
tic;
for iter = 1 : 16500
iter
setGobang = zeros(15);


% pre-set
setlist = [];
if rand < 0.3
    randSteps = unidrnd(6);
else
    randSteps = 0;
end
r = 1;
while r <= randSteps
    ii = unidrnd(15);
    jj = unidrnd(15);
    if setGobang(ii, jj) == 0
        setGobang(ii, jj) = (-1) ^ (mod(r, 2) + 1);
        setlist = [setlist; [ii, jj]];
    else
        r = r - 1;
    end
    r = r + 1;
end


for k = 1 : unidrnd(35)
    
    %BoW == 1, black
    %BoW == 0, white
    BoW = mod(k + randSteps, 2);
    
    [setGobang, scoreGobang, ii, jj] = naiveAI(setGobang, BoW);
    
    setlist = [setlist; [ii, jj]];
    
    %plotGobang(setGobang)
    %fprintf('%d, %d\n', ii, jj)
    gg = judge(setGobang, ii, jj);
    if gg == 1
        break;
    end
    %pause;
end

if gg ~= 1
% construct X
if mod(k + randSteps + 1, 2) == 1
    X_bset = double(setGobang == 1);
    X_wset = double(setGobang == -1);
    X_eset = double(setGobang == 0);
elseif mod(k + randSteps + 1, 2) == 0
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

[~, scoreGobang, yi, yj] = naiveAI(setGobang, mod(k + randSteps + 1, 2));
X_score = scoreGobang ./ max(max(scoreGobang));

X_adam1(:, :, 1) = X_bset;
X_adam1(:, :, 2) = X_wset;
X_adam1(:, :, 3) = X_eset;
X_adam1(:, :, 4) = X_turn1;
X_adam1(:, :, 5) = X_turn2;
X_adam1(:, :, 6) = X_turn3;
X_adam1(:, :, 7) = X_turn4;
X_adam1(:, :, 8) = X_turn5;
X_adam1(:, :, 9) = X_score;


for kkk = 1 : 9
    X_adam2(:, :, kkk) = rot90(X_adam1(:, :, kkk), 1);
    X_adam3(:, :, kkk) = rot90(X_adam1(:, :, kkk), 2);
    X_adam4(:, :, kkk) = rot90(X_adam1(:, :, kkk), 3);
    X_adam5(:, :, kkk) = flipdim(X_adam1(:, :, kkk), 2);
    X_adam6(:, :, kkk) = flipdim(X_adam2(:, :, kkk), 2);
    X_adam7(:, :, kkk) = flipdim(X_adam3(:, :, kkk), 2);
    X_adam8(:, :, kkk) = flipdim(X_adam4(:, :, kkk), 2);
    
end

x(:, :, :, 1) = X_adam1;
x(:, :, :, 2) = X_adam2;
x(:, :, :, 3) = X_adam3;
x(:, :, :, 4) = X_adam4;
x(:, :, :, 5) = X_adam5;
x(:, :, :, 6) = X_adam6;
x(:, :, :, 7) = X_adam7;
x(:, :, :, 8) = X_adam8;

yy = zeros(15);
yy(yi, yj) = 1;
for kkk = 1 : 8
    y(:, :, kkk) = yy;
end


% save data
if iter <= 1500
    load data1

    X = cat(4, X, x);
    Y = cat(3, Y, y);
    save data1 X Y
elseif iter <=3000
    load data2

    X = cat(4, X, x);
    Y = cat(3, Y, y);
    save data2 X Y
elseif iter <=4500
    load data3

    X = cat(4, X, x);
    Y = cat(3, Y, y);
    save data3 X Y
elseif iter <=6000
    load data4

    X = cat(4, X, x);
    Y = cat(3, Y, y);
    save data4 X Y
elseif iter <=7500
    load data5

    X = cat(4, X, x);
    Y = cat(3, Y, y);
    save data5 X Y
elseif iter <=9000
    load data6

    X = cat(4, X, x);
    Y = cat(3, Y, y);
    save data6 X Y
elseif iter <=10500
    load data7

    X = cat(4, X, x);
    Y = cat(3, Y, y);
    save data7 X Y
elseif iter <= 12000
    load data8

    X = cat(4, X, x);
    Y = cat(3, Y, y);
    save data8 X Y
elseif iter <= 13500
    load data9

    X = cat(4, X, x);
    Y = cat(3, Y, y);
    save data9 X Y
elseif iter <= 15000
    load data10

    X = cat(4, X, x);
    Y = cat(3, Y, y);
    save data10 X Y
elseif iter <= 16500
    load data11

    X = cat(4, X, x);
    Y = cat(3, Y, y);
    save data11 X Y
end

end

end
toc;