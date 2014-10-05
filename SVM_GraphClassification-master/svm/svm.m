%######################################################################################
%   
%               EXPERIMENT WITH AVIRIS INDIAN PINES DATA SET
%                           印第安纳州农林数据集实验
% 工作：在每一个类别中随机抽取10%的样本作为训练集，使用LIBSVM提供的借口对图像进行分类
% 要求：
%	1.真实地表图像（直观显示）
%	2.训练集（直观显示）
%	3.测试集（直观显示）
%	4.分类结果（直观显示）
%   
%#######################################################################################
function [svm_lab, nclasses] = svm(img, imgGT)

%% 数据准备阶段
svm_para = ' -c 1024 -g 2^(-7)';   %SVM分类参数
nclasses = max(imgGT(:));
rate = 0.1;

% 训练数据坐标提取
[train_r, train_c] = trainset_idx(imgGT, nclasses, rate);
%测试数据坐标提取
[test_r, test_c] = testset_idx(imgGT, train_r, train_c);
%数据及标签提取
[train_label, train_data] = get_inst(img, imgGT, train_r, train_c);
[test_label, test_data] = get_inst(img, imgGT, test_r, test_c);

%% svm分类
%训练分类器
[train_scale test_scale] = scaleForSVM(double(train_data), double(test_data), 0, 1);
model = svmtrain(double(train_label), train_scale, svm_para);
%利用svm预测
[predict,accuracy] = svmpredict(double(test_label), test_scale, model);
cr = ClassResult(double(test_label), test_scale, model, 2);

%% 返回值
svm_lab = zeros(size(imgGT));
idx_train = sub2ind(size(imgGT),train_r,train_c);
svm_lab(idx_train) = svm_lab(idx_train) + train_label;
idx_test = sub2ind(size(imgGT),test_r,test_c);
svm_lab(idx_test) = svm_lab(idx_test) + predict;
