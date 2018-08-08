Im_lena=imread('lena512.tif');
[m_lena,n_lena]=size(Im_lena);

lena_set=reshape(Im_lena,m_lena*n_lena,1);
[pa_lena,co_lena]=lloyds(double(lena_set),2^7);