function y=compute_norm_rgb_histogram(Im)
         y=zeros(1,96);
         r=Im(:,:,1);
         g=Im(:,:,2);
         b=Im(:,:,3);
         [m,n]=size(r);
         for k=1:32
         for i=1:m
             for j=1:n
                 if r(i,j)>=8*(k-1) && r(i,j)<8*k
                     y(k)=y(k)+1;
                 end
             end
         end
         end
         
         
         
         for k=33:64
         for i=1:m
             for j=1:n
                 if g(i,j)>=8*(k-33) && g(i,j)<8*(k-32)
                     y(k)=y(k)+1;
                 end
             end
         end
         end
         
         
         
         
         for k=65:96
         for i=1:m
             for j=1:n
                 if b(i,j)>=8*(k-65) && b(i,j)<8*(k-64)
                     y(k)=y(k)+1;
                 end
             end
         end
         end
                  
                  
                  
                  
