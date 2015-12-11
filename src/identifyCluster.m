function [matched_cluster_image] = identifyCluster(seed_cluster_image,input_cluster_image,...
    seed_filt_images,input_filt_images,numclusters,seed_cluster_no)
% Match the seed cluster to the closest cluster in the input image
    [imgx, imgy] = size(seed_cluster_image);
    seed_image = reshape(seed_filt_images,imgx*imgy,8);
    seed_pts = seed_image(seed_cluster_image==seed_cluster_no,:);
    filt_image = reshape(input_filt_images,imgx*imgy,8);
    matched_cluster = 0;
    min_cluster_dist = 0;
    % For every cluster in the image
    for clus_num=1:numclusters
        target_pts = filt_image(input_cluster_image==clus_num,:);
        % For every point in the cluster, calculate the closest distance 
        % from the seed cluster
        [~,dist] = knnsearch(seed_pts,target_pts);
        min_dist = min(dist(:));
        if min_dist < min_cluster_dist
            min_cluster_dist = min_dist;
            matched_cluster = clus_num;
        end
    end
    matched_cluster_image = zeros(imgx,imgy);
    matched_cluster_image(input_cluster_image==matched_cluster) = 1;
end