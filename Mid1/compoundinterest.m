function comp(p,i,m,t)
format bank
s=p*(1+i/m)^(m*t);
r=s-p;
fprintf('Accumulate value after %d years = %f\n',t,s);
fprintf('Compound interest = %f\n',r);
end

comp(1000,0.06,4,5)
