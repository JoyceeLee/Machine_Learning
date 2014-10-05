function [ISODATA_label, ncluster] = cluster_ISODATA(img,K,varargin)
% ISODATA_label = cluster_ISODATA(img,K,varargin)
%             varargin = [thetaN thetaC thetaS L I]
% imputs:
% img：图像样本，每行代表一个像素点，每列为一类属性
% k：预期分出的聚类数
% thetaN：每类最少样本点数
% thetaC：两类中心间距下限
% thetaS：类内标准差上限
% L：每次迭代最多合并的对数
% I：最多迭代次数
% Nc：分出的聚类个数

global r c z w Nc theC theS theN L k;

if nargin>2 theN = varargin(1);
else theN = 1;
end
if nargin>3 theC = varargin(2);
else theC = 2;
end
if nargin>4 theS =  varargin{3};
else theS = 1;
end
if nargin>5 L = varargin{4};
else L = 2;
end
if nargin>6 I = varargin{5};
else I = 8;
end

k = K;
Ip = 1;
[r,c] = size(img);
simple = round(10366*rand(1,16));
% simple = 1000:50:1750;
z = img(simple,:);%聚类中心位置
Nc = k;%初始聚类中心个数


%% 迭代
while Ip < I
%     disp(['第' num2str(Ip) '次迭代']);
    % 分类
    w = cluster_ISODATA_classification(z,img);
    
    % 找出样本个数过少的类，取消，重新聚类
    zdel = [];
    for i = 1:Nc
%       disp(['第' num2str(i) '类:' num2str(length(find(w == i)))]);
        if length(find(w == i)) < theN
%           disp(['第' num2str(i) '类个数过少，将被消除']);
            %z(i,:) = [];
            %Nc = Nc - 1;
            % i = i - 1;不管用滴，对于for循环中用的i，任何内部改变将被忽视
            zdel = [zdel,i]; %所以先标记，后除去
        end
    end
    if zdel
        z(zdel,:) = [];
        Nc = Nc - length(zdel);
        w = cluster_ISODATA_classification(z,img);
    end
%   disp(['除去样本点过少的类后 Nc = ' num2str(Nc)]);
    
    % 修正聚类中心值,计算各类中样本到其中心的平均距离
    Dc = zeros(1,Nc);%各类内平均距离矢量
    for i = 1:Nc
        idxC = find(w == i);
        z(i,:) = sum(img(idxC,:),1)/length(idxC);
        Dc(i) = sum(sqrt(sum((img(idxC,:)-repmat(z(i,:),length(idxC),1)).^2,2)))/length(idxC);
    end
    
    % 判断分裂、合并或停止
    if (Nc < k)
%       disp('Nc < k');
        cluster_ISODATA_separate(img);
    elseif (Nc > (k + 2))
%       disp('Nc > (k + 2)');
        cluster_ISODATA_consolidation(img);
    elseif rem(Ip,2)
%       disp('  奇次分割');
        cluster_ISODATA_separate(img);
    else
%       disp('  偶次合并');
        cluster_ISODATA_consolidation(img);
    end 
    Ip = Ip +1;
end

ISODATA_label = w;
ncluster = Nc;
end