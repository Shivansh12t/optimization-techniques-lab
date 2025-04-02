% Input Parameters
c = [-1 3 -2];
info = [3 -1 2; -2 4 0; -4 3 8];
b = [7; 12; 10];

s = eye(size(info, 1)); % 3 Slack Variables due to the problem
A = [info s b]; % Combined to make content of Simplex Table

cost = zeros(1, size(A, 2)); % Cost is the size of columns of A
cost(1:size(c, 2)) = c;

Bv = size(c, 2) + 1:size(A, 2) - 1;

% Calculate Zj-Cj
zjcj = cost(Bv) * A - cost;
zjcj = [zjcj; A]; % Corrected variable name

simplTable = array2table(zjcj);
simplTable.Properties.VariableNames = {'x_1', 'x_2', 'x_3', 's_1', 's_2', 's_3', 'sol'}

% Next Step
if any(zjcj(1, 1:end-1) < 0)  % Check only Zj - Cj row (exclude last column)
    fprintf("The Current BFS is not Optimal\n");
else
    disp("Optimal Solution Reached");
end

% Find the Entering Variable (Most Negative Zj - Cj)
zc = zjcj(1, 1:end-1);  % Get all except the last column
[enter_col, pvt_col] = min(zc);  % Find the most negative value index

% Find the Leaving Variable
sol = A(:, end); % Corrected: Take the last column (solution values)
column = A(:, pvt_col);
ratio = inf(size(column));  % Preallocate with inf

for i = 1:size(column, 1)
    if column(i) > 0
        ratio(i) = sol(i) / column(i);
    end
end

% Find the Pivot Row (Minimum Ratio Rule)
[leave_row_value, pvt_row] = min(ratio);

% Display Results
fprintf("Entering Variable: x_%d\n", pvt_col);
fprintf("Leaving Variable: x_%d\n", Bv(pvt_row));
fprintf("Pivot Element: %f\n", A(pvt_row, pvt_col));
