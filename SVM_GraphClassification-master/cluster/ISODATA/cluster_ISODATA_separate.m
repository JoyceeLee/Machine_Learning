function cluster_ISODATA_separate(img)
% disp('separate');
global c z w Nc theS theN k;
sigma = zeros(Nc,c);
for i = 1:Nc
    idx = find(w == i);
    sigma(i,:) = sqrt(sum((img(idx,:)-repmat(z(i,:),length(idx),1)).^2)/length(idx));
    % sigma(i,:) = std(img(idx,:),1); %可以用这个公式代替
end
N = Nc;
for i = 1:N
    [~,maxi] = max(sigma(i,:));
    if (sigma(i,maxi)>theS) & ((length(find(w == i))>2*theN) | (Nc<k))
%      disp(['第' num2str(i) '类被分割']);
       ztemp1 = z(i,:);
       ztemp2 = z(i,:);
       Nc = Nc + 1;
       ztemp1(maxi) = ztemp1(maxi)+0.5*sigma(i,maxi);
       ztemp2(maxi) = ztemp2(maxi)-0.5*sigma(i,maxi);
       z(i,:) = ztemp1;
       z = [z; ztemp2];
    end
end
% disp(['分割后有' num2str(Nc) '类']);
end