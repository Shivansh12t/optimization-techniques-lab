c = [3, 2];  % Use commas for row vector

A = [1, 2, 1; 
     1, 1, 1; 
     1, -2, -1];

b = [10; 6; 1];

n = size(A, 1);
s = eye(n);  % Identity matrix for slack variables

signs = [0 0 1];  % Define sign array
index = find(signs > 0);  % Find indices where signs > 0

s(index, :) = -s(index, :);  % Correct negation of rows

% Augmented matrix with slack variables
mat = [A, s, b];

% Creating the objective function table
obj = array2table(c, 'VariableNames', {'x1', 'x2'});

% Creating the constraint matrix table
table = array2table(mat, 'VariableNames', {'x1', 'x2', 'x3', 's1', 's2', 'b'});

% Display tables
disp('Objective Function:');
disp(obj);

disp('Constraint Matrix:');
disp(table);
