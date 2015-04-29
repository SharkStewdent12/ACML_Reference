%DO NOT ALTER THIS FILE
clear all;
clc;

%Load labeled testing data set.
disp('Loading testing data set...');
[x, y] = LoadTestingDataset();

%Load normalization parameters.
disp('Loading normalization parameters...');
load('normalizationparameters.mat');

%Normalize the testing data set.
disp('Normalizing the testing data set...');
x = Normalize(x,mu,s);

%Compute hypothesis.
disp('Computing hypothesis...');
load('hypothesisparameters.mat');
h = hTheta(x,Theta);

%Compute testing error.
disp('Computing testing error...');
empricalError = sum(h~=y)/length(y);
disp(['Emprical error  = ' num2str(empricalError*100,'%.1f') '%']);
