function result = tonghopnd(xt,dk,dk1,dk2,nt)
dkk=1;
dtt=0;
for j=1:dk1
    for i=1:dk
        dtt=dtt+1;
        if (j==1)
            if(i==1)
                nt(dtt,1)=1.0;
                nt(dtt,2)=xt(dkk);
                nt(dtt,3)=xt(dkk+1);
                nt(dtt,4)=1.0;
                nt(dtt,5)=1.0;
                nt(dtt,6)=xt(dkk+(dk-1)*(dk1+1));
                nt(dtt,7)=xt(dkk+(dk-1)*(dk1+1)+1);
                nt(dtt,8)=1.0;
                for jj=1:dk2-1
                    di=jj*dk*dk1;
                    dj=(jj+1)*(dk-1)*(dk1+1);
                    nt(dtt+di,1)=1.0;
                    nt(dtt+di,2)=nt(dtt+di-dk*dk1,6);
                    nt(dtt+di,3)=nt(dtt+di-dk*dk1,7);
                    nt(dtt+dt,4)=1.0;
                    nt(dtt+di,5)=1.0;
                    nt(dtt+di,6)=xt(dkk+dj);
                    nt(dtt+di,7)=xt(dkk+dj+1);
                    nt(dtt+di,8)=1.0;
                end
                dkk=dkk+2;
            end
            if((i>1)&&(i<dk))
                nt(dtt,1)=nt(dtt-1,2);
                nt(dtt,2)=xt(dkk);
                nt(dtt,3)=xt(dkk+1);
                nt(dtt,4)=nt(dtt-1,3);
                nt(dtt,5)=nt(dtt-1,6);
                nt(dtt,6)=xt(dkk+(dk-1)*(dk1+1));
                nt(dtt,7)=xt(dkk+(dk-1)*(dk1+1)+1);
                nt(i,8)=nt(dtt-1,7);
                for jj=1:dk2-1
                    di=jj*dk*dk1;
                    dj=(jj+1)*(dk-1)*(dk1+1);
                    nt(dtt+di,1)=nt(dtt+di-dk*dk1,5);
                    nt(dtt+di,2)=nt(dtt+di-dk*dk1,6);
                    nt(dtt+di,3)=nt(dtt+di-dk*dk1,7);
                    nt(dtt+di,4)=nt(dtt+di-dk*dk1,8);
                    nt(dtt+di,5)=nt(dtt+di-1,6);
                    nt(dtt+di,6)=xt(dkk+dj);
                    nt(dtt+di,7)=xt(dkk+dj+1);
                    nt(dtt+di,8)=nt(dtt+di-1,7);
                end
                dkk=dkk+2;
            end
            if (i==dk)
                nt(dtt,1)=nt(dtt-1,2);
                nt(dtt,2)=nt(1,1);
                nt(dtt,3)=nt(1,4);
                nt(dtt,4)=nt(dtt-1,3);
                nt(dtt,5)=nt(dtt-1,6);
                nt(dtt,6)=nt(1,5);
                nt(dtt,7)=nt(1,8);
                nt(dtt,8)=nt(dtt-1,7);
                for jj=1:dk2-1
                    di=jj*dk*dk1;
                    nt(dtt+di,1)=nt(dtt+di-dk*dk1,5);
                    nt(dtt+di,2)=nt(dtt+di-dk*dk1,6);
                    nt(dtt+di,3)=nt(dtt+di-dk*dk1,7);
                    nt(dtt+di,4)=nt(dtt+di-dk*dk1,8);
                    nt(dtt+di,5)=nt(dtt+di-1,6);
                    nt(dtt+di,6)=nt(dtt,6);
                    nt(dtt+di,7)=nt(dtt,6);
                    nt(dtt+di,8)=nt(dtt+di-1,7);
                end
            end
        else
            if(i==1)
                nt(dtt,1)=nt(dtt-dk,4);
                nt(dtt,2)=nt(dtt-dk,3);
                nt(dtt,3)=xt(dkk);
                nt(dtt,4)=1.0;
                nt(dtt,5)=nt(dtt-dk,8);
                nt(dtt,6)=nt(dtt-dk,7);
                nt(dtt,7)=xt(dkk+(dk-1)*(dk1+1));
                nt(dtt,8)=1.0;
                for jj=1:dk2-1
                    di=jj*dk*dk1;
                    dj=(jj+1)*(dk-1)*(dk1+1);
                    nt(dtt+di,1)=1.0;
                    nt(dtt+di,2)=nt(dtt+di-dk*dk1,6);
                    nt(dtt+di,3)=nt(dtt+di-dk*dk1,7);
                    nt(dtt+di,4)=1.0;
                    nt(dtt+di,5)=1.0;
                    nt(dtt+di,6)=nt(dtt+di-dk,7);
                    nt(dtt+di,7)=xt(dkk+dj);
                    nt(dtt+di,8)=1.0;
                end
                dkk=dkk+1;
            end
            if ((i>1)&&(i<dk))
                nt(dtt,1)=nt(dtt-dk,4);
                nt(dtt,2)=nt(dtt-dk,3);
                nt(dtt,3)=xt(dkk);
                nt(dtt,4)=nt(dtt-1,3);
                nt(dtt,5)=nt(dtt-1,6);
                nt(dtt,6)=nt(dtt-dk,7);
                nt(dtt,7)=xt(dkk+(dk-1)*(dk1+1));
                nt(dtt,8)=nt(dtt-1,7);
                for jj=1:dk2-1
                    di=jj*dk*dk1;
                    dj=(jj+1)*(dk-1)*(dk1+1);
                    nt(dtt+di,1)=nt(dtt+di-dk*dk1,5);
                    nt(dtt+di,2)=nt(dtt+di-dk*dk1,6);
                    nt(dtt+di,3)=nt(dtt+di-dk*dk1,7);
                    nt(dtt+di,4)=nt(dtt+di-dk*dk1,8);
                    nt(dtt+di,5)=nt(dtt+di-1,6);
                    nt(dtt+di,6)=nt(dtt+di-dk,7);
                    nt(dtt+di,7)=xt(dkk+dj);
                    nt(dtt+di,8)=nt(dtt+di-1,7);
                end
                dkk=dkk+1;
            end
            if (i==dk)
                nt(dtt,1)=nt(dtt-1,2);
                nt(dtt,2)=nt(dtt-dk+1,1);
                nt(dtt,3)=nt(dtt-dk+1,4);
                nt(dtt,4)=nt(dtt-1,3);
                nt(dtt,5)=nt(dtt-1,6);
                nt(dtt,6)=nt(dtt-dk+1,5);
                nt(dtt,7)=nt(dtt-dk+1,8);
                nt(dtt,8)=nt(dtt-1,7);
                for jj=1:dk2-1
                    di=jj*dk*dk1;
                    nt(dtt+di,1)=nt(dtt+di-dk*dk1,5);
                    nt(dtt+di,2)=nt(dtt+di-dk*dk1,6);
                    nt(dtt+di,3)=nt(dtt+di-dk*dk1,7);
                    nt(dtt+di,4)=nt(dtt+di-dk*dk1,8);
                    nt(dtt+di,5)=nt(dtt+di-1,6);
                    nt(dtt+di,6)=nt(dtt,6);
                    nt(dtt+di,7)=nt(dtt,6);
                    nt(dtt+di,8)=nt(dtt+di-1,7);
                end
            end
        end
    end
end
result = nt;
end