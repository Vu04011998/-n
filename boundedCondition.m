function boundedCondition(KT,PT,KTB,DKB,PTB,m,n,py,tbien)
dk = 0;
g = 1;
cs = zeros(m,n,py);
for i=1:py
    for j=1:n
        jj = 1+(j-1)*m+(i-1)*m*n;
        if (i~=py)
            if (jj~=1+(n-1)*m+(i-1)*m*n)
                DKB(g)=cs(jj,1);
                g=g+1;
            else
                DKB(g)=cs(jj,1);
                DKB(g+1)=cs(jj,4);
                g=g+2;
            end
        else
            if (jj~=1+(n-1)*m+(i-1)*m*n)
                DKB(g)=cs(jj,1);
                DKB(g+1)=cs(jj,5);
                g=g+2;
            else
                DKB(g)=cs(jj,1);
                DKB(g+1)=cs(jj,5);
                DKB(g+2)=cs(jj,4);
                DKB(g+3)=cs(jj,8);
                g=g+4;
            end
        end
    end
end
ml=(n+1)*(py+1);
hang = m*(n+1)*(py+1);
cot = hang;
t9=0;
k10=0;
for i=1:hang
    for j=1:ml
        if (i~=DKB(j))
            t9=t9+1;
        end
    end
    if (t9==ml)
        k10=k10+1;
        PTB(k10)=PTT(i);
    end
    t9=0;
end
end