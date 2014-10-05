function [test_r, test_c] = testset_idx(imgGT, train_r, train_c)
%EXTRACT_TEST_SET Summary of this function goes here
%   Detailed explanation goes here
train_img = ones(size(imgGT));
for i = 1:length(train_r)
    train_img(train_r(i), train_c(i)) = 0;
end
test_img = imgGT & train_img;
[test_r test_c] = find(test_img);
end