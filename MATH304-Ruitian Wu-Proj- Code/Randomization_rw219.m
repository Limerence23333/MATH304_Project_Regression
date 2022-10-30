function [LargeData2] = Randomization_rw219(LargeData)
%Rearrange the order ot the data in a random way.
%
LargeData2=zeros(2,100);
a=randperm(100);
for i=1:100
    index=a(i);
    LargeData2(:,i)=LargeData(:,index);
end
end

