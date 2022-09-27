clc
close all
clear all
%read image

I=imresize(imread('lena_color.jpg'),[512 512]);
I1=rgb2ntsc(I);
[cA,cH,cV,cD] = dwt2(I(:,:,1),'haar');
[cA1,cH1,cV1,cD1] = dwt2(cA,'haar');
cA1=dct2(cA1);
message=im2bw(imresize(imread('A_latter.png'),[32 32]));
%message= arnold(message0,10);
k=4;
delta=64;
[mc,nc]=size(cA1);
c=mc/k;d=nc/k;
[mm,nm]=size(message);
for i=1:c
    for j=1:d
        p=cA1(1+k*(i-1):i*k,1+k*(j-1):j*k);
        lemda1=p(1,1);
        lemda2=p(2,2);
        lemda3=p(3,3);
        lemda4=p(4,4);
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
        newp=p;
        newp(1,1)=newYi(1);
        newp(2,2)=newYi(2);
        newp(3,3)=newYi(3);
        newp(4,4)=newYi(4);
        cA1(1+k*(i-1):i*k,1+k*(j-1):j*k)=newp;
    end
end
cA1=idct2(cA1);
cA = idwt2(cA1,cH1,cV1,cD1,'haar');
watermarkimage = uint8(idwt2(cA,cH,cV,cD,'haar'));
watermarkimage(:,:,2:3)=I(:,:,2:3);
watermarkimagee=ntsc2rgb((I));
watermarkimage=imrotate(watermarkimage,178);
imwrite(watermarkimage,'watermark.bmp');
