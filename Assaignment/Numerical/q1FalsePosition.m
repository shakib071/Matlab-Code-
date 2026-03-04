
f = @(x) x.^3 + x.^2 - 1;

a = input('Enter Lower bound of Interval a = ');
b = input('Enter Upper bound of Interval b = ');
iter = input('Iteration = ');
tol = input('Tolerence = ');

if (f(a) * f(b) > 0)
    disp('No root Found');
    return;
end 

i=1;

rootFound = false;

while (i<=iter)
    c=b-((f(b).*(a-b))./(f(a)-f(b)));

    if(abs(f(c))<=tol)
        fprintf('Approximate root in False Position Method is  = %0.6f\n',c);
        rootFound = true;
        break;
    end

    if(f(a)*f(c)> 0)
        a=c;
    else
        b=c;
    end
    i=i+1;
end

if rootFound == false 
    fprintf('No Root Found ');
end