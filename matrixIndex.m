function cs=matrixIndex(m,n,py)
dk=0;
duu=0;
cs=zeros(m*n*py,8);
for i=1:m*n*py
    if (duu==0)
        if (i==1)
            cs(1,1)=1;
            cs(1,2)=2;
            cs(1,3)=3;
            cs(1,4)=4;
        end
        if (i==2)
            cs(2,1)=cs(1,2);
            cs(2,2)=cs(1,2)+3;
            cs(2,3)=cs(1,3)+3;
            cs(2,4)=cs(1,3);
        end
        if ((i>2) && (i<m))
            cs(i,1)=cs(i-1,2);
            cs(i,2)=cs(i-1,2)+2;
            cs(i,3)=cs(i-1,3)+2;
            cs(i,4)=cs(i-1,3);
        end
        if (i==m)
            cs(i,1)=cs(i-1,2);
            cs(i,2)=cs(1,1);
            cs(i,3)=cs(1,4);
            cs(i,4)=cs(i-1,3);
        end
        if (dk>=1)
            if (i==dk*m+1)
                cs(i,1)=cs(i-m,4);
                cs(i,2)=cs(i-m,3);
                cs(i,3)=cs(i-1,4)+1;
                cs(i,4)=cs(i-1,4)+2;
            end
            if (i==dk*m+2)
                cs(i,1)=cs(i-m,4);
                cs(i,2)=cs(i-m,3);
                cs(i,3)=cs(i-1,3)+2;
                cs(i,4)=cs(i-1,3);
            end
            if (i>dk*m+2 && i<(dk+1)*m)
                cs(i,1)=cs(i-m,4);
                cs(i,2)=cs(i-m,3);
                cs(i,3)=cs(i-1,3)+1;
                cs(i,4)=cs(i-1,3);
            end
            if (i==(dk+1)*m)
                cs(i,1)=cs(i-m,4);
                cs(i,2)=cs(i-m,3);
                cs(i,3)=cs(i-m+1,4);
                cs(i,4)=cs(i-1,3);
            end
        end
        if (mod(i,m)==0)
            dk=dk+1;
        end
        cs(i,5)=cs(i,1)+m*(n+1);
        cs(i,6)=cs(i,2)+m*(n+1);
        cs(i,7)=cs(i,3)+m*(n+1);
        cs(i,8)=cs(i,4)+m*(n+1);
    else
        if (duu~=0)
            cs(i,1)=cs(i-m*n,5);
            cs(i,2)=cs(i-m*n,6);
            cs(i,3)=cs(i-m*n,7);
            cs(i,4)=cs(i-m*n,8);
            cs(i,5)=cs(i,1)+m*(n+1);
            cs(i,6)=cs(i,2)+m*(n+1);
            cs(i,7)=cs(i,3)+m*(n+1);
            cs(i,8)=cs(i,4)+m*(n+1);
        end
    end
    du = mod(i,m*n);
    if (du==0)
        duu = duu+1;
    end
end
end