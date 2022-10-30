function [Array1] = Reverse_rw219(Array1)
%Reverse the vector's order
[n,~]=size(Array1);
for i=1:(fix(n/2))
    temp=Array1(i);
    Array1(i)=Array1(n+1-i);
    Array1(n+1-i)=temp;
end

