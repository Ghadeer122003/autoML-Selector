% Define the scenarios and execution times (in seconds)
scenarios = {'Without Geo Optimization', 'With Geo Optimization'};
user_a_times = [1200, 1000];
user_b_times = [800, 600];

% Convert scenarios to numeric values for plotting
x = 1:length(scenarios);

% Create the line chart
figure;
plot(x, user_a_times, '-o', 'DisplayName', 'User A', 'LineWidth', 2, 'Color', [0.2, 0.2, 0.9], 'MarkerSize', 10, 'MarkerFaceColor', [0.2, 0.2, 0.9]);
hold on;
plot(x, user_b_times, '-o', 'DisplayName', 'User B', 'LineWidth', 2, 'Color', [0.9, 0.2, 0.2], 'MarkerSize', 10, 'MarkerFaceColor', [0.9, 0.2, 0.2]);

% Customize the x-axis
set(gca, 'XTick', x, 'XTickLabel', scenarios, 'FontSize', 12);

% Add labels and title
xlabel('Scenarios', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Execution Time (seconds)', 'FontSize', 14, 'FontWeight', 'bold');
title('Impact of Geographical Optimization on Execution Time', 'FontSize', 16, 'FontWeight', 'bold');

% Add grid lines
grid on;

% Add legend
legend('show', 'Location', 'best');

% Add data labels at each data point
text(x(1), user_a_times(1), num2str(user_a_times(1)), 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'FontSize', 12, 'Color', [0.2, 0.2, 0.9]);
text(x(2), user_a_times(2), num2str(user_a_times(2)), 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'FontSize', 12, 'Color', [0.2, 0.2, 0.9]);
text(x(1), user_b_times(1), num2str(user_b_times(1)), 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'FontSize', 12, 'Color', [0.9, 0.2, 0.2]);
text(x(2), user_b_times(2), num2str(user_b_times(2)), 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'FontSize', 12, 'Color', [0.9, 0.2, 0.2]);
