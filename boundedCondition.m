function [KTB,PTB]=boundedCondition(KT,PT,m,n,py,tbien)
g = 1;
cs = matrixIndex(m,n,py);
DKB = zeros((n+1)*(py+1),1);
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
hang = m*(n+1)*(py+1);
[KTB,PTT]=deleteRow(hang,KT,DKB,PT,tbien);
% BVD = BVD_new
index = 1:hang;
del_index = setdiff(index,DKB);
PTB = PTT(del_index);
end