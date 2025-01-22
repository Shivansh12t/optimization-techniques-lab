% False

% Phase 1 - Input Params
c = [6 8];
A = [2 3; 1 2];
b = [16; 16];

% Phase 2 - Plotting Graph

% Ax = b
y1 = 0:10:max(b);
x21 = (b(1) - A(1,1)*y1)/A(1,2);
x22 = (b(2) - A(2,1)*y1)/A(2,2);
% x23 = (b(3) - A(3,1)*y1)/A(3,2);

% values >= 0
x21 = max(0,x21);
x22 = max(0,x22);
% x23 = max(0,x23);

% plot
plot(y1, x21, 'r', y1, x22, 'k');
xlabel("values of x1");
ylabel("values of x2");
title("optimizing objective function");
legend("2x1 + 3x2 <= 16", "x1 + 2x2 <= 16");
grid on

% Phase 3 - Finding Corner Pts
cx1 = find(y1 == 0); % Points on X1 Axis
c1 = find(x21 == 0); % Points on X2 Axis

line1 = [y1(:, [c1 cx1]); x21(:,[c1 cx1])]';

c2 = find(x22 == 0);
line2 = [y1(:, [c2 cx1]); x22(:,[c2 cx1])]';

% c3 = find(x23 == 0);
% line3 = [y1(:, [c3 cx1]); x23(:,[c3 cx1])]';

corner_pts = unique([line1; line2], 'rows');

% Phase 4 - Intersection Points of each line

pts = [0,0]; % Initialize the intersection points array

for i = 1:size(A,1)
    for j = i+1:size(A,1)
        A1 = A([i, j], :);  % Select rows i and j from A
        B1 = b([i, j]);     % Select corresponding elements from b
        x = A1 \ B1;        % Solve the linear system using matrix division instead of inv()
        pts = [pts; x'];    % Store the result as a new row
    end
end

intr = pts;  % Store the final points

% Phase 5 - Write all Corner Points
all_pts = [intr; corner_pts];
points = unique(all_pts,"rows");

% Phase 6 - Find Feasible Region
for i = 1:size(points, 1)
    const1(i) = A(1,1) * points(i,1) + A(1,2) * points(i,2) - b(1);
    const2(i) = A(2,1) * points(i,1) + A(2,2) * points(i,2) - b(2);
    % const3(i) = A(3,1) * points(i,1) + A(3,2) * points(i,2) - b(3);
end

s1 = find(const1 > 0);
s2 = find(const2 > 0);
% s3 = find(const3 > 0);
s = unique([s1 s2]);

if ~isempty(s)
    % points(s, :) = [];
end

% Phase 7 - Objective Value and Points
value = points * c';
table = [points, value];

% Phase 8 - Objective Value
optimal_value = max(table)