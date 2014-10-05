function [ISODATA_label, ncluster] = cluster_ISODATA(img,K,varargin)
% ISODATA_label = cluster_ISODATA(img,K,varargin)
%             varargin = [thetaN thetaC thetaS L I]
% imputs:
% img��ͼ��������ÿ�д���һ�����ص㣬ÿ��Ϊһ������
% k��Ԥ�ڷֳ��ľ�����
% thetaN��ÿ��������������
% thetaC���������ļ������
% thetaS�����ڱ�׼������
% L��ÿ�ε������ϲ��Ķ���
% I������������
% Nc���ֳ��ľ������

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
z = img(simple,:);%��������λ��
Nc = k;%��ʼ�������ĸ���


%% ����
while Ip < I
%     disp(['��' num2str(Ip) '�ε���']);
    % ����
    w = cluster_ISODATA_classification(z,img);
    
    % �ҳ������������ٵ��࣬ȡ�������¾���
    zdel = [];
    for i = 1:Nc
%       disp(['��' num2str(i) '��:' num2str(length(find(w == i)))]);
        if length(find(w == i)) < theN
%           disp(['��' num2str(i) '��������٣���������']);
            %z(i,:) = [];
            %Nc = Nc - 1;
            % i = i - 1;�����õΣ�����forѭ�����õ�i���κ��ڲ��ı佫������
            zdel = [zdel,i]; %�����ȱ�ǣ����ȥ
        end
    end
    if zdel
        z(zdel,:) = [];
        Nc = Nc - length(zdel);
        w = cluster_ISODATA_classification(z,img);
    end
%   disp(['��ȥ��������ٵ���� Nc = ' num2str(Nc)]);
    
    % ������������ֵ,��������������������ĵ�ƽ������
    Dc = zeros(1,Nc);%������ƽ������ʸ��
    for i = 1:Nc
        idxC = find(w == i);
        z(i,:) = sum(img(idxC,:),1)/length(idxC);
        Dc(i) = sum(sqrt(sum((img(idxC,:)-repmat(z(i,:),length(idxC),1)).^2,2)))/length(idxC);
    end
    
    % �жϷ��ѡ��ϲ���ֹͣ
    if (Nc < k)
%       disp('Nc < k');
        cluster_ISODATA_separate(img);
    elseif (Nc > (k + 2))
%       disp('Nc > (k + 2)');
        cluster_ISODATA_consolidation(img);
    elseif rem(Ip,2)
%       disp('  ��ηָ�');
        cluster_ISODATA_separate(img);
    else
%       disp('  ż�κϲ�');
        cluster_ISODATA_consolidation(img);
    end 
    Ip = Ip +1;
end

ISODATA_label = w;
ncluster = Nc;
end