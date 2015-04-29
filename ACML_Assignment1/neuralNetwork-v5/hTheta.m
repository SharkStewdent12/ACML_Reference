function [h,U] = hTheta(x,Theta)
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
m = size(x,1);

L = length(Theta)+1;

U{1} = x;

for l = 2:L-1
    U{l} = zeros(size(x,1),size(Theta{l-1},2));
end %for

for l = 1:L-1 %l is for layer
    U{l}(:,1) = 1; %first collumn must always be 1
    U{l+1} = g( U{l} * Theta{l} );    
end %for

h = yVectorToIndex(U{L});

end %function

function [out] = g(in)
out = 1./(1+exp(-in));
end