function im_out=gaussianBlur(im_in,sigma)
         H = fspecial('gaussian',6*sigma,sigma);
         im_out = imfilter(im_in,H,'circular');
         