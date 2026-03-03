syms x y(x)
dsolve('Dy==y*(1+x^2)',y(0)==1,x)

syms x(t)
y = t^2;
odes1 = diff(x,t) == y;
condition = x(0) == 0;
sol = dsolve(odes1, condition)


syms x(t) y(t)
odes = [diff(x,t) == y, diff(y,t) == -x];
conds = [x(0)==0, y(0)==1];
sol = dsolve(odes, conds)
