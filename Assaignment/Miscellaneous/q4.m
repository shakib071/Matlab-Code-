W = input('Enter weight (kg): ');
H = input('Enter height (m): ');

if W <= 0 || H <= 0
    disp('Invalid input....  weight and height must be positive');
else
    BMI = W / (H^2);
  
    if BMI <= 18.5
        status = 'Underweight';
    elseif BMI <= 24.9
        status = 'Normal';
    elseif BMI <= 29.9
        status = 'Overweight';
    else
        status = 'Obese';
    end

    fprintf('Weight : %.2f kg\n', W);
    fprintf('Height : %.2f m\n',  H);
    fprintf('BMI    : %.2f\n',    BMI);
    fprintf('Status : %s\n',      status);
end