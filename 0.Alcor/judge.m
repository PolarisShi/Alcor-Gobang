function gg = judge(setGobang, ii, jj)
gg = 0;
for k1 = ii - 4 : ii
    if k1 >= 1 && k1 + 4 <= 15
        tuple = setGobang(k1 : k1 + 4, jj);
        if sum(tuple == 1) == 5
            fprintf('black win!\n');
            gg = 1;
            break;
        elseif sum(tuple == -1) == 5
            fprintf('white win!\n');
            gg = 1;
            break;
        end
    end
end
for k2 = jj - 4 : jj
    if k2 >= 1 && k2 + 4 <= 15
        tuple = setGobang(ii, k2 : k2 + 4);
        if sum(tuple == 1) == 5
            fprintf('black win!\n');
            gg = 1;
            break;
        elseif sum(tuple == -1) == 5
            fprintf('white win!\n');
            gg = 1;
            break;
        end
    end
end
for k3 = 1 : 5
    if ii + 5 - k3 - 4 >= 1 && ii + 5 - k3 <= 15 && jj - 5 + k3 >= 1 && jj - 5 + k3 + 4 <= 15
        tuple = diag(rot90(setGobang(ii + 5 - k3 - 4 : ii + 5 - k3, jj - 5 + k3 : jj - 5 + k3 + 4)));
        if sum(tuple == 1) == 5
            fprintf('black win!\n');
            gg = 1;
            break;
        elseif sum(tuple == -1) == 5
            fprintf('white win!\n');
            gg = 1;
            break;
        end
    end
end
for k4 = 1 : 5
    if ii - 5 + k4 >= 1 && ii - 5 + k4 + 4 <= 15 && jj - 5 + k4 >= 1 && jj - 5 + k4 + 4 <= 15 
        tuple = diag(setGobang(ii - 5 + k4 : ii - 5 + k4 + 4, jj - 5 + k4 : jj - 5 + k4 + 4));
        if sum(tuple == 1) == 5
            fprintf('black win!\n');
            gg = 1;
            break;
        elseif sum(tuple == -1) == 5
            fprintf('white win!\n');
            gg = 1;
            break;
        end
    end
end