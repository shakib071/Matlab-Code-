C = {1, 'Shakib', [2 3 4], true};
C{2}     % returns 'Shakib'
C{3}(2)  % returns 3 (second element of that vector)


person.name = 'Shakib';
person.age = 22;
person.marks = [90 85 88];


A=person.name
B=person.marks(2)

%person.getAge()  % ← invalid, no methods in struct