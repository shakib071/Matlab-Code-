function [c,f]=c2f(m,n)
c=m:n;
f=(9/5)*c+32;
c=c';
f=f';
table(c,f,'VariableNames',{'Celcius','Farenheit'})
end
[c,f]=c2f(30,50);


function [x1,x2] = quad(a,b,c)
    % Check a != 0
    if a == 0
        a = input('Enter a non-zero value of a = ');
    end
    
    d = b^2 - 4*a*c;   % discriminant
    
    if d > 0
        disp('Roots are Real')
        x1 = (-b + sqrt(d)) / (2*a);
        x2 = (-b - sqrt(d)) / (2*a);
    elseif d < 0
        disp('Roots are Imaginary')
        x1 = (-b + sqrt(d)) / (2*a);
        x2 = (-b - sqrt(complex(d))) / (2*a);
        
    else
        disp('Roots are Equal')
        x1 = -b / (2*a);
        x2 = x1;
    end
    
end

[x1,x2]=quad(2,6,3);
fprintf('x1 = %g + %gi\n', real(x1), imag(x1));
fprintf('x2 = %g + %gi\n', real(x2), imag(x2));


