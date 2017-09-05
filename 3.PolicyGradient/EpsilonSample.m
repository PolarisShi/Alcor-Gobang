function [sample_state, sample_action, sample_reward] = EpsilonSample(stackedAETheta, lastHiddenSize, ...
                                                                      outputSize, netconfig, epsilon)

sample_state = [];
sample_action = [];
sample_reward = [];

setGobang = zeros(15);

setlist = [];

AlcorBoW = unidrnd(2); %% 需要进行随机？即unidrnd(2)

%%
for kk = 1 : 225
    if mod(kk + AlcorBoW - 1, 2) == 0
        [setGobang, scoreGobang, ii, jj] = naiveAI(setGobang, mod(AlcorBoW + 1, 2));
        setlist = [setlist; [ii, jj]];
    else
        if rand > epsilon % greedy policy
            X = setGobang2param(setGobang, setlist, AlcorBoW);
            X_flat = X(:)';
            sample_state = [sample_state; X_flat];
            [p] = stackedAEPredict(stackedAETheta, lastHiddenSize, ...
                outputSize, netconfig, X_flat);
            X_judge = X(:, :, 3);

            for k = 1 : 225
                [~, pred] = max(p, [], 1);
                if X_judge(pred(1)) == 1
                    pred = pred(1);
                    break;
                else
                    p(pred) = -10;
                end
            end

            y = zeros(15);
            y(pred) = 1;
            y = reshape(y, 15 ,15);
            [ii, jj] = find(y == 1);

            if setGobang(ii, jj) == 0
                setGobang(ii, jj) = (-1) ^ mod(AlcorBoW + 1, 2);
            else
                fprintf('Error!!!!\n');
            end
            setlist = [setlist; [ii, jj]];
            y = zeros(15);
            y(ii, jj) = 1;
            sample_action = [sample_action; y(:)'];
        else % random
            [setGobang, scoreGobang, ii, jj] = naiveAI(setGobang, mod(AlcorBoW, 2));
            X = setGobang2param(setGobang, setlist, AlcorBoW);
            X_flat = X(:)';
            sample_state = [sample_state; X_flat];
            setlist = [setlist; [ii, jj]];
            y = zeros(15);
            y(ii, jj) = 1;
            sample_action = [sample_action; y(:)'];
        end
    end
    gg = judge(setGobang, ii, jj);
    if gg ~= 0
        break;
    end
end
sample_reward = zeros(size(sample_action, 1), 1);
if gg == AlcorBoW
    sample_reward(end) = 1;
else
    sample_reward(end) = -0.000;
end