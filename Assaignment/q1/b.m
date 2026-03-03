
x= (-2:0.01:-1)';

y = 1./x.^3 + 1./x.^2 + 3./x;

t= table(x,y,'VariableNames',{'x','y'});
disp(t);