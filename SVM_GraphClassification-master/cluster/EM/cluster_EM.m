function [EM_label,ncluster] = cluster_EM(img,K)
% EM algorithm
% input

% use 'kmeans' to generate initial parameter
% probability of every cluster -- P(i)【priors(1,K)】
% center of every cluster -- 【Miu(K,D)】
% cluster label of every point -- 【L(N,1)】
% covariance of every cluster -- 【sigma(D,D,K)】
priors = zeros(1,K);
[N, D] = size(img);
[L, Miu] = kmeans(img, K);
sigma = zeros(D,D,K);
for i = 1:K
    lab = find(L==i);
    priors(i) = length(lab);
    sigma(:,:,i) = cov([img(lab,:);img(lab,:)],1);%%以防某类只有一个样本点
    sigma(:,:,i) = sigma(:,:,i) + 1e-5.*diag(ones(D,1));
end
priors = priors./sum(priors);
nStep = 1;

while nStep < 1000
%% E-step
% probability of simple x belong to cluster i -- P(x|i)【pxi(N,K)】
pxi = zeros(N,K);
for i = 1:K
    pxi(:,i) = cluster_EM_gaussPrb(img, Miu(i,:), sigma(:,:,i));
end
% posterior probability after observation -- P(i|x)【pix(N,K)】
pix_temp =repmat(priors,[N 1]).* pxi;
pix = pix_temp ./ repmat(sum(pix_temp, 2),[1 K]);
E = sum(pix);

%% outputs
for i = 1:N
    [~,EM_label(i)] = max(pxi(i,:));
end
ncluster = length(unique(EM_label));

%% initiation of loglik
if nStep == 1
    % probability of every point -- 【px(N,1)】
    px = pxi * priors';  
    px(find(px<realmin)) = realmin;  
    loglik_old = mean(log(px)); 
    loglik_threshold = 1e-3;
end

%% M-step
for i = 1:K
    % update the priors
    priors(i) = E(i) / N;
    % update the centers
    Miu(i,:) = pix(:,i)' * img / E(i);
    %Update the covariance matrices
    tmp = img - repmat(Miu(i,:),N,1);
    sigma(:,:,i) = ( tmp'*(repmat(pix(:,i),1,D).* tmp)) / E(i);
end

% stop iteration
for i = 1:K
    pxi(:,i) = cluster_EM_gaussPrb(img, Miu(i,:), sigma(:,:,i));
end
% log likelihood
px = pxi * priors';  
px(find(px<realmin)) = realmin;  
loglik = mean(log(px));  
%Stop the process depending on the increase of the log likelihood   
if abs((loglik/loglik_old)-1) < loglik_threshold  
    break;  
end  
  loglik_old = loglik;  
  nStep = nStep+1;  
end  
