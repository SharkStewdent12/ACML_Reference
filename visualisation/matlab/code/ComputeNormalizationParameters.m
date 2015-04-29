function [mu, s] = ComputeNormalizationParameters(x)
% This function computes normalization parameters of input matrix x. It
% is assumed that each row of x represents a data sample and each
% column of x represents a single feature. The normalization parameters mu
% and s are the mean and the standard deviation of features,
% respectively.

mu = mean(x);
s  = std(x);
mu(1) = 0;
s(1) = 1;

end