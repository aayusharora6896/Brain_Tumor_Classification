function [ processedimage ] = preprocess( image )
% The function deals with preprocessing the image
% which would be used for further computations.
    gray = rgb2gray(image);%Gray Scale
    % Contrast Enhancement by Mathematical Morphology
    se = strel('disk',3);%creating a disc shaped structure
    img2 = imsubtract(imadd(gray,imtophat(gray,se)),imbothat(gray,se)); %Convolving Function
    img2 = im2bw(img2,.6);
    processedimage = bwareaopen(img2,64);
end

