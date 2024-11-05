function Support_Vector_Regression(file_path, target_column, x_feature)
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

    % Train support vector regression model
    mdl = fitrsvm(X_train, Y_train, 'KernelFunction', 'linear'); % Train SVR model

    % Predict using the trained model
    Y_pred = predict(mdl, X_test); % Make predictions

    % Calculate Mean Squared Error
    mse = mean((Y_pred - Y_test).^2); % Compute MSE
    disp(['Mean Squared Error: ', num2str(mse)]); % Display MSE

    % Generate synthetic 2D dataset
    rng(1); % For reproducibility
    num_points = 100; % Number of points per class
    X = [randn(num_points, 2) * 0.75 + ones(num_points, 2); randn(num_points, 2) * 0.5 - ones(num_points, 2)]; % Generate features
    Y = [ones(num_points, 1); -ones(num_points, 1)]; % Generate labels

    % Train SVM model
    svm_model = fitcsvm(X, Y, 'KernelFunction', 'linear', 'Standardize', true, 'ClassNames', [-1, 1]); % Train SVM

    % Get support vectors
    sv = svm_model.SupportVectors; % Extract support vectors

    % Plot decision boundary, margins, and support vectors
    figure; % Create new figure
    gscatter(X(:,1), X(:,2), Y); % Scatter plot of data
    hold on; % Hold plot for adding more elements
    plot(sv(:,1), sv(:,2), 'ko', 'MarkerSize', 10); % Plot support vectors

    % Get coefficients
    beta = svm_model.Beta; % Coefficients of the decision boundary
    bias = svm_model.Bias; % Bias term
    xp = linspace(min(X(:,1)), max(X(:,1)), 100); % X values for plotting
    yp = - (beta(1) * xp + bias) / beta(2); % Decision boundary line
    plot(xp, yp, '-k'); % Plot decision boundary

    % Calculate margins
    margin = 1 / norm(beta); % Compute margin
    yp_margin1 = yp + margin; % Margin line 1
    yp_margin2 = yp - margin; % Margin line 2
    plot(xp, yp_margin1, '--k'); % Plot margin line 1
    plot(xp, yp_margin2, '--k'); % Plot margin line 2

    title('Support Vector Machine Decision Boundary'); % Title of plot
    xlabel('Feature 1'); % X-axis label
    ylabel('Feature 2'); % Y-axis label
    legend('Class -1', 'Class 1', 'Support Vectors', 'Decision Boundary', 'Margin'); % Legend
    hold off; % Release plot
end
