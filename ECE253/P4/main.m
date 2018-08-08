clear all;close all;clc;
%
%Canny Edge Detection
im=imread('geisel.jpg');
Te=50;
[im_grad,im_nms,im_Te]=Canny(im,Te);
figure
imshow(im_grad)
title('Original gradient magnitude image')
figure
imshow(im_nms)
title('Image after NMS')
figure
imshow(im_Te)
title('Final edge image')

%Hough Transform
%(i)
%(ii)
clear all;clc;
%set image
im_test=zeros(11,11);
im_test(1,1)=1;im_test(1,11)=1;
im_test(11,1)=1;im_test(11,11)=1;
im_test(6,6)=1;
[a,b]=size(im_test);
long=sqrt((a-1)^2+(b-1)^2);
fl=floor(-long);ce=ceil(long);
%original
figure()
imshow(logical(im_test));colorbar;colormap(gray);
title('Original Image')
%HF transform
[rho,X]=HF(im_test);
figure()
X_show=X./max(max(X));T=-90:90;R=fl:ce;
imshow(X_show,[],'XData',T,'YData',R,'InitialMagnification','fit');
xlabel('theta'), ylabel('rho');
colorbar;colormap(gray);
title('HT')
axis on, axis normal
%Find '3' location
id=0;
for i=1:181
    C=unique(rho(:,i));
    l=length(C);
    if l<=3
        for j=1:l
            Temp=find(rho(:,i)==C(j));
            s(j)=length(Temp);
            if s(j)>2 
               id=id+1;
               U(id,:)=[T(i),C(j)];
            end            
        end
    end
end    
%Intersection[(-45,0),(45,7.071)]
%set vale of the pixel on the line = "1"
figure()
for i=1:length(U(:,1))
    xi=0:10;
    yi=round((U(i,2)-(xi)*cosd(U(i,1)))/sind(U(i,1)));   
    for j=1:11
        im_test(xi(j)+1,yi(j)+1)=1;
    end  
end
imshow(im_test);colorbar;colormap(gray);
title('Original image with lines')
%(iii)
clear all;clc
I = imread('lane.png');
%original
figure()
imshow(I);colorbar;colormap(gray);
title('Original Image')
%save original
o=I;
%Edge
I=rgb2gray(I);
E = edge(I,'sobel');
[a,b]=size(E);
long=sqrt((a-1)^2+(b-1)^2);
fl=floor(-long);ce=ceil(long);
figure()
imshow(logical(E));colorbar;colormap(gray);
title('Original Image')
%HF transform
[rho,X]=HF(E);
figure()
X_show=X./max(max(X));
R=fl:ce;T=-90:90;
imshow(X_show,[],'XData',T,'YData',R,'InitialMagnification','fit');
xlabel('theta'), ylabel('rho');
colorbar;colormap(gray);
title('HT')
axis on, axis normal
%Threshold
[A,B]=find(X>0.75*max(max(X)));
A_t=A-ce;B_t=B-91;
P=zeros(length(A),2);
%overlay lines
figure()
imshow(o);colorbar;colormap(gray);
hold on;
for i=1:length(A)
    P(i,:)=[round((A_t(i))*sind(B_t(i))+1) round((A_t(i))*cosd(B_t(i))+1)]; 
    x=1:b;
    y=-(1/cotd(B_t(i)))*(x-P(i,1))+P(i,2);
plot(x,y,'g','linewidth',2)
set(gca,'ydir','reverse');
ylim([1 a]);xlim([1 b])
end
title('Original image with lines')
%(iv)
figure()
imshow(o);colorbar;colormap(gray);
hold on;
%theta[-30,40]U[30,40]
dr=find(abs(B_t)>=30 & abs(B_t)<=40);
for i=1:length(dr)
    PD(i,:)=[round((A_t(dr(i)))*sind(B_t(dr(i)))+1) round((A_t(dr(i)))*cosd(B_t(dr(i)))+1)]; 
    x=1:b;
    y=-(1/cotd(B_t(dr(i))))*(x-PD(i,1))+PD(i,2);
   plot(x,y,'g','linewidth',2)
   set(gca,'ydir','reverse');
   ylim([1 a]);xlim([1 b])
end   
title('Driver lane only')

%{
%K-Means Segmentation
clear all;clc
im=imread('white-tower.png');
features=createDataset(im);
%initialize
n_clst=7;
rng(5);
id=randi(size(features,1),1,n_clst);
centers=features(id,:);
%kMeansCluster
[idx,centers,It]=kMeansCluster(features,centers,n_clst);
%mapValues
[im_seg]=mapValues(im,idx,centers);
%output
figure
imshow(im)
title('Input image')
figure
imshow(im_seg)
title('Image after segmentation')
%}