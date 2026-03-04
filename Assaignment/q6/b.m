N = input('Input a number 5<=N<=12 : ');

if N>12 || N<5
    disp('Invalid input .. Input a number 5<=N<=12 ');
    return;
end

fact = 1;
for i=2:N
    fact = fact * i;
end 


fprintf('The factorial of %d is %d \n',N,fact);
