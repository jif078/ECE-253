function Im_1 = AHE_func(Im_1, W_size)
N=(W_size-1)/2;
[m,n]=size(Im_1);
%pre-requirement
Im_11=padarray(Im_1,[N,N],'symmetric');
for i=1+N:m+N
    for j=1+N:n+N
        region=Im_11(i-N:i+N,j-N:j+N);
        rank=sum(sum(region<Im_11(i,j)));
        Im_1(i-N,j-N)=rank*255/(2*N+1)^2;
    end
end
