function X = setGobang2param(setGobang, setlist, AlcorBoW)

if AlcorBoW == 1
    X_bset = double(setGobang == 1);
    X_wset = double(setGobang == -1);
    X_eset = double(setGobang == 0);
elseif AlcorBoW == 2
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
X(:, :, 1) = X_bset;
X(:, :, 2) = X_wset;
X(:, :, 3) = X_eset;
X(:, :, 4) = X_turn1;
X(:, :, 5) = X_turn2;
X(:, :, 6) = X_turn3;
X(:, :, 7) = X_turn4;
X(:, :, 8) = X_turn5;

end

