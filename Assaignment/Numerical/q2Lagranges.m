n = input('How many data u want to input : ');
f = zeros(1,n);
x = zeros(1,n);

disp('Enter x and f(x) : ')
for i=1:n
    fprintf('For row %d ',i);
    x(i) = input('Enter x = ');
    fprintf('For row %d ',i);
    f(i) = input('Enter f(x) = ');
end

intpoint = input('Enter the interpolation point : ');
answer=0;
for i=1:n
    numenator=1;
    denominator=1;

    for j=1:n
        if(i~=j)
            numenator = numenator .* (intpoint - x(j));
            denominator = denominator .* (x(i) - x(j));
        end
    end

    answer = answer + ((numenator./denominator).*f(i));
end

fprintf('The Lagrange Interpolation at %0.2f is %0.6f',intpoint,answer);