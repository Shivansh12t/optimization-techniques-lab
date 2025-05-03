clc 
clear all
syms x1 x2
f1 = x1-x2+2*x1^2+2*x1*x2+x2^2;
fx = inline(f1);
fobj = @(x) fx(x(:, 1), x(:, 2));

grad = gradient(f1);
G = inline(grad);
gradx = @(x) G(x(:, 1), x(:, 2));

h = hessian(f1);
hx = inline(h);

x0 = [1 1];
maxiter = 4;
tol = 1e-3; 
iter = 0;
X = [];

while norm(double(gradx(x0)))>tol&&iter<maxiter
    X = [X; x0];
    S = -double(gradx(x0));
    hval = double(hx(x0));
    lam = (S' * S)/(S' *hval*S);
    x0 = x0+lam*S';
    iter = iter+1;
end

fprintf("optimal solution x = [%f %f] \n", x0(1), x0(2));
fprintf("optimal value f(x) = %f \n", fobj(x0));