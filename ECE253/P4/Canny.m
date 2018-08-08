function [im_grad,im_nms,im_Te]=Canny(im,Te)
         im_gray=double(rgb2gray(im));
         [row,col]=size(im_gray);
         %Smoothing
         k=1/159*[2 4 5 4 2;4 9 12 9 4;5 12 15 12 5;4 9 12 9 4; 2 4 5 4 2];
         im_f=imfilter(im_gray,k);
         %
         %Finding Gradients
         k_x=[-1 0 1;-2 0 2; -1 0 1];
         im_x=imfilter(im_f,k_x);
         k_y=[-1 -2 -1;0 0 0;1 2 1];
         im_y=imfilter(im_f,k_y);
         im_grad=sqrt(im_x.^2+im_y.^2);%magnitude
         theta_sb=atan(im_y./im_x);%direction
         %
         %NMS
         theta=zeros(row,col);
         %Define direction
         for i=1:row
             for j=1:col
                 if (theta_sb(i,j)>=-pi/8)&&(theta_sb(i,j)<=pi/8)
                    theta(i,j)=0;
                 elseif (theta_sb(i,j)>pi/8)&&(theta_sb(i,j)<=3*pi/8)
                    theta(i,j)=45;
                 elseif (theta_sb(i,j)>=-3*pi/8)&&(theta_sb(i,j)<-pi/8)
                    theta(i,j)=-45;
                 elseif (theta_sb(i,j)>3*pi/8)&&(theta_sb(i,j)<=pi/2)
                    theta(i,j)=90; 
                 elseif (theta_sb(i,j)>=-pi/2)&&(theta_sb(i,j)<-3*pi/8)
                    theta(i,j)=90;
                 end 
              end
         end
         %
         %Implement NMS
         im_nms=zeros(row,col);
         im_sb=padarray(im_grad,[1,1],0,'both');
         for i=2:row+1
             for j=2:col+1
                 if theta(i-1,j-1)==0
                     if im_sb(i,j-1)>im_sb(i,j) || im_sb(i,j+1)>im_sb(i,j)
                         im_nms(i,j)=0;
                     else
                         im_nms(i,j)=im_sb(i,j);
                     end   
                 elseif theta(i-1,j-1)==-45
                     if im_sb(i-1,j+1)>im_sb(i,j) || im_sb(i+1,j-1)>im_sb(i,j)
                         im_nms(i,j)=0;
                     else
                         im_nms(i,j)=im_sb(i,j);
                     end
                 elseif theta(i-1,j-1)==45
                     if im_sb(i-1,j-1)>im_sb(i,j) || im_sb(i+1,j+1)>im_sb(i,j)
                         im_nms(i,j)=0;
                     else
                         im_nms(i,j)=im_sb(i,j);
                     end
                 elseif theta(i-1,j-1)==90
                     if im_sb(i-1,j)>im_sb(i,j) || im_sb(i+1,j)>im_sb(i,j)
                         im_nms(i,j)=0;
                     else
                         im_nms(i,j)=im_sb(i,j);
                     end
                 end
             end
         end
         im_nms=im_nms(2:row+1,2:col+1);
         im_Te=zeros(row,col);
         %
         %Thresholding
         for i=1:row
             for j=1:col
                 if im_nms(i,j)>=Te
                    im_Te(i,j)=im_nms(i,j);
                 else
                    im_Te(i,j)=0;
                 end
             end
         end
         %        
im_grad=uint8(im_grad);
im_nms=uint8(im_nms);
im_Te=uint8(im_Te);
         