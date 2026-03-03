
x=input('Enter value of x: ');
y=input('Enter value of y: ');

if((x==0 && y==0) || (x==0 && y<=0))
    disp('Invalid input');
    return;
end 

val = x.^y;

fprintf('The value of x^y is at x= %0.2f and y=%0.2f is : %0.2f',x,y,val);