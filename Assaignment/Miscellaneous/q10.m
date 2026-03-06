c = 1.06;
y = input('Enter y : ');
mdata = [];
for x=4:22
    m = (y-c)./x;
    mdata = [mdata,m];
end
xdata = 4:22;
t=table(xdata',mdata','VariableNames',{'x','m'});
disp(t);