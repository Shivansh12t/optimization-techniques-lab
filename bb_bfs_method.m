% step - 1 : initialise
c = [5 7 0 0];
A = [2, 3, 1, 0;
     4, 1, 0, 1];
b = [12; 10];

% step - 2 : calucate m and n
m = size(A, 1); % rows
n = size(A, 2); % cols

% step - 3 : calculate nv an t
nv = nchoosek(n,m);
t = nchoosek(1:n,m);

% step - 4 : Construct Basic Solution
sol = [];
for i = 1 : nv
    y = zeros(n,1);
    x = A(:, t(i, :)) \ b;
    if all(x>=0 & x~=inf)
        y(t(i,:)) = x;
        sol = [sol y];
    end
end

sol

% step - 5 : Objective Solution
z = c * sol;
[zmax, zind] = max(z);
BFS = sol(:, zind);

% step - 6 : Display the solution
optval = [BFS', zmax];
array2table(optval,'variablenames',{'x1','x2','x3','x4','z'})