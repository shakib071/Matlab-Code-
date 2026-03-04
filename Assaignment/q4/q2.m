
answer = zeros(1,25);

i=1;
num = 2;
while i<=25
    
    flag = true;
    for j=2:sqrt(num)
        if mod(num,j)==0
            flag = false;
            break;
        end
    end
    if flag == true 
        answer(i) = num;
        i=i+1;
    end

    num = num + 1;

end

disp('The 1st 25 prime numbers are :  ');
disp(answer);





