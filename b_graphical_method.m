c = [1 1];
A = [1 1; -1 2];
b = [1; 1];

y1 = 0:0.1:max(b);

x21 = (b(1) - A(1,1)*y1)/A(1,2);
x22 = (b(2) - A(2,1)*y1)/A(2,2);

plot(y1, x21, 'r', y1, x22, 'b');

cx = find(y1 == 0);
c1 = find(x21 == 0);
c2 = find(x22 == 0);

line1 = [y1(:,[c1 cx]); x21(:,[c1 cx])]';
line2 = [y1(:,[c2 cx]); x22(:,[c2 cx])]';

corner_pts = unique([line1; line2], 'rows');
