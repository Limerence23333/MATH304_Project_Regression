load('TestData.mat');
load('LargeData.mat');
load('SmallData.mat'); %Load the data into the program
TrainError=zeros(9); %Initialize the matrix of Train Error
TestError=zeros(9); %Initialize the matrix of Test Error
MinTrainError=realmax('single'); %Initialize the minimum train error as the largest number
MinTestError=realmax('single');  %Initialize the minimum test error as the largest number
MinTrainErrorDim=0; %Initialize the dimension of the model with minimum train error
MinTestErrorDim=0; %Initialize the dimension of the model with minimum test error
CoefMatrix=zeros(10,9); %Initialize the matrix storing the coeficients of different models
for i=1:9 %Iterate over the nine orders
    coef=LSR_rw219(SmallData,i,0); %Get the coeficient from least square regression model
    CoefMatrix(1:i+1,i)=coef; %Store it in the matrix
    Error1=SquareL2norm_rw219(SmallData,coef,i,0); %Get the train error
    Error2=SquareL2norm_rw219(TestData,coef,i,0); %Get the test error
    TrainError(i)=Error1; %Store train error
    TestError(i)=Error2; %Store test error
    if (Error1<MinTrainError) %Compare current train error with the minimum. if smaller, update the minimum
        MinTrainError=Error1;
        MinTrainErrorDim=i;
    end
    if (Error2<MinTestError) %Similarly, update the minimum test error with the same rule.
        MinTestError=Error2;
        MinTestErrorDim=i;
    end
end
x1=SmallData(1,:);
y1=SmallData(2,:); 
x2=TestData(1,:);
y2=TestData(2,:);
Coef1=Reverse_rw219(CoefMatrix(1:MinTrainErrorDim+1,MinTrainErrorDim)); %Coeficient for the model with least training error
Coef2=Reverse_rw219(CoefMatrix(1:MinTestErrorDim+1,MinTestErrorDim)); %Coeficient for the model with least test error
x3=0:0.01:1;
y3=polyval(Coef1,x3);
y4=polyval(Coef2,x3);
scatter(x1,y1,'+'); %Sketch the train data points
hold on;
scatter(x2,y2,'*'); %Sketch the test data points
hold on;
plot(x3,y3,'--',x3,y4); %Sketch the plot of the two least square curves
xlabel('x');
ylabel('y');
title('Figure of best fit regression model with small sample');
legend('Train Data','Test Data','Least Train Data Error','Least Test Data Error');



    