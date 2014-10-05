function [train_r, train_c] = trainset_idx(imgGT, nclasses, rate )
%EXTRACT_TRAIN_SET_BY_RATE Summary of this function goes here
%   Detailed explanation goes here
train_r =[];
train_c =[];
for i = 1:nclasses
    [r,c] = find(imgGT == i);
    nn = floor(length(r) * rate);
    idx =  randperm(length(r));
    idx = idx(1:nn);
    train_r = [train_r;r(idx)];
    train_c = [train_c;c(idx)];
end
end