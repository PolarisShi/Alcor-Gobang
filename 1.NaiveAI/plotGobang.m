function plotGobang(setGobang)

fprintf('   ');
for ii = 1 : 15
    if ii < 10
        fprintf('%d  ', ii);
    else
        fprintf('%d ', ii);
    end
end
fprintf('\n');

for ii = 1 : 15
    
    %fprintf('%d ', 16 - ii);
    %if ii > 16 - 10
    %    fprintf(' ');
    %end
    
    fprintf('%d ', ii);
    if ii < 10
        fprintf(' ');
    end
    
    for jj = 1 : 15
        if setGobang(ii, jj) == 0
            fprintf('+  ');
        elseif setGobang(ii, jj) == 1
            fprintf('@  ');
        elseif setGobang(ii, jj) == -1
            fprintf('O  ');
        end
    end
    fprintf('\n');
end
% fprintf('   ');
% for ii = 1 : 15
%     if ii < 10
%         fprintf('%d  ', ii);
%     else
%         fprintf('%d ', ii);
%     end
% end
% fprintf('\n');

end