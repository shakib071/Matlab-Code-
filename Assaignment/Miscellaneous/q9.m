
T = [58 73 73 53 50 48 56 73 73 66 69 63 74 82 84 91 93 89 91 80 59 69 56 64 63 66 64 74 63 69];
disp('Temperature data:'); 
disp(T);
above75 = 0;
bet65_80 = 0;
days = [];
for i=1:length(T)
    if T(i) > 75
        above75 = above75 + 1;
    end
    if T(i) >=65 && T(i)<=80
        bet65_80 = bet65_80 + 1;
    end
    if T(i) >= 50 && T(i) <= 60
        days = [days,i];
    end
end

fprintf('a) Days above 75°F         = %d\n', above75);
fprintf('b) Days between 65-80°F    = %d\n', bet65_80);
fprintf('c) Days between 50-60°F    = ');
fprintf('%d ', days);
fprintf('\n');





