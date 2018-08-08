
function [rho,X]=HF(E)
%HF transform
[a,b]=size(E);
long=sqrt((a-1)^2+(b-1)^2);
fl=floor(-long);ce=ceil(long);
[m,n]=find(E);
N=length(m);
the=-90:90;rho=zeros(N,181);
for i=1:N
    rho(i,:)=(m(i)-1)*cosd(the)+(n(i)-1)*sind(the);
end
X=zeros(ce-fl+1,181);
for i=1:N
    for j=1:181
        xk=round(rho(i,j))+ce;
        X(xk,j)=X(xk,j)+1;
    end
end