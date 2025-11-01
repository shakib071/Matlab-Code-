%if ; at end then not print in command line 


x=5
y=10
z=x+y
%this is a comment 
%clc        % clears command window
%clear      % clears all variables
%who        % shows variable names
%whos       % shows variable details (type, size, etc.)

% info about sine function
%help sin 
%help cos

% open documentation for plot

%doc plot
%doc loop

%MATLAB as a Calculator

%2+3*5 %take as ans as variable
xx=sqrt(16);
yy=sqrt(18);
zz=sin(pi/2);
%print 
disp(xx);
%disp('xx is',xx) %wrong
disp(['xx is',num2str(xx)])
disp(['xx is',num2str(xx),' yy is',num2str(yy)]);
fprintf('xx is %d\n',xx);
fprintf('xx is %d\n yy is %d\n',xx,yy);

name = 'Shakib';
score = 95.5;
fprintf('%s scored %.1f marks\n', name, score)




