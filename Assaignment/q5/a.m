
n = input('Enter the value of the term : ');

if(n<=0)
    disp('Enter a valid number');
    return;
end

if(n==1)
    fprintf('The 1st %d term of fibonacci sequence is : \n',n);
    fprintf("%d ",1);
    fprintf('\n');
    return;
end

answer= zeros(1,n);

answer(1)=1;
answer(2)=1;



for i=3:n
    answer(i) = answer(i-1) + answer(i-2);
end 


fprintf('The 1st %d term of fibonacci sequence are : \n',n);
fprintf("%d ",answer);
fprintf('\n');
    

