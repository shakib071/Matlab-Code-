%for variable = start:step:end
    % code to repeat
%end

for i = 1:5
    disp(['i = ', num2str(i)]);
end

for x = 0:0.5:2
    disp(x);
end


%while condition
    % code to repeat
%end


n = 1;
while n <= 5
    disp(['n = ', num2str(n)]);
    n = n + 1;
end


for i = 1:10
    if i == 6
        break;  % exit loop
    end
    disp(i);
end


for i = 1:5
    if i == 3
        continue;  % skip i=3
    end
    disp(i);
end







