function [classL,M] = classSeg(clusterLab, ncluster)
L = zeros(size(clusterLab));%将不连通但属于同一聚类的块分开
M = 0;
temp = 0;
for i = 1:ncluster %打散聚类结果，使不连通的类分别开来
    [l m] = bwlabel(clusterLab == i, 4);
    L = L + logical(l)*M + l;
    M = M + m; 
end
    classL = L;
end