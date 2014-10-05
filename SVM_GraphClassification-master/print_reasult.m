function ac = print_reasult(ret, tm)
%PRINT_REASULT Summary of this function goes here
%   Display the reasult
%
%   ret : reasult map;
%   tm : testing map;
%
rc_g = 0;
totl_g = 0;

nClasses = max(tm(:));
ac = zeros(1, nClasses+2);
for i = 1:nClasses
    rc_per = sum(ret(tm == i) == i);
    totl_per = sum(tm(:) == i);
    ac_per = rc_per/totl_per;
    str = sprintf('第 %d 类分类准确率 = %s%% (%d/%d)', i, num2str(ac_per*100, '%4.2f'), rc_per, totl_per);
    disp(str);
    rc_g = rc_g + rc_per;
    totl_g = totl_g + totl_per;
    ac(1,i) = ac_per;
end
aa = mean(ac(1:nClasses), 2);
str = sprintf('整体分类准确率(OA)  = %s%% (%d/%d)', num2str(rc_g/totl_g * 100, '%4.2f'), rc_g, totl_g);
disp(str);
s = sprintf('平均准确率(AA) = %s%%', num2str(aa*100, '%4.2f'));
disp(s);
ac(1, nClasses+1) = rc_g/totl_g;
ac(1, nClasses+2) = aa;
end