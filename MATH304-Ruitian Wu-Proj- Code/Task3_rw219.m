load('TestData.mat');
load('LargeData.mat');
load('SmallData.mat');
weight=[1e-6;1e-3;1;1e3;1e6]; %Store the candidates of lambda in the vector 
TestError3=zeros(5,1);
TrainError3=zeros(5,1);
MinTrainError3=realmax('single');
MinTestError3=realmax('single');
MinTrainErrorLv=0;
MinTestErrorDLv=0;
CoefMatrix3=zeros(10,5);
for i=1:5
    coef3=LSR_rw219(SmallData,9,weight(i,1)); %For this task,the dimension stays fixed and we add the lambda restriction
    CoefMatrix3(:,i)=coef3;
    Error5=SquareL2norm_rw219(SmallData,coef3,9,weight(i,1));
    Error6=SquareL2norm_rw219(TestData,coef3,9,weight(i,1));
    TrainError3(i)=Error5;
    TestError3(i)=Error6;
    if (Error5<MinTrainError3)
        MinTrainError3=Error5;
        MinTrainErrorLv=i;
    end
    if (Error6<MinTestError3)
        MinTestError3=Error6;
        MinTestErrorLv=i;
    end
end
x1=SmallData(1,:);
y1=SmallData(2,:);
x2=TestData(1,:);
y2=TestData(2,:);
Coef5=Reverse_rw219(CoefMatrix3(:,MinTrainErrorLv));
Coef6=Reverse_rw219(CoefMatrix3(:,MinTestErrorLv));
x3=0:0.01:1;
y3=polyval(Coef5,x3);
y4=polyval(Coef6,x3);
scatter(x1,y1,'+');
hold on;
scatter(x2,y2,'*');
hold on;
plot(x3,y3,'--',x3,y4);
xlabel('x');
ylabel('y');
title('Figure of best constrained fit regression model with small sample');
legend('Train Data','Test Data','Least Train Data Error','Least Test Data Error');
    