
function dydt = model(t,y)
% y(1)=s : sensitive bacteria
% y(2)=r : resistant bacteria
% y(3)=b : immune cells
% y(4)=INH : antibiotic 1
% y(5)=ZPA : antibiotic 2

s = y(1);
r = y(2);
b = y(3);
INH = y(4);
ZPA = y(5);

% Parameters
rs = 1.2; rr = 0.8;
K = 1;
alpha = 0.6;    % antibiotic effect
beta = 0.5;     % immune effect
mu = 0.05;      % mutation
db = 0.3;

% DE
ds = rs*s*(1-(s+r)/K) - alpha*INH*s - beta*b*s - mu*s;
dr = rr*r*(1-(s+r)/K) + mu*s - beta*b*r;
db = beta*b*(s+r) - db*b;
dINH = -0.1*INH;
dZPA = -0.05*ZPA;

dydt = [ds; dr; db; dINH; dZPA];
end


