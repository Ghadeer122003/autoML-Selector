function Random_Forest(file_path, target_column, x_feature)
    % Load dataset
    opts = detectImportOptions(file_path); % Detect import options
    opts.VariableNamingRule = 'preserve'; % Preserve variable names
    data = readtable(file_path, opts); % Read the dataset

    % Use specified x_feature as the feature and target_column as the target
    X = data{:, x_feature}; % Get feature column
    Y = data{:, target_column}; % Get target column

    % Normalize the features
    X = (X - mean(X)) ./ std(X); % Normalize features

    % Split the data into training and testing sets
    cv = cvpartition(size(X, 1), 'HoldOut', 0.2); % 20% for testing
    X_train = X(training(cv), :); % Training feature set
    X_test = X(test(cv), :); % Testing feature set
    Y_train = Y(training(cv), :); % Training target set
    Y_test = Y(test(cv), :); % Testing target set

    % Train random forest model
    rng(0); % For reproducibility
    rf_model = TreeBagger(100, X_train, Y_train, 'Method', 'regression'); % Train RF model

    % Make predictions on the test set
    Y_pred = predict(rf_model, X_test); % Predict with RF model

    % Calculate Root Mean Squared Error (RMSE)
    rmse = sqrt(mean((Y_pred - Y_test).^2)); % Compute RMSE
    disp(['Root Mean Squared Error (RMSE): ', num2str(rmse)]); % Display RMSE

    % Create grid for plotting
    X_grid = linspace(min(X), max(X), 1000)'; % Create grid for plotting
    Y_grid_pred = predict(rf_model, X_grid); % Predict on grid

    % Plot actual vs predicted values
    figure; % Create new figure
    plot(X_test, Y_test, 'b.', 'DisplayName', 'Actual Values'); % Plot actual values
    hold on; % Hold plot for adding more elements
    plot(X_grid, Y_grid_pred, 'r-', 'DisplayName', 'Random Forest Prediction'); % Plot RF predictions
    xlabel(x_feature); % X-axis label
    ylabel(target_column); % Y-axis label
    title('Random Forest Regression'); % Title of plot
    legend('show'); % Show legend
    hold off; % Release plot
end
