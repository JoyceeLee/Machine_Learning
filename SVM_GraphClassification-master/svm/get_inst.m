function [label_set, data_set] = get_inst(img, imgGT, r, c)
n = length(r);
data_set = zeros(n, size(img,3));
label_set = zeros(n, 1);
for i = 1:n
    label_set(i) = imgGT(r(i),c(i));
    data_set(i,:) = img(r(i),c(i),:);
end
end