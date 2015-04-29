function [h] = hTheta(x,Theta)
%ALTER THIS FILE ACCORDING TO YOUR DESIGN CHOICE
%This function implements hypothesis evaluation for parameter vector Theta and input 
%x. The input x can be a single row vector or a matrix representing group
%of features. The result(s) are returned in h.
%x          is a matrix of size (m)     x (ni+1)
%Theta{1}   is a matrix of size (ni+1)  x (n2+1)
%Theta{2}   is a matrix of size (n2+1)  x (n3+1)
%Theta{3}   is a matrix of size (n3+1)  x (n4+1)
%Theta{4}   is a matrix of size (n4+1)  x (no)
h = zeros(size(x,1),1);

end

function [out] = g(in)
out = 1./(1+exp(-in));
end