function y=S_quantize(Im,s)
    Im=double(Im);
    assert(s>=1&s<=7);
    step=round(255/2^s);
    T=0:step:255;
    T(end+1)=255;
    %[m,n]=size(Im);
    y=zeros(size(Im));
    
    for i=1:length(T)-1
        y(Im>T(i)&Im<=T(i+1))=round((T(i)+T(i+1))/2);
    end