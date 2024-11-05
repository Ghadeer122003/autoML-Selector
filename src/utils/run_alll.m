% Main script to run multiple files sequentially
function run_all()
    % Start timer for the entire script
    tic;

    % Define file paths and parameters
    files = {'small.csv', 'medium.csv', 'large.csv'};
    target_column = 'Temperature';
    x_feature = 'CPU Total';

    % Initialize parallel pool once
    pool = parpool('local', 4); % 4 MATLAB processes that run simultaneously

    % Run the function for each file
    for i = 1:length(files)
        run_computations(files{i}, target_column, x_feature);
    end

    % Shut down parallel pool
    delete(pool);

    % End timer and display total runtime
    total_runtime = toc;
    fprintf('Total runtime for the script: %f seconds\n', total_runtime);
end

% Run the main script
run_all();
