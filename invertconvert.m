function cd = invertconvert(cc,m,n,py)       
% Chuyển ma trận lưu thông tin 8 điểm lân cận của tất cả các nút về dạng
% lưới 3D
% cc là ma trận thông tin 8 điểm lân cận của các nút
% m,n,py là số chiều của lưới 
% cd là ma trận lưới 3D của các nút.
duu = 1;
di =1;
dj = 1;
cd = zeros(m+1,n+1,py+1);
for i=1:m*n*py
    cd(di,dj,duu) = cc(i,1);
    cd(di+1,dj,duu) =cc(i,2);
    cd(di+1,dj+1,duu) = cc(i,3);
    cd(di,dj+1,duu) = cc(i,4);
    cd(di,dj,duu+1) = cc(i,5);
    cd(di+1,dj,duu+1) =cc(i,6);
    cd(di+1,dj+1,duu+1)=cc(i,7);
    cd(di,dj+1,duu+1)=cc(i,8);
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
end