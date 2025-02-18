%NOOB SCRIPT

% Phase 1 - Input Parameters (Modify this for different problems)
c = [6 8];
A = [2 3; 1 2];
b = [16; 16];

% Phase 2 - Plotting Graph

% Define range for x1 values
y1 = 0:10:max(b);
x_vals = zeros(size(A,1), length(y1)); % Matrix to store x values

for i = 1:size(A, 1)
    x_vals(i, :) = (b(i) - A(i,1) * y1) / A(i,2);
    x_vals(i, :) = max(0, x_vals(i, :)); % Ensure values >= 0
end

% Plot all constraint lines dynamically
colors = ['r', 'k', 'b', 'g', 'm', 'c']; % Different colors for lines
hold on
for i = 1:size(A, 1)
    plot(y1, x_vals(i, :), colors(mod(i-1, length(colors))+1));
end
xlabel("Values of x1");
ylabel("Values of x2");
title("Optimizing Objective Function");
legend(arrayfun(@(i) sprintf('Constraint %d', i), 1:size(A,1), 'UniformOutput', false));
grid on
hold off

% Phase 3 - Finding Corner Points Dynamically
corner_pts = [];  % Initialize an empty matrix to store corner points

cx1 = find(y1 == 0); % Points on X1-axis

for i = 1:size(A, 1)
    c_temp = find(x_vals(i, :) == 0); % Find where the constraint touches x2-axis
    line_temp = [y1(:, [c_temp cx1]); x_vals(i, [c_temp cx1]) ]'; % Collect corner points
    corner_pts = [corner_pts; line_temp]; % Store all corner points
end

corner_pts = unique(corner_pts, 'rows'); % Remove duplicates

% Phase 4 - Intersection Points of each line
pts = [0, 0]; % Start with origin (optional)

for i = 1:size(A,1)
    for j = i+1:size(A,1)
        A1 = A([i, j], :);  % Select rows i and j from A
        B1 = b([i, j]);     % Select corresponding elements from b
        x = A1 \ B1;        % Solve Ax = B using matrix division
        if all(x >= 0) % Ensure non-negative solutions
            pts = [pts; x']; % Store the valid intersection points
        end
    end
end

intr = unique(pts, 'rows');  % Unique intersection points

% Phase 5 - Write all Corner Points
all_pts = [intr; corner_pts];
points = unique(all_pts, "rows");

% Phase 6 - Find Feasible Region Dynamically
num_constraints = size(A, 1);
num_points = size(points, 1);

% Evaluate all constraints dynamically for each point
violations = zeros(num_points, num_constraints);
for i = 1:num_points
    for j = 1:num_constraints
        violations(i, j) = A(j, :) * points(i, :)' - b(j);
    end
end

% Find indices of points violating any constraints
violating_indices = unique(find(any(violations > 0, 2)));

% Remove infeasible points
points(violating_indices, :) = [];

% Phase 7 - Calculate Objective Value and Points
value = points * c'; % Compute objective function value for feasible points
result_table = [points, value];

% Phase 8 - Find Optimal Objective Value and Points
[optimal_value, idx] = max(value);
optimal_point = points(idx, :);

% Display Results
disp('Feasible Points and Objective Values:');
disp(array2table(result_table, 'VariableNames', {'x1', 'x2', 'ObjectiveValue'}));

disp('Optimal Solution:');
disp(['Optimal Point: (', num2str(optimal_point(1)), ', ', num2str(optimal_point(2)), ')']);
disp(['Optimal Objective Value: ', num2str(optimal_value)]);

% Plot feasible region points
hold on;
scatter(points(:,1), points(:,2), 80, 'filled', 'MarkerFaceColor', 'g');
scatter(optimal_point(1), optimal_point(2), 100, 'filled', 'MarkerFaceColor', 'r');
legend('Constraints', 'Feasible Points', 'Optimal Point');
hold off;
