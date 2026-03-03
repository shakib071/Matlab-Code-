
f=@(x) x.^3-x-2;
a=input("input the interval a");
b=input("input the interval b");
tol = input("input the tolerence");
iter = input("enter the iter ");

i=0;

while( abs(a-b)/2>tol)
    c=(a+b)/2;
    if(f(c)==0 || abs(f(c))<tol)
        
        break;
    elseif(f(c)*f(a)>0)
        a=c;
    else
        b=c;

    end

end
fprintf("the root is %0.2f",c);

f(c)