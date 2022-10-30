load('TestData.mat');
load('LargeData.mat');
load('SmallData.mat');
TrainError2=zeros(9);
TestError2=zeros(9);
MinTrainError2=realmax('single');
MinTestError2=realmax('single');
MinTrainErrorDim2=0;
MinTestErrorDim2=0;
CoefMatrix2=zeros(10,9);
for i=1:9
    coef2=LSR_rw219(LargeData,i,0); %The only difference in this task is that we substitute the small dataset with a larger one
    CoefMatrix2(1:i+1,i)=coef2;
    Error3=SquareL2norm_rw219(LargeData,coef2,i,0);
    Error4=SquareL2norm_rw219(TestData,coef2,i,0);
    TrainError2(i)=Error3;
    TestError2(i)=Error4;
    if (Error3<MinTrainError2)
        MinTrainError2=Error3;
        MinTrainErrorDim2=i;
    end
    if (Error4<MinTestError2)
        MinTestError2=Error4;
        MinTestErrorDim2=i;
    end
end
x1=LargeData(1,:);
y1=LargeData(2,:);
x2=TestData(1,:);
y2=TestData(2,:);
Coef3=Reverse_rw219(CoefMatrix2(1:MinTrainErrorDim2+1,MinTrainErrorDim2));
Coef4=Reverse_rw219(CoefMatrix2(1:MinTestErrorDim2+1,MinTestErrorDim2));
x3=0:0.01:1;
y3=polyval(Coef3,x3);
y4=polyval(Coef4,x3);
scatter(x1,y1,'+');
hold on;
scatter(x2,y2,'*');
hold on;
plot(x3,y3,'--',x3,y4);
xlabel('x');
ylabel('y');
title('Figure of best fit regression model with large sample');
legend('Train Data','Test Data','Least Train Data Error','Least Test Data Error');