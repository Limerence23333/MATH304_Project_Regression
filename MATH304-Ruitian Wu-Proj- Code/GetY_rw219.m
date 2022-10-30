function [y] = GetY_rw219(Data,dim,lambda)
% This function is used to extract the vector B from the y values in the
% data.
[~,n]=size(Data);
if lambda==0 %if lambda=0,then the vector needn't to be extended.
    y=zeros(n,1);
    for i=1:n
        y(i,1)=Data(2,i);
    end
else %if lambda!=0,then the vector B should be extended to a form with 0s on the bottom.
    y=zeros(n+dim+1,1);
    for i=1:n
        y(i,1)=Data(2,i);
    end
    for i=n+1:n+dim+1
        y(i,1)=0;
    end
end



