miles = input('Enter number of miles: ');

if miles <= 0
    disp('Invalid input');

elseif miles <= 100
    total = miles * 1.00;

elseif miles <= 300
    total = (100 * 1.00) + ((miles-100) * 0.80);

else
    total = (100 * 1.00) + (200 * 0.80) + ((miles-300) * 0.70);
end

average = total / miles;

fprintf('Miles driven     = %d\n', miles);
fprintf('Total cost       = $%0.2f\n', total);
fprintf('Average cost/mile= $%0.2f\n', average);