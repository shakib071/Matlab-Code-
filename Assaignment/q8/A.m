
a = input('Input a = ');
b = input('Input b = ');
c = input('Input c = ');

if(a==0)
    disp('a can not be zero ... Enter a valid number ');
    return;
end

d = b.^2 - 4.*a.*c;

if d<0
    x11 = (-b)./(2.*a);
    x12 = (sqrt(-d))./(2.*a);
    fprintf('The roots are %0.2f + %0.2fi and %0.2f - %0.2fi\n',x11,x12,x11,x12);

else
    x1 = (-b + sqrt(d))./(2.*a);
    x2 = (-b - sqrt(d))./(2.*a);
    fprintf('The roots are %0.2f and %0.2f\n',x1,x2);
end

