function [cluster_lab, ncluster] = clusters(img, imgGT, method)

K = max(imgGT(:));
[imgr,imgc,imgh] = size(img);
img = reshape(img,imgr*imgc,imgh);
img_label = imgGT(:);
idx=find(img_label~=0);
img=img(idx,:);
img = zscore(double(img));

%% 聚类分析
switch method
    case 'kmeans'
        [label,ncluster] = cluster_kmeans(img, K);
    case 'ISODATA'
        [label,ncluster] = cluster_ISODATA(img, K);
    case 'EM'
        [label,ncluster] = cluster_EM(img, K);
    otherwise
        disp('the method is not appear');
end

%% 聚类分割结果
cluster_lab = zeros(size(imgGT));
cluster_lab(idx) = label;





