function [kmeans_label,ncluster] = cluster_kmeans(img,K)
kmeans_label = kmeans(img, K);
ncluster = length(unique(kmeans_label));
end