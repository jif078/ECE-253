function [idx,centers,It]=kMeansCluster(features,centers,n_clst)
  for It=1:100
    dst=pdist2(features,centers);
    N=size(features,1);
    sum=zeros(n_clst,3);
    num=zeros(n_clst,1);
    idx=zeros(N,1);
    for i=1:N
        idv=min(dst(i,:));
        idx(i)=find(dst(i,:)==idv,1);
      for j=1:n_clst
          if idx(i)==j
           sum(j,:)=sum(j,:)+features(i,:);
           num(j)=num(j)+1;
          end
      end
    end
   centers_new=sum./[num num num];
   E=isequal(centers,centers_new);
   centers=centers_new;
   if E==1
      break
   end
 end