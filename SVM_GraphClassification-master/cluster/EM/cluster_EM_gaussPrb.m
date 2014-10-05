function prob = cluster_EM_gaussPrb(data, Miu, sigma)  
% Inputs -----------------------------------------------------------------  
%   o data:  N x D array representing N datapoints of D dimensions.  
%   o Miu:   1 x D array representing the centers of the GMM components.  
%   o sigma: D x D x K array representing the covariance matrices of the   
%            K GMM components.  
% Outputs ----------------------------------------------------------------  
%   o prob:  1 x N array representing the probabilities for the   
%            N datapoints.       
  
[N,D] = size(data);  
  
data = data - repmat(Miu,N,1);  
prob = sum((data * pinv(sigma)).*data, 2);%点乘再加，相当于[x_i * sigma^-1 * x_i']
prob = exp(-0.5*prob) / sqrt((2*pi)^D * (abs(det(sigma))+realmin)); 