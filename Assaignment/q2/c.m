
sum = 0;
for i=1:1000
    sum = sum + (1./(i.*i));
end    

piVal = sqrt(sum.*6);

fprintf('The value of PI for 1000 terms is %0.6f . ',piVal );