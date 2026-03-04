
M = input('Enter the number of M: ');

N = input('Enter the number of N: ');



answer = [];

for i=M:N
    flag= true;
    if i>=2
        for j=2:sqrt(i)
          
            if mod(i,j)==0
                flag=false;
                break;
            end
        end
    
        if flag == true
            answer = [answer,i];
        end
    end
end 

if(length(answer) == 0)
    fprintf('There is no prime number between M=%d and N=%d \n',M,N);
else 
    fprintf('The prime number  between M=%d and N=%d is: \n ',M,N)
    fprintf('%d ', answer);
    fprintf('\n');
    fprintf('There are %d prime number between M=%d and N=%d \n',length(answer),M,N);
end 


