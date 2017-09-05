clc, clear all, close all;

% self-play

% for kk = 1 : 225
%     [setGobang, scoreGobang, ii, jj] = naiveAI(setGobang, mod(kk, 2));
%     clc;
%     plotGobang(setGobang)
%     fprintf('%d, %d\n', ii, jj)
%     gg = judge(setGobang, ii, jj);
%     if gg == 1
%         break;
%     end
%     pause;
% end

% Alcor-AI

AlcorBoW = 1; % b = 1, w = 2;

%%
G = 0;
for kk2 = 1 : 100
%%


setGobang = zeros(15);
setlist = [];
clc;
plotGobang(setGobang)
for kk = 1 : 225
    if mod(kk + AlcorBoW - 1, 2) == 0
        [setGobang, scoreGobang, ii, jj] = naiveAI(setGobang, mod(AlcorBoW + 1, 2));
        setlist = [setlist; [ii, jj]];
    else
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
        
        [ii, jj] = Alcor(X);
        
        
        if setGobang(ii, jj) == 0
            setGobang(ii, jj) = (-1) ^ mod(AlcorBoW + 1, 2);
        else
            fprintf('Error!!!!\n');
        end
        setlist = [setlist; [ii, jj]];
    end
    clc;
    plotGobang(setGobang)
    fprintf('%d, %d\n', ii, jj)
    gg = judge(setGobang, ii, jj);
    if gg ~= 0
        break;
    end
    %pause;
    
end

%%
if (AlcorBoW == 1 && gg == 1) || (AlcorBoW == 2 && gg == -1)
    G = G + 1;
end
end
%%

% Human-AI

% human = 2; % b = 1, w = 2;
% for kk = 1 : 225
%     
%     if mod(kk + human - 1, 2) == 0
%         [setGobang, scoreGobang, ii, jj] = naiveAI(setGobang, mod(human + 1, 2));
%     else
%         ii = input('column = ');
%         jj = input('row = ');
%         if setGobang(ii, jj) == 0
%             setGobang(ii, jj) = (-1) ^ mod(human + 1, 2);
%         end
%     end
%     clc;
%     plotGobang(setGobang)
%     fprintf('%d, %d\n', ii, jj)
%     gg = judge(setGobang, ii, jj);
%     if gg == 1
%         break;
%     end
% end