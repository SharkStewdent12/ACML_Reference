function [ y_vector ] = yIndexToVector( y_scalar )
%yIndexToVector Summary of this function goes here
%   Detailed explanation goes here

y_vector = zeros( size(y_scalar,1), 11);

for i = 1:size(y_scalar,1)
    y_vector(i, y_scalar(i)) = 1;    
end %for


end

