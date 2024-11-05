function Linear_Regression(file_path, target_column, x_feature) 
    % Load dataset
    opts = detectImportOptions(file_path); % Detect import options
    opts.VariableNamingRule = 'preserve'; % Preserve variable names
    data = readtable(file_path, opts); % Read the dataset

    % Use specified x_feature as the feature and target_column as the target
    X = data{:, x_feature}; % Get feature column
    Y = data{:, target_column}; % Get target column

    % Split the data into training and testing sets
    cv = cvpartition(size(X, 1), 'HoldOut', 0.2); % 20% for testing
    X_train = X(training(cv), :); % Training feature set
    X_test = X(test(cv), :); % Testing feature set
    Y_train = Y(training(cv), :); % Training target set
    Y_test = Y(test(cv), :); % Testing target set

    % Train linear regression model
    mdl = fitlm(X_train, Y_train); % Train model

    % Predict using the trained model
    Y_pred = predict(mdl, X_test); % Make predictions

    % Calculate Mean Squared Error
    mse = mean((Y_pred - Y_test).^2); % Compute MSE
    disp(['Mean Squared Error: ', num2str(mse)]); % Display MSE

    % Residual Analysis
    residuals = Y_test - Y_pred; % Calculate residuals
    
    % Q-Q Plot
    figure('Position', [100, 100, 600, 400]); % Create figure with specified size
    qqplot(residuals); % Plot Q-Q
    title('Q-Q Plot of Residuals'); % Add title
end
