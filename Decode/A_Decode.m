clc
close all
clear all
load cover

I2=imread('Watermark.bmp');

watermark1=I2(:,:,1);
original=cover_object1(:,:,1);
distorted=watermark1(:,:,1);
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
[cA1,cH1,cV1,cD1] = qwt2(watermark1,'haar');
[cA,cH,cV,cD] = qwt2(cH1,'haar');
cH=idct2(cH);
watermark=(cH);

k=4;
delta=32;
[mw,nw]=size(watermark);
m1=mw/k;n1=nw/k;
for i=1:m1
    for j=1:n1
        p=watermark(1+k*(i-1):i*k,1+k*(j-1):j*k);
        [U, S, V]=svd(p);
%         r=4;
        lemda1=S(1,1);
        lemda2=S(2,2);
        lemda3=S(3,3);
        lemda4=S(4,4);
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
imshow(watermark);
load message;
[PSNR,MSE] = psnr_mse_maxerr(message,im2bw(watermark))