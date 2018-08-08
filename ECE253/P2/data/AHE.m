function output = AHE(im, winsize)

 assert(size(im,3) == 1) ;
 output = uint8 ( zeros(size(im) ) ) ;
 winsizehalf = floor(winsize/2) ;
 im = padarray ( im, [winsizehalf,winsizehalf],'symmetric','both');

for i = winsizehalf+1:size(im,1)-winsizehalf
   for j = winsizehalf+1:size(im,2)-winsizehalf
       contextualregion=im(i-winsizehalf:i+winsizehalf,j-winsizehalf:j+winsizehalf) ;
       rank=sum(sum(contextualregion<im(i,j))) ;
        output(i-winsizehalf,j-winsizehalf)=rank*255/(winsize*winsize);
   end
end
figure( )
imshow(output) ;
end