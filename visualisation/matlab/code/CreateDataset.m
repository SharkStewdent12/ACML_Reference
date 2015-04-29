%DO NOT ALTER THIS FILE
clc;
clear all;
%colour names
k = 1;
colourNames{k} = 'black'; k = k + 1;
colourNames{k} = 'blue'; k = k + 1;
colourNames{k} = 'brown'; k = k + 1;
colourNames{k} = 'green'; k = k + 1;
colourNames{k} = 'grey'; k = k + 1;
colourNames{k} = 'orange'; k = k + 1;
colourNames{k} = 'pink'; k = k + 1;
colourNames{k} = 'purple'; k = k + 1;
colourNames{k} = 'red'; k = k + 1;
colourNames{k} = 'white'; k = k + 1;
colourNames{k} = 'yellow';

%object names
dataFolder = '../ebay';
folderSeperator = '/';
d = dir(dataFolder);
isub = [d(:).isdir];
objectFolders = {d(isub).name}';
objectFolders(ismember(objectFolders,{'.','..'})) = [];

%number of samples per image
samplesPerImage = 100;

xtraining = [];
ytraining = [];
xtesting = [];
ytesting = [];
for o = 1:length(objectFolders)
    for c = 1:length(colourNames)
        colourFolder = [dataFolder folderSeperator objectFolders{o} folderSeperator colourNames{c}];
        disp(['Processing ->' colourFolder]);
        for f = 1:12
            %read in image
            rgb = imread([colourFolder folderSeperator num2str(f,'%03d') '.jpg']);
            %read in ground-truth image
            gt = imread([colourFolder folderSeperator num2str(f,'%03d') '_MASK.png']);
            %figure(1),imshow(rgb);
            %figure(2),imshow(gt);
            %sample features from image
            [fs,ys,sm] = SampleFeaturesFromImage(rgb,gt,samplesPerImage,c);
            %figure(3),imshow(sm);
            if(f < 7)
                xtraining = [xtraining; fs];
                ytraining = [ytraining; ys];
            else
                xtesting = [xtesting; fs];
                ytesting = [ytesting; ys];
            end            
        end
    end
end
disp('saving training data set');
X = xtraining;
Y = ytraining;
save('trainingdataset.mat','X','Y');

disp('saving testing data set');
X = xtesting;
Y = ytesting;
save('testingdataset.mat','X','Y');

