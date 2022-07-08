function [BVD_new,PTT_new]=deleteRow (row,cot,AVD,BVD,hx,dt,PT,PTT,tbien)
t = 0;
dk1 = 0;
dk4 = 0;
dk5 = 0;
for i=1:row
    for j=1:dt
        if (i~=hx(j)) 
            t=t+1;
        end
    end
    if (t==dt)
        dk1=dk1+1;
        for dk2=1:cot
            for dk3=1:dt
                if (dk2~=hx(dk3))
                    dk4=dk4+1;
                end
            end
            if (dk4==dt)
                dk5=dk5+1;
                BVD(dk1,dk5)=AVD(i,dk2);
            end
            dk4=0;
        end
        dk5=0;
    end
    t=0;
end
for i=1:row
    PTT(i)=PT(i);
end
for i=1:row
    for j=1:cot
        for jj=1:dt
            if (j==hx(jj))
                PTT(i)=PTT(i)-AVD(i,j)*tbien;
            end
        end
    end
end
BVD_new=BVD;
PTT_new=PTT;
end