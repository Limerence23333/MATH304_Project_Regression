function [Matrix] = GetMatrix_rw219(Data,dim,lambda)
%This function is used to transform the 'x' in the data to the Matrix A based on the data, dimension of
%regression and whether there is a restriction of lambda.

[~,n]=size(Data);
if lambda==0 %if lambda=0,then the matrix doesn't need to be extended
    Matrix=zeros(n,dim+1);
    for i=1:n
        for j=0:dim
            Matrix(i,j+1)=Data(1,i).^j;
        end
    end
else %if lambda!=0, then the matrix needs to be extended to a form with lambda
    Matrix=zeros(n+dim+1,dim+1);
    for i=1:n
        for j=0:dim
            Matrix(i,j+1)=Data(1,i).^j;
        end
    end
    for i=n+1:n+dim+1
        Matrix(i,i-n)=sqrt(lambda);
    end
end


