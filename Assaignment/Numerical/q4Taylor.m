f_str = input('Enter function : eg(x^3+y^2) : ','s');
f = str2func(['@(x,y)' f_str]);
% y' =∂f/∂x + ∂f/∂y · f(x,y)
syms x y;
f_sym = str2sym(f_str);
df_sym = diff(f_sym, x) + diff(f_sym, y) * f_sym;
df = matlabFunction(df_sym,   'Vars', [x, y]);

d2f_sym = diff(df_sym,x) + diff(df_sym, y) * f_sym;
d2f = matlabFunction(d2f_sym,  'Vars', [x, y]);

d3f_sym = diff(d2f_sym,x) + diff(d2f_sym, y) * f_sym;
d3f = matlabFunction(d3f_sym,  'Vars', [x, y]);

disp('Enter the value of initian value x0,y0 and step size h and iteration : ');
x0 = input('x0 = ');
y0 = input('y0 = ');
h = input('h = ');
iter = input('Iteration = ');

y = zeros(1,iter+1);
y(1) = y0;


for i=2:iter+1
    y(i) = y(i-1) + ((h*f(x0,y(i-1)))/factorial(1)) + ((h.^2*df(x0,y(i-1)))/factorial(2)) + ((h.^3*d2f(x0,y(i-1)))/factorial(3)) + (h^4 / factorial(4)) * d3f(x0,  y(i-1));
    x0 = x0 + h;
end 

disp('The Taylor method solution are : ');

for i=1:iter+1
    fprintf('At iteration = %d y = %0.3f\n',i-1,y(i));
end






