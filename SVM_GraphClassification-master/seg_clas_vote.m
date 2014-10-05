function ret = seg_clas_vote( seg_m, region_num, clas_m, nClasses )
%   Combine segmentation map and classification map by majority vote
%
%   seg_m : labeled segmentation map;
%   region_num : total number of regions;
%   clas_m : classification map;
%   nClasses : classes num;
%
%   written by Joyce

ret = seg_m;
for i = 1:region_num
    [r c] = find(seg_m == i);
    label = clas_m(seg_m == i); % 找出seg_m中==i的元素所在位置，返回clas_m相应位置元素
    max_num = sum(label == 1); % 可以这样数个数
    max_label = 1;
    for ii = 2:nClasses
        t = sum(label == ii);
        if t > max_num
            max_num = t;
            max_label = ii;
        else
            continue;
        end
    end
    for j = 1:length(r)
        ret(r(j), c(j)) = max_label;
    end
end

end

