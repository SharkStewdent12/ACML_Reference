function [x,y] = LoadTestingDataset()
%DO NOT ALTER THIS FILE
%This function loads a training data set and returns training data samples in
%x and the corresponding labels in y.
load('testingdataset.mat');
x = X;
y = Y;
end