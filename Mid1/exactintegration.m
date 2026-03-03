syms y(t) t
Dy = diff(y,t);
ode = Dy == t + y;
cond = y(0) == 1;
yExact = dsolve(ode, cond);         % symbolic exact solution
yFun = matlabFunction(yExact); 