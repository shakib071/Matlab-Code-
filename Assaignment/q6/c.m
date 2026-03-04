

Stirling_fact = @(n) exp(-n) .* n.^n .* sqrt(2.*pi.*n);

disp('Enter two positive numbers N, R (N>=R)');
n = input('Enter N: ');
r = input('Enter R: ');

if(n<r || n<=0 || r<=0)
    disp('Enter valid positive numbers ');
    return;
end

nCr = Stirling_fact(n) ./ (Stirling_fact(r) .* Stirling_fact(n-r));

fprintf('The value of nCr is : %0.3f \n',nCr);


