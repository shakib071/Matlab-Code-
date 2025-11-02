%if condition
    % code if condition is true
%elseif another_condition
    % code if second condition is true
%else
    % code if all conditions are false
%end


x = 5;

if x > 10
    disp('x is greater than 10');
elseif x == 5
    disp('x equals 5');
else
    disp('x is less than 10 and not 5');
end


%> : greater than
%< : less than
%>= : greater than or equal
% <= : less than or equal
% == : equal
% ~= : not equal
% & : AND
% | : OR
% ~ : NOT



x = 5; y = 8;

if x < 10 && y > 5
    disp('Condition true');
end
