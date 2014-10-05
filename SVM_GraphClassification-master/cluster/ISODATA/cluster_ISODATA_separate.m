function cluster_ISODATA_separate(img)
% disp('separate');
global c z w Nc theS theN k;
sigma = zeros(Nc,c);
for i = 1:Nc
    idx = find(w == i);
    sigma(i,:) = sqrt(sum((img(idx,:)-repmat(z(i,:),length(idx),1)).^2)/length(idx));
    % sigma(i,:) = std(img(idx,:),1); %�����������ʽ����
end
N = Nc;
for i = 1:N
    [~,maxi] = max(sigma(i,:));
    if (sigma(i,maxi)>theS) & ((length(find(w == i))>2*theN) | (Nc<k))
%      disp(['��' num2str(i) '�౻�ָ�']);
       ztemp1 = z(i,:);
       ztemp2 = z(i,:);
       Nc = Nc + 1;
       ztemp1(maxi) = ztemp1(maxi)+0.5*sigma(i,maxi);
       ztemp2(maxi) = ztemp2(maxi)-0.5*sigma(i,maxi);
       z(i,:) = ztemp1;
       z = [z; ztemp2];
    end
end
% disp(['�ָ����' num2str(Nc) '��']);
end