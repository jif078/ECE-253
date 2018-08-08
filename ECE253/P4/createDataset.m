function features=createDataset(im)
   [row,col,rgb]=size(im);
   N=row*col;
   R1=im(:,:,1);G1=im(:,:,2);B1=im(:,:,3);
   R=reshape(R1,N,1);
   G=reshape(G1,N,1);
   B=reshape(B1,N,1);
   features=double([R G B]);