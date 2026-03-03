f=@(x,y)y*(1+x^2);
g=@(x)exp((x*(x^2 + 3))/3); %dsolve('Dy==y*(1+x^2)',y(0)==1,x)
a=input('Enter initial value of x :');
b=input('Enter end value of x:');
x=a;
y=input('Enter initial value of y:');
n=input('Enter n:');
y1=y;
y2=y1;
y3=y2;
h=(b-a)/n;
disp('Iteration x Exact Euler E_Error Rk2 Rk2_Error Rk4 Rk4_error ');
for i=0:n
ex=g(x);
er=abs(ex-y1);
r2e=abs(ex-y2);
r4e=abs(ex-y3);
fprintf('%5d %9.2f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f\n',i+1,x,ex,y1,er,y2,r2e,y3,r4e);
y1=y1+h*f(x,y1); %approximate root of euler
k1=h*f(x,y2);
k2=h*f(x+h,y2+k1);
y2=y2+(k1+k2)/2; %approximate root of rk2
p1=h*f(x,y3);
p2=h*f(x+h/2,y3+p1/2);
p3=h*f(x+h/2,y3+p2/2);
p4=h*f(x+h,y3+p3);
y3=y3+(p1+2*p2+2*p3+p4)/6; %y3=Approximate root of rk4
x=x+h;
end
