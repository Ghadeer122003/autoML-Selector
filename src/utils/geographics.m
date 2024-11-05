% Load the dataset
opts = detectImportOptions('geographical_user_data.csv');
opts.VariableNamingRule = 'preserve'; % Preserve variable names
data = readtable('geographical_user_data.csv', opts);

% Display the table to verify column names
disp(data.Properties.VariableNames);

% Rename columns to valid MATLAB variable names
data.Properties.VariableNames = {'File', 'Algorithm', 'Location', 'Users', 'ElapsedTime', 'CPUUsage', 'MemoryUsage'};

% Preprocess the data
data = rmmissing(data);

% Convert categorical data to numeric (e.g., Location)
data.Location = grp2idx(data.Location);

% Normalize numerical data
data.ElapsedTime = normalize(data.ElapsedTime);
data.CPUUsage = normalize(data.CPUUsage);
data.MemoryUsage = normalize(data.MemoryUsage);
data.Users = normalize(data.Users);
