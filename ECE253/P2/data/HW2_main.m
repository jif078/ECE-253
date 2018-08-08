%problem1
Im_1=imread('beach.png');
%original
figure(1)
imshow(Im_1)
title('original')
%HE
figure(2)
Im_1=histeq(Im_1);
subplot(2,2,1)
imshow(Im_1)
title('simple HE')
%{
N=(33-1)/2;
[m,n]=size(Im_1);
%pre-requirement
Im_11=padarray(Im_1,[N,N],'symmetric');
%N=65;
%N=129;
rank=zeros(m+2*N,n+2*N);
for i=1+N:m+N
    for j=1+N:n+N
        for i1=i-N:i+N
            for j1=j-N:j+N
                if Im_11(i1,j1)< Im_11(i,j)
                    rank(i,j)=rank(i,j)+1;
                end
            end
        end
        Im_1(i-N,j-N)=rank(i,j)*255/(2*N+1)^2;
    end
end
imshow(Im_1)
%}
%win_size=33
Im_2=imread('beach.png');
Im_2=AHE_func(Im_2,33);
subplot(2,2,2)
imshow(Im_2)
title('AHE & winsize=33')
%win_size=65
Im_3=imread('beach.png');
Im_3=AHE_func(Im_3,65);
subplot(2,2,3)
imshow(Im_3)
title('AHE & winsize=65')
%win_size=129
Im_4=imread('beach.png');
Im_4=AHE_func(Im_4,129);
subplot(2,2,4)
imshow(Im_4)
title('AHE & winsize=129')

%Problem2
%(i)
Im_circle=imread('circles_lines.jpg');
figure(3)
imshow(Im_circle)
title('original-circles')
Im_circle=rgb2gray(Im_circle);
Im_circle=(Im_circle>125);
%imshow(Im_circle)
%type is disk, r=5
y_1=imopen(Im_circle,strel('disk',5));
figure(4)
imshow(y_1)
title('image after opening-circles')
[L_1,N_1]=bwlabel(y_1);
for i=1:N_1
    [r,c]=find(L_1==i);
    Mean_r1(i)=mean(r);
    Mean_c1(i)=mean(c);
    Area(i)=length(r);
end
figure(5)
imagesc(L_1)
title('image after labeling-circles')
disp(Mean_r1);
disp(Mean_c1);
disp(Area);
%(ii)
Im_lines=imread('lines.jpg');
figure(6)
imshow(Im_lines)
title('original-lines')
Im_lines=rgb2gray(Im_lines);
Im_lines=(Im_lines>125);
%imshow(Im_lines)
%type is line, length=8, angle=90 degree
y_2=imopen(Im_lines,strel('line',8,90));
figure(7)
imshow(y_2)
title('image after opening-lines')
[L_2,N_2]=bwlabel(y_2);
for i=1:N_2
    [r,c]=find(L_2==i);
    Mean_r2(i)=mean(r);
    Mean_c2(i)=mean(c);
    Length(i)=max(r)-min(r)+1;
end
figure(8)
imagesc(L_2)
title('image after labeling-lines')
disp(Mean_r2);
disp(Mean_c2);
disp(Length);
%Problem3(2)
Im_lena=imread('lena512.tif');
Im_lena=double(Im_lena);
[m_lena,n_lena]=size(Im_lena);
lena_set=double(reshape(Im_lena,1,m_lena*n_lena));

Im_diver=imread('diver.tif');
Im_diver=double(Im_diver);
[m_diver,n_diver]=size(Im_diver);
diver_set=double(reshape(Im_diver,1,m_diver*n_diver));
for s=1:7
    [pa_lena,co_lena]=lloyds(lena_set,2^s);
    pa_lena=round(pa_lena);
    co_lena=round(co_lena);
    for j=1:length(pa_lena)-1
        lena_LM(Im_lena>pa_lena(j)&Im_lena<=pa_lena(j+1))=co_lena(j+1);
    end
    lena_LM(Im_lena<=pa_lena(1))=round(co_lena(1));
    lena_LM(Im_lena>pa_lena(end))=round(co_lena(end));
    MSE_LM_lena(s)=sum(sum((lena_LM-lena_set).^2))/numel(Im_lena);
    Sq_lena=S_quantize(Im_lena,s);
    MSE_un_lena(s)=sum(sum((double(Sq_lena)-double(Im_lena)).^2))/numel(Im_lena);
    
    
 
   [pa_d,co_d]=lloyds(diver_set,2^s);
    pa_d=round(pa_d);
    co_d=round(co_d);
    for j=1:length(pa_d)-1
        d_LM(Im_diver>pa_d(j)&Im_diver<=pa_d(j+1))=co_d(j+1);
    end
    d_LM(Im_diver<=pa_d(1))=round(co_d(1));
    d_LM(Im_diver>pa_d(end))=round(co_d(end));
    MSE_LM_diver(s)=sum(sum((d_LM-diver_set).^2))/numel(Im_diver);
    Sq_diver=S_quantize(Im_diver,s);
    MSE_un_diver(s)=sum(sum((Sq_diver-Im_diver).^2))/numel(Im_diver);
end
figure(9)
plot(MSE_LM_lena,'b-')
hold on;
plot(MSE_un_lena,'r--')
grid on;
xlabel('bitnumber s')
ylabel('MSE')
legend('LM','Uniform')
title('lena512')
figure(10)
plot(MSE_LM_diver,'b-')
hold on;
plot(MSE_un_diver,'r--')
grid on;
xlabel('bitnumber s')
ylabel('MSE')
title('diver')
legend('LM','Uniform')


%problem3(3)
Im_lena=imread('lena512.tif');
Im_lena=histeq(Im_lena,256);
Im_lena=double(Im_lena);
[m_lena,n_lena]=size(Im_lena);
lena_set=double(reshape(Im_lena,1,m_lena*n_lena));

Im_diver=imread('diver.tif');
Im_diver=histeq(Im_diver,256);
Im_diver=double(Im_diver);
[m_diver,n_diver]=size(Im_diver);
diver_set=double(reshape(Im_diver,1,m_diver*n_diver));
for s=1:7
    [pa_lena,co_lena]=lloyds(lena_set,2^s);
    pa_lena=round(pa_lena);
    co_lena=round(co_lena);
    for j=1:length(pa_lena)-1
        lena_LM(Im_lena>pa_lena(j)&Im_lena<=pa_lena(j+1))=co_lena(j+1);
    end
    lena_LM(Im_lena<=pa_lena(1))=round(co_lena(1));
    lena_LM(Im_lena>pa_lena(end))=round(co_lena(end));
    MSE_LM_lena(s)=sum(sum((lena_LM-lena_set).^2))/numel(Im_lena);
    Sq_lena=S_quantize(Im_lena,s);
    MSE_un_lena(s)=sum(sum((double(Sq_lena)-double(Im_lena)).^2))/numel(Im_lena);
    
    
 
   [pa_d,co_d]=lloyds(diver_set,2^s);
    pa_d=round(pa_d);
    co_d=round(co_d);
    for j=1:length(pa_d)-1
        d_LM(Im_diver>pa_d(j)&Im_diver<=pa_d(j+1))=co_d(j+1);
    end
    d_LM(Im_diver<=pa_d(1))=round(co_d(1));
    d_LM(Im_diver>pa_d(end))=round(co_d(end));
    MSE_LM_diver(s)=sum(sum((d_LM-diver_set).^2))/numel(Im_diver);
    Sq_diver=S_quantize(Im_diver,s);
    MSE_un_diver(s)=sum(sum((Sq_diver-Im_diver).^2))/numel(Im_diver);
end
figure(11)
plot(MSE_LM_lena,'b-')
hold on;
plot(MSE_un_lena,'r--')
grid on;
xlabel('bitnumber s')
ylabel('MSE')
legend('LM','Uniform')
title('lena512 after histogram equalization')
figure(12)
plot(MSE_LM_diver,'b-')
hold on;
plot(MSE_un_diver,'r--')
grid on;
xlabel('bitnumber s')
ylabel('MSE')
title('diver after histogram equalization')
legend('LM','Uniform')
        