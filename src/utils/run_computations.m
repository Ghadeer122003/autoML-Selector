function run_computations(file_path, target_column, x_feature)
    % Ensure the correct number of arguments
    if nargin ~= 3
        error('Usage: run_computations(file_path, target_column, x_feature)');
    end

    % Check if the file exists
    if exist(file_path, 'file') ~= 2
        error('File does not exist: %s', file_path);
    end

    % Determine file size and select algorithm
    file_info = dir(file_path);
    if isempty(file_info)
        error('Unable to find file info for: %s', file_path);
    end
    disp(file_info); % Print the file_info to debug
    file_size = file_info.bytes;

    % Decide which algorithm to use based on file size
    if file_size < 10000
        algorithm = 'Linear_Regression';  % Small file, use Linear Regression
        size_category = 'small';
    elseif file_size < 50000
        algorithm = 'Support_Vector_Regression';  % Medium file, use SVR
        size_category = 'medium';
    else
        algorithm = 'Random_Forest';  % Large file, use Random Forest
        size_category = 'large';
    end

    % Print details to the terminal
    fprintf('Processing file: %s\n', file_path);
    fprintf('FILE SIZE: %d bytes\n', file_size);
    fprintf('Selecting algorithm for file size category: %s\n', size_category);
    fprintf('Your file will go through the %s algorithm due to its size.\n', algorithm);
    fprintf('Loading and running algorithm for %s...\n', file_path);

    % Load dataset
    opts = detectImportOptions(file_path); % checks the options for file importing
    opts.VariableNamingRule = 'preserve'; % preserving the variable names from the dataset
    data = readtable(file_path, opts); % reads from CSV into a table

    % Use specified x_feature as the feature and target_column as the target
    X = data{:, x_feature}; % Feature column
    Y = data{:, target_column}; % Target column

    % Split the data into training and testing sets
    cv = cvpartition(size(X, 1), 'HoldOut', 0.2); % creates a partition with 20% of the data held out for testing
    X_train = X(training(cv), :); % Selects the training set for features from the partition object
    X_test = X(test(cv), :); % Selects the testing set for features
    Y_train = Y(training(cv), :); % Selects the training set for target
    Y_test = Y(test(cv), :); % Selects the testing set for target

    % Measure runtime and resource usage
    startTime = tic;
    cpuTimeStart = cputime;

    % Run the selected algorithm
    switch algorithm % Initiates a switch-case
        case 'Linear_Regression'
            fprintf('Running Linear Regression on %s...\n', file_path);
            mdl = fitlm(X_train, Y_train); % trains a Linear Regression model using training data
            Y_pred = predict(mdl, X_test); % uses trained model to predict target column
            mse = mean((Y_pred - Y_test).^2); % calculating mean squared error
        case 'Support_Vector_Regression'
            fprintf('Running Support Vector Regression on %s...\n', file_path);
            mdl = fitrsvm(X_train, Y_train, 'KernelFunction', 'linear'); % Trains a Support Vector Regression model with a linear kernel function using the training data
            Y_pred = predict(mdl, X_test);
            mse = mean((Y_pred - Y_test).^2);
        case 'Random_Forest'
            fprintf('Running Random Forest Regression on %s...\n', file_path);
            rng(0); % For reproducibility
            rf_model = TreeBagger(100, X_train, Y_train, 'Method', 'regression'); % Trains a Random Forest regression model with 100 trees using the training data
            Y_pred = predict(rf_model, X_test);
            mse = sqrt(mean((Y_pred - Y_test).^2));
        otherwise
            error('Unknown algorithm: %s', algorithm);
    end

    time_taken = toc;
    cpuTimeUsed = cputime - cpuTimeStart;

    % Collect memory usage using Java
    runtime = java.lang.Runtime.getRuntime();
    memoryUsage = runtime.totalMemory() - runtime.freeMemory();

    % Display the metrics
    fprintf('%s on %s: MSE = %.5f, Time = %.5f seconds\n', algorithm, file_path, mse, time_taken);
    fprintf('Elapsed Time: %.2f seconds\n', time_taken);
    fprintf('CPU Time Used: %.2f seconds\n', cpuTimeUsed);
    fprintf('Memory Usage: %.2f MB\n', memoryUsage / 1e6);
end
