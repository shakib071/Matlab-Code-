
n = 15;

answer= zeros(1,n);

answer(1)=1;
answer(2)=1;
sum=2;


for i=3:n
    answer(i) = answer(i-1) + answer(i-2);
    sum = sum + answer(i);
end 


fprintf('The sum of 1st 15 terms of fibonacci sequence is : %d \n',sum);
    

