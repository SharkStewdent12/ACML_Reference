function [ y_index ] = yVectorToIndex( y_vector )
%yVectorToIndex Summary of this function goes here
%   Detailed explanation goes here

%Need to truncate

%make one 1 and others 0

%{
y_scalar = zeros( size(y_vector,1), 1);

for i = 1:size(y_vector,1)
    y_scalar(i) = y_vector(i,:) * transpose(1:11);    
end %for
%}

[~,y_index] = max(y_vector,[],2); %The position of the max value (most true) gives the color index


end

