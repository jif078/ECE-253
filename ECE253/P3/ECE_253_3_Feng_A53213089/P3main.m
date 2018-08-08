%
%problem1
%(i)
%(ii)
%(a)
sigma=2;
im_p=imread('pattern.tif');
figure()
imshow(uint8(im_p))
title('original image pattern.tif')
im_w1=blurOrSharpen(im_p,1,sigma);
figure()
imshow(uint8(im_w1))
title('most sharpening w=1')
im_w2=blurOrSharpen(im_p,-1,sigma);
figure()
imshow(uint8(im_w2))
title('most blurring w=-1')
%(b)
sigma=10;
im_w3=blurOrSharpen(im_p,-1,sigma);
im_w4=blurOrSharpen(im_w3,1,sigma);
figure()
imshow(uint8(im_w4))
title('reverse by sharpening the blurred image')
%(c)
im_w5=blurOrSharpen(im_p,1,sigma);
figure()
imshow(uint8(im_w5))
title('w=1, sigma=10')
%(iii)
%(a)
im_bn=imread('brain.tif');
figure()
imshow(uint8(im_bn))
title('original image brain.tif')
sigma=2;
im_blur=gaussianBlur(im_bn,sigma);
figure()
imshow(uint8(im_blur))
title('blurred image')
[im_unblur,R,MSE]=gaussianUnblur(im_bn,im_blur,sigma,1000,0.0001);
figure()
imshow(uint8(im_unblur))
title('unblurred image')
figure()
semilogy(R)
hold on
semilogy(MSE)
grid on
xlabel('Iteration number')
ylabel('Error')
title('Performance')
legend('Residual','MSE')
%(b)
figure()
im_blur1 = single(imnoise(uint8(im_blur), 'gaussian'));
imshow(uint8(im_blur1))
[im_unblur1,R1,MSE1]=gaussianUnblur(im_bn,im_blur1,sigma,1000,0.0001);
figure()
imshow(uint8(im_unblur1))
figure()
semilogy(R1)
hold on
semilogy(MSE1)
grid on
xlabel('Iteration number')
ylabel('Error')
title('Performance With Noise')
legend('Residual','MSE')



%problem2
%(i)
im_car=imread('Car.tif');
[row, column]=size(im_car);
figure()
imagesc(im_car);colorbar;colormap(gray);
title('Original Car.tif')
FFT=fft2(im_car,512,512);
imFFT=fftshift(FFT);
figure()
imagesc(-256:255,-256:255,log(abs(imFFT))); colorbar;colormap(gray);
xlabel('u'); ylabel('v');
title('2D DFT Log Magnitude of Car.tif')
n=5; D_0=40;H_NR=1;
U=[-90,-167;-90,-80;-83,87;-83,173];
[u,v]=meshgrid(-256:255);
for i=1:4
    D_kp=sqrt(((u-U(i,1)).^2)+((v-U(i,2)).^2));
    D_kn=sqrt(((u+U(i,1)).^2)+((v+U(i,2)).^2));
    H_NR=H_NR.*(1./(1+(D_0./D_kp).^(2*n))).*(1./(1+(D_0./D_kn).^(2*n)));
end
figure()
imagesc(-256:255,-256:255,abs(H_NR)); colorbar;colormap(gray);
xlabel('u'); ylabel('v');
title('Notch Reject Filter H_NR for Car.tif')
im_filtered=abs(ifft2(FFT.*fftshift(H_NR)));
figure()
imagesc(uint8(im_filtered(1:row,1:column)));colorbar;colormap(gray);
title('Filtered Car.tif')
%
%(ii)
im_st=imread('Street.png');
[row_s, column_s]=size(im_st);
figure()
imagesc(im_st);colorbar;colormap(gray);
title('Original Street.png')
FFT_s=fft2(im_st,512,512);
imFFT_s=fftshift(FFT_s);
figure()
imagesc(-256:255,-256:255,log(abs(imFFT_s))); colorbar;colormap(gray);
xlabel('u'); ylabel('v');
title('2D DFT Log Magnitude of Street.tif')
n_s=5; D_0_s=10;H_NR_s=1;
U_s=[0,-167;165,0];
[u,v]=meshgrid(-256:255);
for i=1:2
    D_kp_s=sqrt(((u-U_s(i,1)).^2)+((v-U_s(i,2)).^2));
    D_kn_s=sqrt(((u+U_s(i,1)).^2)+((v+U_s(i,2)).^2));
    H_NR_s=H_NR_s.*(1./(1+(D_0_s./D_kp_s).^(2*n_s))).*(1./(1+(D_0_s./D_kn_s).^(2*n_s)));
end
figure()
imagesc(-256:255,-256:255,abs(H_NR_s)); colorbar;colormap(gray);
xlabel('u'); ylabel('v');
title('Notch Reject Filter H_NR for Street.tif')
im_filtered_s=abs(ifft2(FFT_s.*fftshift(H_NR_s)));
figure()
imagesc(uint8(im_filtered_s(1:row_s,1:column_s)));colorbar;colormap(gray);
title('Filtered Street.tif')
clear;clc;
%problem3
%(i)
im_L=double(imread('Letters.jpg'));
im_t=double(imread('LettersTemplate.jpg'));
im_t=rot90(im_t,2);
im_conv=conv2(im_L,im_t);
figure
subplot(2,2,1)
imagesc(im_conv);colorbar;colormap(gray);
title('cross-correlation in Spatial Domain')
[m,n]=size(im_conv);
im_f=fft2(im_L,m,n).*fft2(im_t,m,n);
im_freq=abs(ifft2(im_f));
subplot(2,2,2)
imagesc(im_freq);colorbar;colormap(gray);
title('multiplication in Frequency Domain')
clear;clc;
%(ii)
im_L=double(rgb2gray(imread('StopSign.jpg')));
im_t=double(rgb2gray(imread('StopSignTemplate.jpg')));
im_t=rot90(im_t,2);
im_conv=conv2(im_L,im_t);
subplot(2,2,3)
imagesc(im_conv);colorbar;colormap(gray);
title('cross-correlation in Spatial Domain')
[m,n]=size(im_conv);
im_f=fft2(im_L,m,n).*fft2(im_t,m,n);
im_freq=abs(ifft2(im_f));
subplot(2,2,4)
imagesc(im_freq);colorbar;colormap(gray);
title('multiplication in Frequency Domain')
%(iii)
im_L=double(rgb2gray(imread('StopSign.jpg')));
im_t=double(rgb2gray(imread('StopSignTemplate.jpg')));
imNCC=normxcorr2(im_t,im_L);
figure
imagesc(imNCC);colorbar;colormap(gray);
title('normalized cross-correlation')
max=max(max(imNCC));
[y,x]=find(imNCC==max);
[p,q]=size(im_t);
im_L=imread('StopSign.jpg');
im_L=insertShape(im_L,'rectangle',[x-q+1 y-p+1 q p],'LineWidth',5);
figure
imagesc(im_L);colorbar;colormap(gray);
clear;clc;
%(v)
im_L=double(rgb2gray(imread('stopsign2.jpeg')));
im_t=double(rgb2gray(imread('StopSignTemplate.jpg')));
imNCC=normxcorr2(im_t,im_L);
figure
imagesc(imNCC);colorbar;colormap(gray);
title('normalized cross-correlation')
max=max(max(imNCC));
[y,x]=find(imNCC==max);
[p,q]=size(im_t);
im_L=imread('stopsign2.jpeg');
im_L=insertShape(im_L,'rectangle',[x-q+1 y-p+1 q p],'LineWidth',5);
figure
imagesc(im_L);colorbar;colormap(gray);
