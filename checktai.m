function [W,phantu] = checktai(Z,L,D)
coordinate = [-1/sqrt(3) -1/sqrt(3);
    1/sqrt(3) -1/sqrt(3);
    1/sqrt(3) 1/sqrt(3);
    -1/sqrt(3) 1/sqrt(3)];
k_mau = L/(size(Z,1)-1);
l_mau = pi*D/(size(Z,2)-1);
phantu = zeros(size(Z,1)-1,size(Z,2)-1);
pG = zeros(4,1);
for i = 1:size(Z,1)-1
    for j = 1:size(Z,2)-1
        for k = 1:4
            psi = coordinate(k,1);
            eta = coordinate(k,2);
            N1 = 1/4*(1-psi)*(1-eta);
            N2 = 1/4*(1+psi)*(1-eta);
            N3 = 1/4*(1+psi)*(1+eta);
            N4 = 1/4*(1-psi)*(1+eta);
            pG(k) = N1*Z(i,j+1)+N2*Z(i+1,j+1)+N3*Z(i+1,j)+N4*Z(i,j);
            phantu(i,j) = sum(pG)*k_mau*l_mau/4;
        end
    end
end
W = sum(phantu,'all');
end