function [fs,ys,SM] = SampleFeaturesFromImage(RGB,GT,N,L)
%DO NOT ALTER THIS FILE
%Tis function samples N features from positive class, where GT is not equal
%to zero, and returns sampled features in fs and the corresponding labels
%(L) in ys. SM is the sampling matrix for visualization purpose.
[f,y] = ExtractFeaturesFromImage(RGB,GT);
pi = find(GT~=0); %indices of positive samples
if(length(pi)<N)
    N = length(pi);
end

fp = f(pi,:);
v = mean(fp);
v = v / norm(v);
d = sqrt(sum(fp.^2,2));
fpn = fp./repmat(d,1,size(fp,2));
fpd = acos(fpn.*repmat(v,size(fp,1),1));
[fpds,fpdsi] = sort(fpd);
k = round(linspace(1,length(fpds),N));
if(nargout == 3)
    R = RGB(:,:,1);
    G = RGB(:,:,2);
    B = RGB(:,:,3);
    R(pi(fpdsi(k))) = 255;
    G(pi(fpdsi(k))) = 0;
    B(pi(fpdsi(k))) = 0;
    SM = zeros(size(RGB));
    SM(:,:,1) = R;
    SM(:,:,2) = G;
    SM(:,:,3) = B;
    SM = uint8(SM);
end
fpsampled = f(pi(fpdsi(k)),:);
%ypsampled = y(pi(fpdsi(k)),:);
ypsampled = repmat(L,size(fpsampled,1),1);
fs = fpsampled;
ys = ypsampled;
end

