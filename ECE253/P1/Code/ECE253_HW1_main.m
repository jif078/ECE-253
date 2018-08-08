%
%problem1
A=[3 9 5 1;4 25 4 3; 63 12 23 9; 6 32 77 0; 12 8 5 1];
B=[0 1 0 1;0 1 1 1; 0 0 0 1;1 1 0 1; 0 1 0 0];
%(i)
C=A.*B;
disp(C)
%(ii)
In_p=dot(C(2,:),C(5,:));
disp(In_p)
%(iii)
Min=min(min(C));
[row_min,col_min]=find(C==Min);
disp(Min)
disp(row_min')
disp(col_min')
Max=max(max(C));
[row_max,col_max]=find(C==Max);
disp(Max)
disp(row_max')
disp(col_max')
%problem2
%(i)
Im_A=imread('p2.jpg');
figure(1)
subplot(2,2,1)
imshow(Im_A)
title('Image A')
%(ii)
Im_B=rgb2gray(Im_A);
subplot(2,2,2)
imshow(Im_B)
title('Image B')
%(iii)
Im_C=Im_B+20;
subplot(2,2,3)
imshow(Im_C)
title('Image C')
%(iv)
Im_D=rot90(Im_C,2);
subplot(2,2,4)
imshow(Im_D)
title('Image D')
%(v)
B0=reshape(Im_B,[1,400*600]);
m=median(B0);
Im_E=Im_B>m;
figure(2)
imshow(Im_E)
title('Image_E')
%
%problem3
Im=imread('geisel.jpg');
[m,n]=size(Im);
n=n/3;
y=compute_norm_rgb_histogram(Im);
z=zeros(1,32);
y_r=[y(1:32)/(m*n) z z];
y_g=[z y(33:64)/(m*n) z];
y_b=[z z y(65:96)/(m*n)];
N=1:10^6;
figure(3)
plot(y_r,'r')
hold on;
plot(y_g,'g')
hold on;
plot(y_b,'b')
hold on;
title('Output y by function histogram')
ylabel('Normalized number')
xlabel('Bin No.')
%}
%problem4

Im_dog=imread('travolta.jpg');
figure(4)
subplot(2,2,1)
imshow(Im_dog)
r=Im_dog(:,:,1);
g=Im_dog(:,:,2);
b=Im_dog(:,:,3);
[m,n]=size(g);
%
g(g<r+b)=1;
g(g>=r+b)=0;
subplot(2,2,2)
imshow(logical(g))
g_c=1-g;

%{
for i=1:m
    for j=1:n
        if g(i,j)>= r(i,j)+b(i,j)
           g(i,j)=0;r(i,j)=0;b(i,j)=0;   
        end
    end
end
%}

dog_2=Im_dog.*g;
subplot(2,2,3)
imshow(dog_2)
%dog_bi=g>0;
%{
%
subplot(2,2,3)
imshow(dog_bi)
%}
Im_ba=imread('p2.jpg');
Im_back=imresize(Im_ba,[m,n]);
Im_back=Im_back.*g_c;
Im_back=Im_back+dog_2;
%{
for i=1:m
    for j=1:n
        if g(i,j)~= 0
            Im_back(i,j,:)=dog_2(i,j);
        end
    end
end
%}
subplot(2,2,4)
imshow(Im_back)
    

Im_dog=imread('dog.jpg');
figure(5)
subplot(2,2,1)
imshow(Im_dog)
r=Im_dog(:,:,1);
g=Im_dog(:,:,2);
b=Im_dog(:,:,3);
[m,n]=size(g);
%
g(g<r+b)=1;
g(g>=r+b)=0;
subplot(2,2,2)
imshow(logical(g))
g_c=1-g;

dog_2=Im_dog.*g;
subplot(2,2,3)
imshow(dog_2)

Im_ba=imread('p2.jpg');
Im_back=imresize(Im_ba,[m,n]);
Im_back=Im_back.*g_c;
Im_back=Im_back+dog_2;

subplot(2,2,4)
imshow(Im_back)
    