% Project for BME
clear, clc
% Read in .tif file
% read in with a for loop
% 396 frames in file
% input('File name', 's')
[fname,path,index]=uigetfile({'*.tif','*.tiff'},'File Selector');
%fname = 'Startle1.tif';
info = imfinfo(fname);
num_img = length(info);
[n,m] = size(imread(fname,1));

zfishRe = zeros(m,n,num_img);

for k = 1:num_img
    
      zfishRe(:,:,k) = imread(fname, k);
      
end  

zfishRe = uint8(zfishRe);
zfishRe = imcomplement(zfishRe);



% Use a user defined function to go through pixel by pixel
% this function will define each pixel based on it relative coloring
% function name par_fil
zfishI = part_fil(zfishRe);
%     figure
% for i = 1:num_img
%     imshow(zfishI(:,:,i));
% end 

% function for zebra fish identity
SE=strel('square',6);

dilated_im= imdilate(zfishI, SE);

zfish_iso=bwareaopen(dilated_im, 7);

zfishRe = imcomplement(zfishRe);

zfish_track(zfish_iso,zfishRe)