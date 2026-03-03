f=@(x) x.^3-2*x -5;
df = matlabFunction(diff(f,x));

x0=2;

tol = 0.0005


while true
    x1=x0 - (f(x0)/df(x0));
    if abs(x1-x0)<tol
        break
    end 
    x0=x1;
end

fprintf("the root is %0.2f ",x1);
f(x1)