figure;  % Create a single figure for all iterations

for i = 1:7
    x = data_raw{i}{2}.Values.Time;
    y1 = data_fit{i}{1}.Values.Data;
    y2 = data_raw{i}{2}.Values.Data;
    
    disp(['Processing iteration ', num2str(i)]);

    squared_diff = (y2 - y1).^2;
    MSE = mean(squared_diff);
    RMSE = sqrt(MSE);
    NRMSE = RMSE / (max(y1) - min(y1));
    disp(['Iteration ', num2str(i), ' - Normalized RMSE: ', num2str(NRMSE)]);

    r = corr(y1(:), y2(:));
    disp(['Iteration ', num2str(i), ' - Pearson Correlation Coefficient: ', num2str(r)]);

    % [d, ix, iy] = dtw(y1, y2);
    % disp(['Iteration ', num2str(i), ' - DTW Distance: ', num2str(d)]);
    % 
    % cv = cvpartition(length(x), 'HoldOut', 0.2);
    % trainIdx = training(cv);
    % testIdx = test(cv);
    % 
    % x_train = x(trainIdx);
    % y_train = y1(trainIdx);
    % x_test = x(testIdx);
    % y_test = y1(testIdx);
    % 
    % p = polyfit(x_train, y_train, 3);
    % y_pred = polyval(p, x_test);
    % RMSE_test = sqrt(mean((y_test - y_pred).^2));
    % disp(['Iteration ', num2str(i), ' - Cross-Validation Test RMSE: ', num2str(RMSE_test)]);

    % Plot y1 and y2 vs x in subplots
    subplot(2, 4, i);  % Create 2x4 grid and plot in each subplot
    plot(x, y1, 'b', 'DisplayName', 'y1 (Time)'); hold on;
    plot(x, y2, 'r', 'DisplayName', 'y2 (Data 2)');
    title(['Iteration ', num2str(i), ' - y1 and y2 vs x']);
    xlabel('x');
    ylabel('y');
    legend('show');
    grid on;
end
