function [X] = LSR_rw219(Data,dimension,lambda)
%This is the function to calculate the least squared solution to the
%equation AX=B
A=GetMatrix_rw219(Data,dimension,lambda); %Get A for the equation
B=GetY_rw219(Data,dimension,lambda); %Get B for the equation
AT=transpose(A);
AAT=AT*A;
ATB=AT*B;
X=AAT\ATB; %The least square solution is calculated with the formula:X=(ATA)^-1*(ATB)
end 
