
function [im_out,R,MSE]=gaussianUnblur(im_orig,im_in,sigma,max_iter,t)
    im_out=im_in;
    for k=1:max_iter
        A=gaussianBlur(im_out,sigma);
        B=im_in./A;
        C=gaussianBlur(B,sigma);
        im_plus=im_out.*C;
        R(k)=sum(sum((im_plus-im_out).^2))/numel(im_out);
        MSE(k)=sum(sum((im_plus-im_orig).^2))/numel(im_out);
        im_out=im_plus;
        if R(k)< t
            break
        end    
    end
          
    