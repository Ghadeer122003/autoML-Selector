function create_comparison_graph()
    % Centralized computing runtimes
    centralized_runtimes = [0.43335, 0.57345, 1.13294]; % Small, Medium, Large

    % Parallel computing runtimes
    parallel_runtimes = [0.13238, 0.42368, 0.22632]; % Small, Medium, Large

    % File categories
    file_categories = {'Small', 'Medium', 'Large'};

    % Prepare data for bar graph
    runtimes = [centralized_runtimes; parallel_runtimes]';

    % Create grouped bar graph
    figure;
    b = bar(categorical(file_categories), runtimes);
    ylabel('Runtime (seconds)');
    title('Comparison of Centralized vs. Parallel Computing Runtimes');
    legend({'Centralized', 'Parallel'}, 'Location', 'northwest');
    grid on;

    % Customize colors
    b(1).FaceColor = [0 0.4470 0.7410]; % Blue for Centralized
    b(2).FaceColor = [0.8500 0.3250 0.0980]; % Red for Parallel

    % Add values as text on top of the bars
    for i = 1:length(b)
        xtips = b(i).XEndPoints;
        ytips = b(i).YEndPoints;
        labels = string(round(b(i).YData, 5));
        text(xtips, ytips, labels, 'HorizontalAlignment', 'center', ...
            'VerticalAlignment', 'bottom');
    end
end

% Run the function
create_comparison_graph();
