
%(i-iv)

x = (1:0.01:2)'; 

y1= (x.^2)./(x.^3 + 1);
y2= sin((x.*cos(x))./(x.^2+3.*x+1));
y3= (1./x) + (x.^3)./(x.^4+5.*x.*sin(x));
y4=x./(x+(1./x));

t = table(x,y1,y2,y3,y4, 'VariableNames',{'x','(i)','(ii)','(iii)','(iv)'});
disp(t);


