function [ Theta ] = updateTheta( Theta, U, y, learning_rate )
%UPDATETHETA Summary of this function goes here
%   Detailed explanation goes here

%U = getU(x,Theta);

m = size(U{1},1); %input size

L = length(U);

%delta
delta{L} = U{L} - y;

%delta{L} = mean(U{L} - y);


for l = L-1:-1:1    
    delta{l} = (delta{l+1} .* partialU(U{l+1})) * transpose(Theta{l});
    
end %for
%disp(size(delta));


%gradient
for l = L-1:-1:1
    grad{l} = transpose(U{l}) * ( delta{l+1} .* partialU(U{l+1}) )./m;
    Theta{l} = Theta{l} - learning_rate * grad{l};
end %for

end %function

function [ uOut ] = partialU( u )
    uOut = u .* (1.-u);
    %uOut = (u .* (1.-u)) + 1e-7 ;
end %function

