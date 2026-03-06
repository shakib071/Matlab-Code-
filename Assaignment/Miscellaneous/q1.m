V = [5, 17, -3, 8, 0, -7, 12, 15, 20, -6, 6, 4, -7, 16];

disp('Original V : ');
disp(V);

for i=1:length(V)

    if V(i)>0 && (mod(V(i),3)==0 || mod(V(i),5) == 0)
        V(i) = 2*V(i);
    elseif V(i) < 0 && V(i)>-5
        V(i) = V(i)^3;
    end
end

disp('Modified V : ');
disp(V);

