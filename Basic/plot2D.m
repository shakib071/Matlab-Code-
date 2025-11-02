x = 0:0.1:2*pi;
y1 = sin(x);
y2 = cos(x);

plot(x,y1,'r',x,y2,'b--')
legend('sin(x)','cos(x)')
title('Sine and Cosine')
grid on 

%plot(x, y1, 'o-g') % circle markers, green line

%| Style                      | Meaning                 |
%| -------------------------- | ----------------------- |
%| `'o'`                      | circle marker           |
%| `'-'`                      | solid line              |
%| `'--'`                     | dashed line             |
%| `':'`                      | dotted line             |
%| `'r'`, `'g'`, `'b'`, `'k'` | red, green, blue, black |


