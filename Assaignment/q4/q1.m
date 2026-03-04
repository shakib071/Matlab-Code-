
n = input('Enter a value less than 1000 : ');


if(n>1000)
    disp('Please enter a value less than 1000');
    return;
end

if(n<2)
    fprintf('%d is not Prime',n);
    return
end


flag = true;
for i=2:sqrt(n)
   
    if mod(n,i) == 0
        flag = false;
        break;
    end

end

if(flag == true)
    fprintf("%d is Prime",n);
else 
    fprintf("%d is not Prime",n);
end
