function wt = cluster_ISODATA_classification(z,X)
% disp('classification');
global r Nc;
wt = zeros(1,r);%每一样本的类别
tempD = zeros(1,Nc); %暂时记录每个样本到Nc个聚类中心的距离
for i = 1:r
    for j = 1:Nc
    tempD(j) = sqrt(sum((X(i,:)-z(j,:)).^2));
    end
    [~,idxC] = min(tempD);%minD:最小距离；idxC:minD对应的聚类中心
    wt(i) = idxC;
end
end