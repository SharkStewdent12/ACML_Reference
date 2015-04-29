function [U] = getU(x,Theta)
%My own added function
%This function implements hypothesis evaluation for parameter vector Theta and input 
%x. The input x can be a single row vector or a matrix representing group
%of features. The result(s) are returned in h.
%x          is a matrix of size (m)     x (ni+1)
%Theta{1}   is a matrix of size (ni+1)  x (n2+1)
%Theta{2}   is a matrix of size (n2+1)  x (n3+1)
%Theta{3}   is a matrix of size (n3+1)  x (n4+1)
%Theta{4}   is a matrix of size (n4+1)  x (no)

L = length(Theta)+1;

U{1} = x;
%preallocating space to improve performance
%size is extracted from size of theta

%{
U{2} = zeros(size(x,1),size(Theta{1},2));
U{3} = zeros(size(x,1),size(Theta{2},2));
U{4} = zeros(size(x,1),size(Theta{3},2));
U{5} = zeros(size(x,1),size(Theta{4},2));
%}

for l = 2:L-1
    U{l} = zeros(size(x,1),size(Theta{l-1},2));
end %for

%displayU(U);
%{
disp('GET U STUFF');
disp('x:');
disp(x(1:5,:));
%}

for l = 1:L-1 %l is for layer
    U{l}(:,1) = 1; %first collumn must always be 1
    
    %{
    disp(['layer: ',num2str(l)]);
    disp(['U{',num2str(l),'}:']);
    disp(U{l}(1:5,:));
    disp(['Theta{',num2str(l),'}:']);
    disp(Theta{l});
    disp('result:');
    result = U{l} * Theta{l};
    disp(result(1:5,:));
    %}
    
    %U{l+1} = g( U{l} * transpose( Theta{l} ) );
    %disp(size(U{l}));
    %disp(size(Theta{l}));
    U{l+1} = g( U{l} * Theta{l} );
    
end %for

%displayU(U);

end %function

function [out] = g(in)
out = 1./(1+exp(-in));
end %function

