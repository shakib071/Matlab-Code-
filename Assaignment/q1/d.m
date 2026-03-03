
x=input('Enter value of x: ');

val1= exp(x);
val2=log(x);
if(x<=0)
    fprintf('The value of log(x) at x= %0.2f is Invalid\n',x);
    fprintf('But the value of e^x at x= 0.2f is = %0.2f ',val1);
    return;
end


fprintf('At x=%0.2f ,  e^x = %0.2f and log(x) = %0.2f ',x,val1,val2);
