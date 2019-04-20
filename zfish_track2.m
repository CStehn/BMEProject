function x = zfish_track2(y,zfishRe)
% This function will take as input a matrix of filtered intensity values of binary video frames, then plot distance over time.
% y must be a video
L = bwlabeln(y); 
[~,n] = bwlabel(y(:,:,1)); % Returns number of objects in first frame to set size of centroids_data object
for i = 1:size(y,3) % cycles through frames
 stats = regionprops(L(:,:,i), 'Centroid'); % Collects centroid data for ith frame
 centroids = cat(1, stats.Centroid); % Concatenates centroids to centroid object
 centroids_data(1:n, (2*i - 1):(2*i)) = centroids(1:n,:); % Stores [x,y] of centroids for n objects for given frame
 imshow(zfishI(:,:,i)) % Displays filtered image for plotting over
 hold on
 for k = 1:n % Cycles through objects
    plot(centroids_data(k,1:2:(2*i - 1)),centroids_data(k,2:2:(2*i)),'b') % First term plots all x coordinates of the given fish while the second term plots all y coordinates of the given fish, forming a connected line for each fish individually
 end
 pause(0.02) % Makes plotting smoother
 hold off
end
end