% This program was written by Jianning Chi to implement the artifacts
% removal algorithm described in the article "Automatic removal of manually 
% induced artefacts in ultrasound images of thyroid gland".

Imgdir = dir('Scale_normalize');

for i = 3:length(Imgdir)
    str = Imgdir(i).name;
    Img = im2double(imread(['Scale_normalize/' str]));
    Img1 = rgb2gray(Img);
    
    % Find the pixels representing the artifacts and subtract these pixels
    % from the image.
    Img2 = im2bw(Img,graythresh(Img1));
    se1 = strel('disk',4);
    Img_mask = imdilate(Img2,se1);
    Img_res = Img1.*(1-double(Img_mask));
    se = strel('disk',7);
    % Restore the "gap" after removing the artifacts pixels by simulating
    % the surrounding textures.
    Img_res1 = DCT_RES(Img1);
    % Only the "gaps" are replaced by the approximated textures, preserve
    % the original textures.
    Img_res2 = Img_res1.*double(Img_mask)+Img_res;
    
    imwrite(Img_res2,['Marker_removed1/' str(1:end-4) '.png']);
end