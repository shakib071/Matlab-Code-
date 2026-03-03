function f = fibonacci1(n)
% Return first n Fibonacci numbers as integers

f = zeros(1, n, 'uint64');  % preallocate as uint64
f(1) = 0;
f(2) = 1;

for i = 3:n
    f(i) = f(i-2) + f(i-1);
end

fprintf('First %d Fibonacci numbers are:\n', n);
disp(f)
end

fibonacci1(10);

