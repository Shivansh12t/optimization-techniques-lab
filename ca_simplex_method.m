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
zcj = [zjcj; A]; % Corrected variable name

simplTable = array2table(zcj);
simplTable.Properties.VariableNames = {'x_1', 'x_2', 'x_3', 's_1', 's_2', 's_3', 'sol'}

% Loop Over
RUN = true;
while RUN
    % Next Step
    if any(zjcj(1, 1:end-1) < 0)  % Check only Zj - Cj row (exclude last column)
        fprintf("The Current BFS is not Optimal\n");
    else
        disp("Optimal Solution Reached");
        RUN = false;
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
    
    Bv(pvt_row) = pvt_col;
    disp('New Basic Variable (Bv) =');
    disp(Bv);
    
    % Pvt Key
    pvt_key = A(pvt_row, pvt_col);
    
    % Update Table for Next Iteration
    A(pvt_row, :) = A(pvt_row, :) ./ pvt_key;
    
    for i = 1:size(A,1)
        if i ~= pvt_row
            A(i,:) = A(i,:) - A(i, pvt_col) .* A(pvt_row,:);
        end
        zjcj = zjcj - zjcj(pvt_col) .* A(pvt_row,:);
    end
    
    % Printing Purpose
    zcj = [zjcj; A];
    simptable = array2table(zcj);
    simplTable.Properties.VariableNames = {'x_1', 'x_2', 'x_3', 's_1', 's_2', 's_3', 'sol'}
    
    BFS = zeros(1, size(A,2));
    BFS(Bv) = A(:, end);
    BFS(end) = sum(BFS.*cost);
    
    current_BFS = array2table(BFS);
    current_BFS.Properties.VariableNames = {'x_1', 'x_2', 'x_3', 's_1', 's_2', 's_3', 'sol'}
end