clear all;
clc;
close all;

%Load labeled training data set.
disp('Loading trainig data set...');
[x, y] = LoadTrainingDataset();

%cluster black(1) blue(2) green(4) red(9)


indices = [1 2 4 9];

k = 1;
colourNames{k} = 'ko'; k = k + 1; % k means black, o means circle
colourNames{k} = 'bo'; k = k + 1;
colourNames{k} = 'go'; k = k + 1;
colourNames{k} = 'ro'; k = k + 1;

xSampled = [];
ySampled = [];
for i = 1:length(indices)
    index = find(y==indices(i));
    xSampled = [xSampled; x(index,:)];
    ySampled = [ySampled; i*ones(length(index),1)];
end
   
x = xSampled;
y = ySampled;

%%Principal Component Analysis
mu = mean(x);

%plot mean
figure,plot(mu),title('Mean');

%find standard deviation of each component
s = std(x);

%plot the standard deviation vector
figure,plot(s),title('Standard Deviation');

%sort s
[sorted_values, sorted_indices] = sort(s,'descend');

%plot 2D
D = 2; %number of features that we will use
xs = x(:, sorted_indices(1:D));

%plot 2D x
figure,hold on;
for i = 1:size(x,1)
    plot(xs(i,1),xs(i,2),colourNames{y(i)});    
end

%plot 3D
D = 3; %number of features that we will use
xs = x(:, sorted_indices(1:D));

%plot 3D x
figure,hold on;
for i = 1:size(x,1)
    plot3(xs(i,1),xs(i,2),xs(i,3),colourNames{y(i)});    
end
box on;


%% doing PCA

%get nomalised matrix
xx = x;
xx = xx - repmat(mu,size(xx,1),1);
xx = xx ./ (repmat(s,size(xx,1),1)+1e-16);

%get covarience matrix
C = 1/size(xx,1) * (xx' * xx);
%visualise with command: figure,imshow(C,[])

D = eye(size(C)) * 1e-16; %to help us find C's inverse
C = C + D;

%patterns reveal redundancies, symmetry accross diagonal

%get eigen vectors of covarience matrix
%helps identify repeated columns (redundancies)
[EigenVectors,EigenValues] = eig(C); %unstable, won't always return sorted
%show with: plot(diag(EigenValues))

%sort by eigenvalues (also getting most important)
%diag are the eigenvalues
e = diag(EigenValues);
[e_values, e_indices] = sort( abs(e), 'descend' ); %abs (norm) to deal with complex eigenvalues

D = 2;
E = EigenVectors(:,e_indices(1:D));

xxProjected = xx * E; %dimensions: 9600x30 * 30x2 = 9600x2

%plot 2D x
figure,hold on;
for i = 1:size(x,1)
    plot(xxProjected(i,1),xxProjected(i,2),colourNames{y(i)});    
end

%3D
D = 3;
E = EigenVectors(:,e_indices(1:D));

xxProjected = xx * E; %dimensions: 9600x30 * 30x2 = 9600x2

%plot 3D x
figure,hold on;
for i = 1:size(x,1)
    plot3(xxProjected(i,1),xxProjected(i,2),xxProjected(i,3),colourNames{y(i)});    
end
box on;
    