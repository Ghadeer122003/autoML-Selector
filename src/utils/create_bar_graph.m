function create_grouped_bar_graph()
    % Define the file sizes
    file_sizes = {'Small', 'Medium', 'Large'};
    
    % Accurate performance metrics for each file size
    % Values: [Elapsed Time, CPU Usage, Memory Usage]
    small_values = [0.34, 0.41, 72.02]; % Small file metrics
    medium_values = [0.45, 0.81, 92.67]; % Medium file metrics
    large_values = [1.75, 1.49, 104.07]; % Large file metrics

    % Prepare data for bar graph
    values = [small_values; medium_values; large_values];

    % Create grouped bar graph with subplots
    figure('Color', 'w'); % Create new figure with white background
    
    % Plot Elapsed Time
    subplot(1,3,1);
    b1 = bar(categorical(file_sizes), values(:,1), 'FaceColor', [0 0.4470 0.7410]);
    ylabel('Elapsed Time (s)'); % Set y-axis label
    title('Elapsed Time by File Size'); % Set title
    ylim([0, 2]); % Set y-axis limits
    grid on; % Add grid for better visualization
    % Adding values as text on top of the bars
    xtips1 = b1.XEndPoints;
    ytips1 = b1.YEndPoints;
    labels1 = string(round(b1.YData, 2)); % Adjust precision as needed
    text(xtips1, ytips1, labels1, 'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'bottom');
    
    % Plot CPU Time Used
    subplot(1,3,2);
    b2 = bar(categorical(file_sizes), values(:,2), 'FaceColor', [0.8500 0.3250 0.0980]);
    ylabel('CPU Time Used (s)'); % Set y-axis label
    title('CPU Time Used by File Size'); % Set title
    ylim([0, 2]); % Set y-axis limits
    grid on; % Add grid for better visualization
    % Adding values as text on top of the bars
    xtips2 = b2.XEndPoints;
    ytips2 = b2.YEndPoints;
    labels2 = string(round(b2.YData, 2)); % Adjust precision as needed
    text(xtips2, ytips2, labels2, 'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'bottom');
    
    % Plot Memory Usage
    subplot(1,3,3);
    b3 = bar(categorical(file_sizes), values(:,3), 'FaceColor', [0.9290 0.6940 0.1250]);
    ylabel('Memory Usage (MB)'); % Set y-axis label
    title('Memory Usage by File Size'); % Set title
    ylim([0, 120]); % Set y-axis limits
    grid on; % Add grid for better visualization
    % Adding values as text on top of the bars
    xtips3 = b3.XEndPoints;
    ytips3 = b3.YEndPoints;
    labels3 = string(round(b3.YData, 2)); % Adjust precision as needed
    text(xtips3, ytips3, labels3, 'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'bottom');
end

% Run the function
create_grouped_bar_graph();
