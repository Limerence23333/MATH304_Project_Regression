load('TestData.mat');
load('LargeData.mat');
load('SmallData.mat');
Set1=zeros(2,20);
Set2=zeros(2,20);
Set3=zeros(2,20);
Set4=zeros(2,20);
Set5=zeros(2,20); %Initialize the 5 subsets of the big dataset (without randomization)
weight=[1e-6;1e-3;1;1e3;1e6];
LargeData2=Randomization_rw219(LargeData);
for i=1:5:100
    Set1(:,ceil(i/5))=LargeData2(:,i);
    Set2(:,ceil(i/5))=LargeData2(:,i+1);
    Set3(:,ceil(i/5))=LargeData2(:,i+2);
    Set4(:,ceil(i/5))=LargeData2(:,i+3);
    Set5(:,ceil(i/5))=LargeData2(:,i+4); %Categorize the big dataset into five subsets based on the rule that every 5 data should be in the same subset
end
TrainSet1=[Set2 Set3 Set4 Set5]; 
TrainSet2=[Set1 Set3 Set4 Set5];
TrainSet3=[Set1 Set2 Set4 Set5];
TrainSet4=[Set1 Set2 Set3 Set5];
TrainSet5=[Set1 Set2 Set3 Set4]; %For each combination of 4 subsets, catenate them into a training group
SetAll(:,:,1)=Set1;
SetAll(:,:,2)=Set2;
SetAll(:,:,3)=Set3;
SetAll(:,:,4)=Set4;
SetAll(:,:,5)=Set5;
TrainSetAll(:,:,1)=TrainSet1;
TrainSetAll(:,:,2)=TrainSet2;
TrainSetAll(:,:,3)=TrainSet3;
TrainSetAll(:,:,4)=TrainSet4;
TrainSetAll(:,:,5)=TrainSet5; %Use two 3D array to store the traininig sets and test sets
MinError=realmax('single');
MinErrorLv=0;
ErrorSet=zeros(5,1);
for i=1:5
    Error=0;
    for j=1:5
        coef4=LSR_rw219(TrainSetAll(:,:,j),9,weight(i,1));
        error=SquareL2norm_rw219(SetAll(:,:,j),coef4,9,weight(i,1));
        Error=Error+error;
    end
    Error=Error/5; %Calculate the average error foe each lambda
    ErrorSet(i,1)=Error;
    if Error<MinError
        MinError=Error;
        MinErrorLv=i; 
    end 
end
BestLambda=weight(MinErrorLv,1); %Find out the lambda with the smallest error
BestCoef=LSR_rw219(LargeData,9,BestLambda); %Use the lambda to build a regression model based on the large dataset
BestError=SquareL2norm_rw219(TestData,BestCoef,9,BestLambda); %Calculate the error based on the test data
disp(BestCoef);
disp(BestLambda);
disp(BestError);
        
    
        
        