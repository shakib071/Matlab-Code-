
N= input('Enter a value N (N>9) : ');

if(N<=9)
    disp('Invalid input .. Enter a value N (N>9) ');
    return;
end 

Nvalues=zeros(1,N);

positiveCount = 0;
negativeCount = 0;
primeCount = 0;
perfectNumCount = 0;
sumOfNSquareVal = 0;
sumOfNValues = 0;




fprintf('Enter %d number of values : \n',N);
for i=1:N
    x = input(' ');
    Nvalues(i) = x;
    if(x>0)
        positiveCount = positiveCount + 1;
    elseif x<0
        negativeCount = negativeCount + 1;
    end

    if(x>=2)
        flag = true;
        properDivisorSum = 1;
        for j=2:sqrt(x)
            if mod(x,j) == 0
                flag = false;
                properDivisorSum = properDivisorSum + j;
                properDivisorSum = properDivisorSum + (x/j);
            end
        end
        if flag == true 
             primeCount = primeCount + 1;
        end

        if properDivisorSum == x 
            perfectNumCount = perfectNumCount +1;
        end
    end

    sumOfNSquareVal = sumOfNSquareVal + (x.*x);
    
    sumOfNValues = sumOfNValues + x;


end

avg = sumOfNValues ./ N;

sumForVarience = 0;
for i=1:N
    sumForVarience = sumForVarience + ((Nvalues(i) - avg) .^2);
end

variance = sumForVarience / N;
standardDeviation = sqrt(variance);

fprintf('Positive number count = %d\nNegative number count = %d \n',positiveCount,negativeCount);
fprintf('PrimeCount = %d \nPerfect Number Count = %d \n',primeCount,perfectNumCount);
fprintf('Sum of square of N values = %d \n',sumOfNSquareVal);
fprintf('Average = %0.2f \nVariance = %0.2f \n Standard Deviation = %0.2f\n',avg,variance,standardDeviation);






