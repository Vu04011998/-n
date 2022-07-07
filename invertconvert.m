function result = invertconvert(cc,m,n,py,cd)
duu = 1;
di =1;
dj = 1;
for i=1:m*n*py
    cd(di,dj,duu) = cc(i,1);
    cd(di+1,dj,duu) =cc(i,2);
    cd(di+1,dj+1,duu) = cc(i,3);
    cd(di,dj+1,duu) = cc(i,4);
    cd(di+1,dj,duu+1) =cc(i,5);
    cd(di+1,dj+1,duu+1)=cc(i,6);
    cd(di,dj+1,duu+1)=cc(i,7);
    di = di+1;
    if (di==m+1)
        di=1;
        dj=dj+1;
    end
    du=mod(i,m*n);
    if (du==0)
        duu=duu+1;
        di=1;
        dj=1;
    end
end
result = cd;
end