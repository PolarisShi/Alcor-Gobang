clc, clear all, close all;


setGobang = zeros(15);


clc;
plotGobang(setGobang)

% self-play
for kk = 1 : 225
    [setGobang, scoreGobang, ii, jj] = naiveAI(setGobang, mod(kk, 2));
    clc;
    plotGobang(setGobang)
    fprintf('%d, %d\n', ii, jj)
    gg = judge(setGobang, ii, jj);
    if gg == 1
        break;
    end
    pause;
end
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