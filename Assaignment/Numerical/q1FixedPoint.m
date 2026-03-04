%fixed point iteration

g = @(x) 1./sqrt(x+1);

x0 = input('Enter the initial guess x0 = ' );
iter = input('Iteration = ');
tol = input('Tolerence = ');
x1 = g(x0);
i=1;

rootFound = false;
while (i<=iter )

    if(abs(x1-x0) <= tol)
        rootFound = true;
        fprintf('The approximate root in Fixed point iteration is = %0.6f \n',x1);
        break;
    end

    x0=x1;
    x1=g(x0);
    i=i+1;
end

if rootFound == false
    disp('No Root Found ');
end

