variables = {'x_1','x_2','x_3','s_1','s_2','sol'};
cost = [-2 0 -1 0 0 0];
info = [-1 -1 1;-1 2 -4];
b = [-5; -8];

s = eye(size(info,1));
A = [info s b];

% Finding Starting BFS
Bv = [];
for j = 1:size(s,2)
    for i = 1:size(A,2)
        if A(:,i) == s(:,j)
            Bv = [Bv i];
        end
    end
end

fprintf("Basic Variables are :")
disp(Bv)

% Calculating Zj - Cj
zjcj = cost(Bv) * A - cost;
zcj = [zjcj; A]; % Corrected variable name

simplTable = array2table(zcj);
simplTable.Properties.VariableNames = variables;
disp(simplTable)

run = true;
while run
    % Dual Simplex
    Sol = A(:,end);
    if any(Sol < 0)
        fprintf("\ncurrenr solution is not feasible\n")
    else
        fprintf("\nThe solution is feasible\n")
        run = false;
        break;
    end
    
    % Find Leaving Variable
    [leaving_var, pvt_row] = min(Sol);
    fprintf('Leaving Row = %d\n',pvt_row)
    
    % Find Entering Variable
    Row = A(pvt_row,1:end-1);
    zj = zjcj(:,1:end-1);
    for i = 1:size(Row,2)
        if Row(i) < 0
            ratio(i) = abs(zj(i) ./ Row(i));
        else
            ratio(i) = Inf;
        end
    end
    
    [min_val, pvt_col] = min(ratio);
    fprintf('Entering variable = %d (%s)\n', pvt_col, variables{pvt_col});
    
    % Update the basic variable
    Bv(pvt_row) = pvt_col;
    fprintf('Basic Variables (Bv) = ');
    disp(variables(Bv));
    
    % Pivot key
    pvt_key = A(pvt_row, pvt_col);
    
    % Update the table for next iteration
    A(pvt_row, :) = A(pvt_row, :) / pvt_key;
    for i = 1:size(A, 1)
        if i ~= pvt_row
            A(i, :) = A(i, :) - A(i, pvt_col) * A(pvt_row, :);
        end
    end
    zjcj=cost(Bv)*A -cost
    
    zcj = [zjcj; A];
    simptable = array2table(zcj);
    simptable.Properties.VariableNames(1:size(zcj, 2)) = variables;
    disp('Updated Simplex Tableau:');
    disp(simptable);
end


