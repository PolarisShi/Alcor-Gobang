function scoreGobang = scoreCalc(setGobang)

scoreGobang = zeros(15);
for ii = 1 : 15
    for jj = 1 : 15
        % x axis
        for k1 = ii - 4 : ii
            if k1 < 1 || k1 + 4 > 15
                scoreGobang(ii, jj) = scoreGobang(ii, jj) + 0;
            else
                tuple = setGobang(k1 : k1 + 4, jj);
                scoreGobang(ii, jj) = scoreGobang(ii, jj) + scoreTable(tuple(:));
            end
        end
        % y axis
        for k2 = jj - 4 : jj
            if k2 < 1 || k2 + 4 > 15
                scoreGobang(ii, jj) = scoreGobang(ii, jj) + 0;
            else
                tuple = setGobang(ii, k2 : k2 + 4);
                scoreGobang(ii, jj) = scoreGobang(ii, jj) + scoreTable(tuple(:));
            end
        end
        % y = -x
        for k3 = 1 : 5
           if ii + 5 - k3 - 4 < 1 || ii + 5 - k3 > 15 || jj - 5 + k3 < 1 || jj - 5 + k3 + 4 > 15
               scoreGobang(ii, jj) = scoreGobang(ii, jj) + 0;
           else
               tuple = diag(rot90(setGobang(ii + 5 - k3 - 4 : ii + 5 - k3, jj - 5 + k3 : jj - 5 + k3 + 4)));
               scoreGobang(ii, jj) = scoreGobang(ii, jj) + scoreTable(tuple(:));
           end
        end
        % y = x
        for k4 = 1 : 5
            if ii - 5 + k4 < 1 || ii - 5 + k4 + 4 > 15 || jj - 5 + k4 < 1 || jj - 5 + k4 + 4 > 15 
                scoreGobang(ii, jj) = scoreGobang(ii, jj) + 0;
            else
                tuple = diag(setGobang(ii - 5 + k4 : ii - 5 + k4 + 4, jj - 5 + k4 : jj - 5 + k4 + 4));
                scoreGobang(ii, jj) = scoreGobang(ii, jj) + scoreTable(tuple(:));
            end
        end
        
    end
end

end