接口文件为‘img_analysis’,将‘svm’文件夹与‘cluster’文件夹中的文件全部拷贝出来，运行‘img_analysis’文件即可对其中设定的高光谱遥感图像数据进行二次投票分类；

‘svm’中的文件用以实现svm分类；

‘cluster’文件夹中是‘ISODATA’‘k-means’‘EM’三种聚类算法的源代码，其外部的‘clusters’文件是公共接口；

外部‘classSeg’文件是对聚类结果的进一步分割，将属于同一聚类但不相连通的区域区分开来。‘seg_clas_vote’文件用以第一次投票。‘veri_vote’用以第二次投票。