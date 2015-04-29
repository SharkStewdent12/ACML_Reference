function [f,y] = ExtractFeaturesFromImage(RGB,GT)
%ALTER THIS FILE ACCORDING TO YOUR DESIGN CHOICE
%This function extracts color features (f) from input image RGB and labels
%features according to ground-truth GT to produce the corresponding lable vector (y).
k = 1;
[H,W,D] = size(RGB);
S = H*W;

%feature set #1
data{k}{1} = double(RGB(:,:,1));
data{k}{2} = double(RGB(:,:,2));
data{k}{3} = double(RGB(:,:,3));

k = k + 1;

% %feature set #2
% YCbCr       = colorspace('RGB->YCbCr',RGB);
% data{k}{1}  = YCbCr(:,:,2); data{k}{2}  = YCbCr(:,:,3); k = k + 1;
% 
% YUV         = colorspace('RGB->YUV',RGB);
% data{k}{1}  = YUV(:,:,2); data{k}{2}  = YUV(:,:,3); k = k + 1;
% 
Lab         = colorspace('RGB->Lab',RGB);
data{k}{1}  = Lab(:,:,2); data{k}{2}  = Lab(:,:,3); k = k + 1;
% 
% % Lch         = colorspace('RGB->Lch',RGB);
% % data{k}{1}  = Lch(:,:,2); data{k}{2}  = Lch(:,:,3); k = k + 1;
% %
% % YIQ         = colorspace('RGB->YIQ',RGB);
% % data{k}{1}  = YIQ(:,:,2); data{k}{2}  = YIQ(:,:,3); k = k + 1;
% 
HSI         = colorspace('RGB->HSI',RGB);
data{k}{1}  = HSI(:,:,1); data{k}{2}  = HSI(:,:,2); k = k + 1;
% 
% HSV         = colorspace('RGB->HSV',RGB);
% data{k}{1}  = HSV(:,:,1); data{k}{2}  = HSV(:,:,2); k = k + 1;

k = 1;
x(:,:,k) = ones(H,W);
k = k + 1;
epsilon = 1;



    %feature set #1
    
    x1 = data{1}{1}./(data{1}{1}+data{1}{2}+data{1}{3}+epsilon); %redness
    x2 = data{1}{2}./(data{1}{1}+data{1}{2}+data{1}{3}+epsilon); %greenness
    x3 = data{1}{3}./(data{1}{1}+data{1}{2}+data{1}{3}+epsilon); %blueness
    x(:,:,k) = x1;
    k = k + 1;
    x(:,:,k) = x2;
    k = k + 1;
    x(:,:,k) = x3;
    k = k + 1;

%     %feature set #2
    %Lab
     x(:,:,k) = data{2}{1}; %Lab a
     k = k + 1;
     x(:,:,k) = data{2}{2}; %Lab b
     k = k + 1;
     %HSI
     %ignore hue, not useful
%      x(:,:,k) = data{3}{1};
%      k = k + 1;
     x(:,:,k) = data{3}{2}; %saturation 
     k = k + 1; 
     intensity = (data{1}{1}+data{1}{2}+data{1}{3}) / 3; %intensity
     x(:,:,k) = intensity;    
     k = k + 1;       
     

k = size(x,3);
f = zeros(S, k);
for i = 1:k
    f(:,i) = reshape(x(:,:,i),S,1);
end
if(~isempty(GT))
    y = double(double(reshape(GT,S,1))~=0);
else
    y = [];
end

end