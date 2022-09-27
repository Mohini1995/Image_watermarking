clc
close all
clear all
I=imresize(imread('lena_color.jpg'),[512 512]);
I2=imread('watermark.bmp');
original=I(:,:,1);
distorted=I2(:,:,1);
ptsOriginal  = detectSURFFeatures(original);
ptsDistorted = detectSURFFeatures(distorted);
[featuresOriginal,   validPtsOriginal]  = extractFeatures(original,  ptsOriginal);
[featuresDistorted, validPtsDistorted]  = extractFeatures(distorted, ptsDistorted);
indexPairs = matchFeatures(featuresOriginal, featuresDistorted);
matchedOriginal  = validPtsOriginal(indexPairs(:,1));
matchedDistorted = validPtsDistorted(indexPairs(:,2));
[tform, inlierDistorted, inlierOriginal] = estimateGeometricTransform(...
    matchedDistorted, matchedOriginal, 'affine');
Tinv  = tform.invert.T;
ss = Tinv(2,1);
sc = Tinv(1,1);
scale_recovered = sqrt(ss*ss + sc*sc)
theta_recovered = atan2(ss,sc)*180/pi
outputView = imref2d(size(original));
recovered(:,:,1)=imwarp(distorted,tform,'OutputView',outputView);

watermark1=uint8(recovered);
watermark1=modifiedMedianFiltering(watermark1,0,255);
[cA,cH,cV,cD] = dwt2(watermark1,'haar');
[cA,cH,cV,cD] = dwt2(cA,'haar');
watermark=dct2(cA);
k=4;
delta=64;
[mw,nw]=size(watermark);
m1=mw/k;n1=nw/k;
for i=1:m1
    for j=1:n1
        p=watermark(1+k*(i-1):i*k,1+k*(j-1):j*k);
        lemda1=p(1,1);
        lemda2=p(2,2);
        lemda3=p(3,3);
        lemda4=p(4,4);
        Yi=[lemda1 lemda2 lemda3 lemda4];
        sumlemda=(lemda1^2)+(lemda2^2)+(lemda3^2)+(lemda4^2);
        NormYi=sqrt(sumlemda);
        N=floor(NormYi/delta);
        if mod(N,2)==0
            water(i,j)=1;
        else
            water(i,j)=0;
        end
    end
end
water=water.*255;
watermark=uint8(water);
imshow(im2bw(imresize(watermark,[64 64])));
