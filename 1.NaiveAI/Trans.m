saldir = './data/';

saldir2 = './data2/';

for data_iter = 1 : 550
    data_iter
    % ×ª»»Êý¾Ý
    load([strcat(saldir, 'data_', num2str(data_iter)), '.mat'])
    X_v = [];
    y_v = [];
    XXBB = [XXBB, XXWW];
    YYBB = [YYBB, YYWW];
    for ii = 1 : length(XXBB)
        XX = XXBB{ii};
        YY = YYBB{ii};

        X = zeros(size(XX, 4), 15 * 15 * 8);
        y = zeros(size(YY, 3), 15 * 15);
        for jj = size(XX, 4) : -1 : 1
            X_s = XX(:, :, :, jj);
            X(jj, :) = X_s(:)';
            y_s = YY(:, :, jj);
            y(jj, :) = y_s(:)';
        end
        X_v = [X_v; X];
        y_v = [y_v; y];
    end
    X = X_v;
    y = y_v;
    
    
    save([strcat(saldir2, 'data_', num2str(data_iter)), '.mat'], 'X', 'y')
end