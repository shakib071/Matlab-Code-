
f = @(x) x.^3 + x.^2 - 1;
df = @(x) 3.*x.^2 + 2.*x;
x0 = input('Enter the initial guess x0 = ' );
iter = input('Iteration = ');
tol = input('Tolerence = ');

i=1;


rootFound = false;
while i<=iter 

    x1 = x0 - (f(x0)/df(x0));

    if(abs(x1-x0) <= tol)
        rootFound = true;
        fprintf('The approximate root in Newton Rapson is = %0.6f \n',x1);
        break;
    end

    x0 = x1;
    i=i+1;
end

if rootFound == false
    disp('No Root Found ');
end


