
n=input("Enter a number greater equal then 10: ");
if(n<10)
    disp("Enter value greater than 10");
    return;
end 
sum=0;
prod=1;
for i=1:n
    tempSum = 0;
    for j=1:i
        
        tempSum = tempSum + (1./j);
    end 
    sum = sum + tempSum;
    prod = prod*tempSum;
end

fprintf('The sum and product of the series at n=%d are %0.6f and %0.6f respectively. ',n,sum,prod);