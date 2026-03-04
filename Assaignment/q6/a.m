
N = input('Input a number N>9 : ');

if N<=9
    disp('Invalid input .. Input a number N>9 ');
    return;
end

flag = true;
divisors = [1,N];
sum = 1 + N;
for i=2:sqrt(N)

    if mod(N,i) == 0
        flag = false;
        divisors = [divisors,i];
        divisors = [divisors, N/i];
        sum = sum + i + N/i;
    end

end

if(flag == true)
    fprintf('%d is a Prime number \n',N);
else
    fprintf('%d is not a Prime number \n',N);
    disp('The divisors are : ');
    fprintf('%d ',sort(divisors));
    fprintf('\n');
    fprintf('The sum of divisors is %d \n',sum);
    if (sum - N) == N 
        fprintf('%d is a perfect number \n',N);
    else 
        fprintf('%d is not a perfect number \n',N);
    end
end