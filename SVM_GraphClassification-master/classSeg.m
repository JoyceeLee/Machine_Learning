function [classL,M] = classSeg(clusterLab, ncluster)
L = zeros(size(clusterLab));%������ͨ������ͬһ����Ŀ�ֿ�
M = 0;
temp = 0;
for i = 1:ncluster %��ɢ��������ʹ����ͨ����ֱ���
    [l m] = bwlabel(clusterLab == i, 4);
    L = L + logical(l)*M + l;
    M = M + m; 
end
    classL = L;
end