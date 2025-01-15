% Phase 1 - Input Params
c = [3 5];
A = [1 2; 1 1; 0 1];
b = [2000; 1500; 600];

% Phase 2 - Plotting Graph

% Ax = b
y1 = 0:10:max(b);
x21 = (b(1) - A(1,1)*y1)/A(1,2);
x22 = (b(2) - A(2,1)*y1)/A(2,2);
x23 = (b(3) - A(3,1)*y1)/A(3,2);

% values >= 0
x21 = max(0,x21);
x22 = max(0,x22);
x23 = max(0,x23);

% plot
plot(y1, x21, 'r', y1, x22, 'k', y1, x23, 'b');
xlabel("values of x1");
ylabel("values of x2");
title("optimizing objective function");
legend("x1 + 2*x2 <= 2000", "x1 + x2 <= 1500", "x2 <= 600");
grid on

% Phase 3 - Finding Corner Pts
cx1 = find(y1 == 0); % Points on X1 Axis
c1 = find(x21 == 0); % Points on X2 Axis

line1 = [y1(:, [c1 cx1]); x21(:,[c1 cx1])]';

c2 = find(x22 == 0);
line2 = [y1(:, [c2 cx1]); x22(:,[c2 cx1])]';

c3 = find(x23 == 0);
line3 = [y1(:, [c3 cx1]); x23(:,[c3 cx1])]';

corner_pts = unique([line1; line2; line3], 'rows');

% Phase 4 - Intersection Points

