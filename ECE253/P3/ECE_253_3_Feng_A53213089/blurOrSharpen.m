function im_out=blurOrSharpen(im_in,w,sigma)
         im_out=(1+w).*im_in-w.*gaussianBlur(im_in,sigma);
