function result = solvePDE(hs,tr,m,xp11)
dbt = zeros(1000,1);
db =zeros(1000);
for v=1:m-1
    if (hs(v,v)==0)
        t=v+1;
        while (t<=m)
            if (hs(t,v)==0)
                for j=1:m
                    g=hs(t,j);
                    hs(t,j)=hs(v,j);
                    hs(v,j)=g;
                end
                g3=tr(t);
                tr(t)=tr(v);
                tr(v)=g3;
                t=m+1;
            else
                t=t+1;
            end
        end
    end
    for i=1:m
        dbt(i)=tr(i);
        for j=1:m
            db(i,j)=hs(i,j);
        end
    end
    for i=1:m
        for j=1:m
            if(i>v)
                g1=db(i,v)/db(v,v);
                g2=g1*dv(v,j);
                hs(i,j)=db(i,j)-g2;
            end
        end
    end
    for i=1:m
        if (i>v)
            g4=db(i,v)/db(v,v);
            g5=g4*dbt(v);
            tr(i)=dbt(i)-g5;
        end
    end
    for i=1:m
        dbt(i)=tr(i);
        for j=1:m
            db(i,j)=hs(i,j);
        end
    end
end

xp11(m)=tr(m)/hs(m,m);
g6=0;
for i=m-1:-1:1
    for j=i+1:m
        g6=g6+hs(i,j)*xp11(j);
    end
    xp11(i)=(tr(i)-g6)/hs(i,i);
    g6=0;
end
result =xp11;
end