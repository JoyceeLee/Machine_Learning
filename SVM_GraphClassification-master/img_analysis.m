
%% 数据读入与整理
clear;
clc;
img = 'data\92AV3C.tif'
imgGT = 'data\92AV3GT.tif'
img_src = imread(img);  % 印第安纳州农作物原始图像（IPS）
[img_gt, colormap] = imread(imgGT);
sub_img = img_src;
sub_img(:, :, [104:108,150:163,220])=[];

%% SVM分类
[svmL, nclasses] = svm(sub_img, img_gt);

%% cluster聚类分割
[cLISODATA, nclISODATA] = clusters(sub_img, img_gt,'ISODATA');
[cLkmeans, nclkmeans] = clusters(sub_img, img_gt,'kmeans');
[cLEM, nclEM] = clusters(sub_img, img_gt,'EM');
% 进一步分割
[classL_ISODATA,M_ISODATA] = classSeg(cLISODATA, nclISODATA);
[classL_kmeans,M_kmeans] = classSeg(cLkmeans, nclkmeans);
[classL_EM,M_EM] = classSeg(cLEM, nclEM);

%% 投票1
finL_ISODATA = seg_clas_vote( classL_ISODATA, M_ISODATA, svmL, nclasses );
finL_kmeans = seg_clas_vote( classL_kmeans, M_kmeans, svmL, nclasses );
finL_EM = seg_clas_vote( classL_EM, M_EM, svmL, nclasses );

%% 投票2
[finL,Llog] = veri_vote( finL_EM,finL_kmeans,finL_ISODATA );
%% 显示结果
disp(['总体准确率']);
ac = print_reasult(finL, img_gt);
disp(['ISODATA分割准确率']);
ac_ISODATA = print_reasult(finL_ISODATA, img_gt);
disp(['kmeans分割准确率']);
ac_kmeans = print_reasult(finL_kmeans, img_gt);
disp(['EM分割准确率']);
ac_EM = print_reasult(finL_EM, img_gt);
subplot(2,3,1);imshow(img_gt, colormap);
subplot(2,3,2);imshow(uint8(svmL), colormap);
subplot(2,3,3);imshow(uint8(finL), colormap);
subplot(2,3,4);imshow(uint8(finL_ISODATA), colormap);
subplot(2,3,5);imshow(uint8(finL_kmeans), colormap);
subplot(2,3,6);imshow(uint8(finL_EM), colormap);