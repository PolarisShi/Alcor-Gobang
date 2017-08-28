function score = scoreTable(tuple)

% blank, b, bb, bbb, bbbb, w, ww, www, wwww, bw, null (if ai uses b)
scoreTableSet = [7, 35, 800, 15000, 800000, 15, 400, 6000, 100000, 0, 0];

if sum(tuple == 0) == 5
    score = scoreTableSet(1);
elseif sum(tuple == 1) == 1 && sum(tuple == -1) == 0
    score = scoreTableSet(2);
elseif sum(tuple == 1) == 2 && sum(tuple == -1) == 0
    score = scoreTableSet(3);
elseif sum(tuple == 1) == 3 && sum(tuple == -1) == 0
    score = scoreTableSet(4);
elseif sum(tuple == 1) == 4 && sum(tuple == -1) == 0
    score = scoreTableSet(5);
elseif sum(tuple == 1) == 0 && sum(tuple == -1) == 1
    score = scoreTableSet(6);
elseif sum(tuple == 1) == 0 && sum(tuple == -1) == 2
    score = scoreTableSet(7);
elseif sum(tuple == 1) == 0 && sum(tuple == -1) == 3
    score = scoreTableSet(8);
elseif sum(tuple == 1) == 0 && sum(tuple == -1) == 4
    score = scoreTableSet(9);
elseif sum(tuple == 1) > 0 && sum(tuple == -1) > 0
    score = scoreTableSet(10);
    
end

end