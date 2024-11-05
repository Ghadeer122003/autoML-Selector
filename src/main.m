function main(file_path, target_column, x_feature)
    % Ensure the correct number of arguments
    if nargin ~= 3
        error('Usage: main(file_path, target_column, x_feature)');
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

    % Measure runtime
    tic;

    % Run the selected algorithm
    switch algorithm
        case 'Linear_Regression'
            Linear_Regression(file_path, target_column, x_feature);  % Call Linear Regression function
        case 'Support_Vector_Regression'
            Support_Vector_Regression(file_path, target_column, x_feature);  % Call SVR function
        case 'Random_Forest'
            Random_Forest(file_path, target_column, x_feature);  % Call Random Forest function
        otherwise
            error('Unknown algorithm: %s', algorithm);  % Error for unknown algorithm
    end

    elapsedTime = toc;

    % Display the runtime
    fprintf('Elapsed Time: %.2f seconds\n', elapsedTime);
end
