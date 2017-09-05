function [setGobang, scoreGobang, ii, jj] = naiveAI(setGobang, BoW)

%BoW == 1, black
%BoW == 0, white

if BoW == 0
    setGobang = -1 * setGobang;
end

scoreGobang = scoreCalc(setGobang);

for kk = 1 : 1e12
    [ii, jj] = find(scoreGobang == max(max(scoreGobang)));
    r = unidrnd(length(ii));
    ii = ii(r);
    jj = jj(r);
    if setGobang(ii, jj) == 0
        setGobang(ii, jj) = 1;
        break;
    else
        scoreGobang(ii, jj) = 0;
    end
end

if BoW == 0
    setGobang = -1 * setGobang;
end

end