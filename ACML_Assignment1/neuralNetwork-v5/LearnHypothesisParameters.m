function [Theta,empricalError] = LearnHypothesisParameters(x,y,learning_rate)
%ALTER THIS FILE ACCORDING TO YOUR DESIGN CHOICE
%This function learns parameters of the hypothesis. It minimizes a cost fuction with regularization. 
%Each row of input matrix x is referring to a sample from training set and the
%corresponding row in y vector is referring to the sample's label.
%The parameter 'learning_rate' is  learning rate used in learning hypothesis parameter values.
%The function returns learned parameters (theta) and the corresponding emprical error (emprical_error) in %.

%% Constants 

%For testing on smaller datasets only
% dataCutPoint = 6600; %6600 gives a full training set, 600 per colour
% x = x(1:dataCutPoint,:);
% y = y(1:dataCutPoint,:);

numLayers = 5;
epsilon = 1e-2;
displayRate = 5;
m = size(x,1);
d = size(x,2);
ni = d-1;
no = 11;
eps= 1e-1;
y_vector = yIndexToVector(y);

%% Initialisation

isConverged = 0;
iterationNumber = 1;
%hThreshold = 0.5;
empricalError = 1.0;
minEmpErr = 1;
minEmpErrIt = 1;
minDelta = 1e2;
minDeltaIt = 1;

%% Initialize Theta and U
ni = d-1;
n2 = 8;
n3 = 20;
n4 = 15;
no = 11;

% diffs = zeros(1,numLayers-1);

Theta{1} = randn(ni+1,n2+1)*eps;
Theta{2} = randn(n2+1,n3+1)*eps;
Theta{3} = randn(n3+1,n4+1)*eps;
Theta{4} = randn(n4+1,no)*eps;

delta{2} = zeros(1,n2+1);
delta{3} = zeros(1,n3+1);
delta{4} = zeros(1,n4+1);
delta{5} = zeros(1,no);

%set to be last layer - For different layer set ups
% Theta{1} = randn(ni+1,no)*eps;
% Theta{2} = randn(n2+1,no)*eps;
% Theta{3} = randn(n3+1,no)*eps;

%% Loop

disp('The line of numbers show the amount of data points identified as each colour');

while( isConverged == 0 )    
    %% Run neural network
    Theta_old = Theta;          
    
    for i = 1:m % for each data point         
        %% forward propogation
        
        [~,U] = hTheta( x(i,:), Theta);        
        
        %% update by back-propogation
        delta{numLayers} = (U{numLayers} - y_vector(i,:)) ./ (partialU(U{numLayers}));                
        
        for l = numLayers-1:-1:1       
                        
            grad{l} = transpose(U{l}) * ( delta{l+1} .* partialU(U{l+1}) );
            Theta{l} = Theta{l} - learning_rate * grad{l};
            
            delta{l} = (delta{l+1} .* partialU(U{l+1})) * transpose(Theta{l}); %for next iteration
        end %for                   
        
    end% for    
    
         
    %% Check convergence
    maxDiff = 0;    
    for k = 1:length(Theta)        
        maxDiff = max( [maxDiff, max(abs(Theta{k}-Theta_old{k}))]);
    end %for

    if(maxDiff < epsilon)
        isConverged = 1;
    end %if
    %% display progress      

    [h,~] = hTheta(x,Theta);
    
    empricalError = sum(y ~= h )/length(y);

    if (empricalError <= minEmpErr)
        minEmpErr = empricalError;
        minEmpErrIt = iterationNumber;
    end %if
    
    if (maxDiff <= minDelta)
        minDelta = maxDiff;
        minDeltaIt = iterationNumber;
    end %if     

    if((mod(iterationNumber,displayRate)==0) || (iterationNumber==1))

        disp(['iteration # = ' num2str(iterationNumber) ', emprical error = ' num2str(empricalError*100,'%.1f') '%, delta = ' num2str(maxDiff),', min Error = ',num2str(minEmpErr*100,'%.1f'),'% (iteration ',num2str(minEmpErrIt),')' ,', min Delta = ',num2str(minDelta),' (iteration ',num2str(minDeltaIt),')']);

        disp( sum( yIndexToVector( h ) ) ); %shows the amount of inputs identified as each colour
%         displayThetaChanges(Theta,Theta_old);    
    end %if
    
    %% iterate
    iterationNumber = iterationNumber + 1;
    %break;

end %while



end


function [ uOut ] = partialU( u )    
    uOut = u .* (1.-u);    
end %function

function displayThetaChanges(Theta,Theta_old)
      
    for k = 1:length(Theta)
        disp(['Theta{',num2str(k),'}:']);
        disp(num2str([Theta{k},Theta_old{k}-Theta{k}]));

    end %for 

end %function