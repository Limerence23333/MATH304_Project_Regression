function [Error] = SquareL2norm_rw219(Data,coef,dimension,lambda)
%UNTITLED6 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
[~,n]=size(Data);
A=GetMatrix_rw219(Data,dimension,lambda);
B=GetY_rw219(Data,dimension,lambda);
ErrorArray=A*coef-B;
Error=0;
for i=1:n
    Error=Error+(ErrorArray(i).^2);
end
Error=Error/n;
end

