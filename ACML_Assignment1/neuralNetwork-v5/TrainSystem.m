clear all;
clc;
close all;

%Load labeled training data set.
disp('Loading trainig data set...');
[x, y] = LoadTrainingDataset();

%Compute normalization parameters.
disp('Computing normalization parameters...');
[mu,s] = ComputeNormalizationParameters(x);
save('normalizationparameters.mat','mu','s');

%Normalize the trainig data set.
disp('Normalizing data set...');
x = Normalize(x,mu,s);

%Learn hypothesis parameters
disp('Learning hypothesis parameters...');
learningRate = 0.01;
% learningRate = 0.001;
% learningRate = 0.0001;
% learningRate = 0.00001;
[Theta,empricalError] = LearnHypothesisParameters(x,y,learningRate);
disp(['Emprical error  = ' num2str(empricalError*100,'%.1f') '%']);
save('hypothesisparameters.mat','Theta');
