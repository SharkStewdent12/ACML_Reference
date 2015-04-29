function [Theta,empricalError] = LearnHypothesisParameters(x,y,learning_rate)
%ALTER THIS FILE ACCORDING TO YOUR DESIGN CHOICE
%This function learns parameters of the hypothesis. It minimizes a cost fuction with regularization. 
%Each row of input matrix x is referring to a sample from training set and the
%corresponding row in y vector is referring to the sample's label.
%The parameter 'learning_rate' is  learning rate used in learning hypothesis parameter values.
%The function returns learned parameters (theta) and the corresponding emprical error (emprical_error) in %.
m = size(x,1);
d = size(x,2);
%randomly initialize Theta
ni = d-1;
n2 = round(d/2);
n3 = round(d/4);
n4 = round(d/8);
no = 1;
eps= 1e-1;
Theta{1} = randn(ni+1,n2+1)*eps;
Theta{2} = randn(n2+1,n3+1)*eps;
Theta{3} = randn(n3+1,n4+1)*eps;
Theta{4} = randn(n3+1,no)*eps;

isConverged = 0;
epsilon = 1e-5;
iterationNumber = 1;
displayRate = 5;
hThreshold = 0.5;
empricalError = 1.0;

end