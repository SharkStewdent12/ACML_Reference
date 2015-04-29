function [xn] = Normalize(x,mu,s)
%This function normalizes dataset x using normalization parameters mu ans s
%and returns the normalized matrix in xn. 
%It is assumed that each row of x represents a single data sample and each
%column of x represents a single feature.
xn = x-repmat(mu,size(x,1),1);
xn = xn./repmat(s,size(x,1),1);
end