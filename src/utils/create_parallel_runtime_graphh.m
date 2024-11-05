function create_parallel_runtime_graph()
    % Define the features and file sizes
    features = {'Elapsed Time', 'CPU Time Used', 'Memory Usage'};
    file_sizes = {'Large', 'Medium', 'Small'};
    
    % Runtime values for parallel computing for small, medium, and large files
    large_values = [18.23, 0.56, 272.52]; % Values for large file
    medium_values = [17.93, 0.63, 271.07]; % Values for medium file
    small_values = [17.30, 0.21, 267.91]; % Values for small file

    % Combine values for plotting
    values = [large_values; medium_values; small_values];
    
    % Prepare the data for bar graph
    categories = {'Elapsed Time', 'CPU Time Used', 'Memory Usage'};
    
    % Create a bar graph
    figure('Color', 'w'); % Create figure with white background
    
    % Subplot 1: Elapsed Time
    subplot(3,1,1);
    b1 = bar(categorical(file_sizes), values(:,1), 'FaceColor', [0 0.4470 0.7410]);
    ylabel('Elapsed Time (s)');
    title('Elapsed Time by File Size');
    grid on;
    ylim([0 max(values(:,1))+5]);
    text(b1.XEndPoints, b1.YEndPoints, string(values(:,1)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
    
    % Subplot 2: CPU Time Used
    subplot(3,1,2);
    b2 = bar(categorical(file_sizes), values(:,2), 'FaceColor', [0.8500 0.3250 0.0980]);
    ylabel('CPU Time Used (s)');
    title('CPU Time Used by File Size');
    grid on;
    ylim([0 max(values(:,2))+1]);
    text(b2.XEndPoints, b2.YEndPoints, string(values(:,2)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
    
    % Subplot 3: Memory Usage
    subplot(3,1,3);
    b3 = bar(categorical(file_sizes), values(:,3), 'FaceColor', [0.9290 0.6940 0.1250]);
    ylabel('Memory Usage (MB)');
    title('Memory Usage by File Size');
    grid on;
    ylim([0 max(values(:,3))+50]);
    text(b3.XEndPoints, b3.YEndPoints, string(values(:,3)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
    
    % Overall title
   % sgtitle('Performance Metrics by File Size');
end

% Run the function
create_parallel_runtime_graph();
