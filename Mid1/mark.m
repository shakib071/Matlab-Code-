function [g,c]=grade(mark)
if mark>100||mark<0
c=' Inavlid';
g=NaN;
elseif mark>=80
c='A+';
g=4.00;
elseif mark>=75
c='A';
g=3.75;
elseif mark>=70
c='A-';
g=3.50;
elseif mark>=60
c='B';
g=3.00;
elseif mark>=50
c='C';
g=2.50;
elseif mark>=40
c='D';
g=2.00;
else
c='f';
g=0.00;
end
disp(' mark gpa grade')
fprintf(' %14.2f %7.2f %7s\n',mark,g,c)

end

[g,c]=grade(121)