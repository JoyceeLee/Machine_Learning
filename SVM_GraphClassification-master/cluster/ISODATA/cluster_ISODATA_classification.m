function wt = cluster_ISODATA_classification(z,X)
% disp('classification');
global r Nc;
wt = zeros(1,r);%ÿһ���������
tempD = zeros(1,Nc); %��ʱ��¼ÿ��������Nc���������ĵľ���
for i = 1:r
    for j = 1:Nc
    tempD(j) = sqrt(sum((X(i,:)-z(j,:)).^2));
    end
    [~,idxC] = min(tempD);%minD:��С���룻idxC:minD��Ӧ�ľ�������
    wt(i) = idxC;
end
end