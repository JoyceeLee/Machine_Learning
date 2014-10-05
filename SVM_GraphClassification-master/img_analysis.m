
%% ���ݶ���������
clear;
clc;
img = 'data\92AV3C.tif'
imgGT = 'data\92AV3GT.tif'
img_src = imread(img);  % ӡ�ڰ�����ũ����ԭʼͼ��IPS��
[img_gt, colormap] = imread(imgGT);
sub_img = img_src;
sub_img(:, :, [104:108,150:163,220])=[];

%% SVM����
[svmL, nclasses] = svm(sub_img, img_gt);

%% cluster����ָ�
[cLISODATA, nclISODATA] = clusters(sub_img, img_gt,'ISODATA');
[cLkmeans, nclkmeans] = clusters(sub_img, img_gt,'kmeans');
[cLEM, nclEM] = clusters(sub_img, img_gt,'EM');
% ��һ���ָ�
[classL_ISODATA,M_ISODATA] = classSeg(cLISODATA, nclISODATA);
[classL_kmeans,M_kmeans] = classSeg(cLkmeans, nclkmeans);
[classL_EM,M_EM] = classSeg(cLEM, nclEM);

%% ͶƱ1
finL_ISODATA = seg_clas_vote( classL_ISODATA, M_ISODATA, svmL, nclasses );
finL_kmeans = seg_clas_vote( classL_kmeans, M_kmeans, svmL, nclasses );
finL_EM = seg_clas_vote( classL_EM, M_EM, svmL, nclasses );

%% ͶƱ2
[finL,Llog] = veri_vote( finL_EM,finL_kmeans,finL_ISODATA );
%% ��ʾ���
disp(['����׼ȷ��']);
ac = print_reasult(finL, img_gt);
disp(['ISODATA�ָ�׼ȷ��']);
ac_ISODATA = print_reasult(finL_ISODATA, img_gt);
disp(['kmeans�ָ�׼ȷ��']);
ac_kmeans = print_reasult(finL_kmeans, img_gt);
disp(['EM�ָ�׼ȷ��']);
ac_EM = print_reasult(finL_EM, img_gt);
subplot(2,3,1);imshow(img_gt, colormap);
subplot(2,3,2);imshow(uint8(svmL), colormap);
subplot(2,3,3);imshow(uint8(finL), colormap);
subplot(2,3,4);imshow(uint8(finL_ISODATA), colormap);
subplot(2,3,5);imshow(uint8(finL_kmeans), colormap);
subplot(2,3,6);imshow(uint8(finL_EM), colormap);