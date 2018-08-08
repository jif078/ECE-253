function [im_seg]=mapValues(im,idx,centers)
   idx2=reshape(idx,720,1280);
   [a,b,rgb]=size(im);
   im_seg=im;
   for i=1:a
       for j=1:b
        im_seg(i,j,:)=centers(idx2(i,j),:);
       end
   end
