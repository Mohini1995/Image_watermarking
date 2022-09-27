clc
close all
clear all
%read image



cover_object1=imresize(imread('A_lena_color.jpg'),[1024 1024]);
cover_object=cover_object1(:,:,1);
cover_object2=cover_object1(:,:,2);
cover_object3=cover_object1(:,:,3);
save cover.mat cover_object1
[cA1,cH1,cV1,cD1] = qwt2(cover_object,'haar');
[cA,cH,cV,cD] = qwt2(cH1,'haar');
cH=dct2(cH);

k=4;
delta=32;
[mc,nc]=size(cH);
c=mc/k;d=nc/k;
message0=imresize(imread('A_latter.png'),[64 64]);
message=im2bw(message0);
save message.mat message
[mm,nm]=size(message);
for i=1:c
    for j=1:d
        p=cH(1+k*(i-1):i*k,1+k*(j-1):j*k);
        [U, S, V]=svd(p);
        r=4;
        lemda1=S(1,1);
        lemda2=S(2,2);
        lemda3=S(3,3);
        lemda4=S(4,4);
        Yi=[lemda1 lemda2 lemda3 lemda4];
        sumlemda=(lemda1^2)+(lemda2^2)+(lemda3^2)+(lemda4^2);
        NormYi=sqrt(sumlemda);
        N=floor(NormYi/delta);
        bit=message(i,j);
        if bit==1
            if mod(N,2)==0
                newN=N;
            else
                newN=N+1;
            end
        else
            if mod(N,2)==0
                newN=N+1;
            else
                newN=N;
            end
        end
        
        
        newNormYi=newN*delta+(delta/2);
        newYi=Yi.*(newNormYi/NormYi);
        newS=S;
        newS(1,1)=newYi(1);
        newS(2,2)=newYi(2);
        newS(3,3)=newYi(3);
        newS(4,4)=newYi(4);
        newP=U*newS*V';
        
        
        cH(1+k*(i-1):i*k,1+k*(j-1):j*k)=newP;
    end
end
cH=idct2(cH);

watermarkimage = iqwt2(cA,cH,cV,cD,'haar');
watermarkimage = iqwt2(cA1,watermarkimage,cV1,cD1,'haar');

watermarkimage=uint8(watermarkimage);
watermarkimage(:,:,2)=cover_object2;
watermarkimage(:,:,3)=cover_object3;
[PSNR,MSE] = psnr_mse_maxerr(cover_object1,watermarkimage)
%watermarkimage= imnoise(watermarkimage,'salt & pepper',0.01);
watermarkimage=imrotate(watermarkimage,135);
imwrite(watermarkimage,'watermark.bmp');