

%(i)

sum1 = 0;
for i=1:99
    sum1 = sum1 + (i/(i+1));
end

fprintf('The sum of the series is : %0.5f  \n',sum1);



%(ii)


sum2 = 0;

for i=1:50
    num =  2*i-1;
    sum2 = sum2 + (num/i);
end

fprintf('The sum of the series is %0.5f ',sum2);