function [f,y] = ExtractFeaturesFromImage(RGB,GT)
%ALTER THIS FILE ACCORDING TO YOUR DESIGN CHOICE
%This function extracts color features (f) from input image RGB and labels
%features according to ground-truth GT to produce the corresponding lable vector (y).
k = 1;
[H,W,D] = size(RGB);
S = H*W;

%feature set #1
% data{k}{1} = double(RGB(:,:,1));
% data{k}{2} = double(RGB(:,:,2));
% data{k}{3} = double(RGB(:,:,3));

% %feature set #2
YCbCr       = colorspace('RGB->YCbCr',RGB);
data{k}{1}  = YCbCr(:,:,2); data{k}{2}  = YCbCr(:,:,3); k = k + 1;

YUV         = colorspace('RGB->YUV',RGB);
data{k}{1}  = YUV(:,:,2); data{k}{2}  = YUV(:,:,3); k = k + 1;

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

HSV         = colorspace('RGB->HSV',RGB);
data{k}{1}  = HSV(:,:,1); data{k}{2}  = HSV(:,:,2); k = k + 1;

k = 1;
% x(:,:,k) = ones(H,W);
% k = k + 1;
% epsilon = 1;
for i = 1:length(data)
    %feature set #1
%     x1 = data{i}{1}./(data{i}{1}+data{i}{2}+data{i}{3}+epsilon);
%     x2 = data{i}{2}./(data{i}{1}+data{i}{2}+data{i}{3}+epsilon);
%     x3 = data{i}{3}./(data{i}{1}+data{i}{2}+data{i}{3}+epsilon);
%     x(:,:,k) = x1;
%     k = k + 1;
%     x(:,:,k) = x2;
%     k = k + 1;
%     x(:,:,k) = x3;
%     k = k + 1;
%     %feature set #2
    x(:,:,k) = data{i}{1};
    k = k + 1;
    x(:,:,k) = data{i}{2};
    k = k + 1;
    x(:,:,k) = data{i}{1} - data{i}{2};
    k = k + 1;
    x(:,:,k) = data{i}{1}.*data{i}{2};
    k = k + 1;
    x(:,:,k) = data{i}{1}.^2;
    k = k + 1;
    x(:,:,k) = data{i}{2}.^2;
    k = k + 1;
end

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