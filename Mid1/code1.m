function  code1(p,q,n)
    th=linspace(0,2*pi,100);
    for r=1:n
     hold on
     x=p+r*cos(th);
     y=q+r*sin(th);
     plot(x,y,p,q,"+");
     xlabel('X-Axis');
     ylabel('Y-Axis');
     title('Circles with various radii')
     axis('equal')
    end
end 