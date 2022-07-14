function [T_dau,kk]=giaiptmangdau(u_,v_,w_,muy,y_,T_old,L,D,eps,n,mein)
k=size(u_,1)-2;
k1 = size(u_,2)-2;
k2 = size(u_,3)-2;
x = linspace(0,2*pi,k);
h_=1+eps*cos(x);
h_=[h_(1) h_ h_(k)];
h_ = h_';
h_=repmat(h_,[1 size(u_,2) k2+2]);
h_phi = -eps*sin(x);
h_phi = [h_phi(1) h_phi h_phi(k)];
h_phi = h_phi';
h_phi = repmat(h_phi,[1 size(u_,2) k2+2]);
R = D/2;
x1 = 2*pi/k;
y1 = 1/k1;
z1 = L/R/k2;
ro = 860;
Cp = 2000;
C = 0.038e-3;
k_nhiet = 0.034;
Tin = 45;
si = 1e-6;
omega = 1;
Pe = ro * Cp * (2*pi*n)*C^2/k_nhiet;
Ne = R^2*(2*pi*n)^2/Cp/Tin;
Re = ro*C^2*2*pi*n/mein;
f1 = 1/Pe;
f2 = Ne/Re;
T_new = T_old;
for kk = 1:20000
    T_old = T_new;
    for i1 = 2:k+1
        for i2 = 2:k1+1
            for i3 = 2:k2+1
                aii = f1/h_(i1,i2,i3)^2/y1^2*2;
                bi = f1/h_(i1,i2,i3)^2*(T_new(i1,i2+1,i3)+T_new(i1,i2-1,i3))/y1^2+f2*muy(i1,i2,i3)/h_(i1,i2,i3)^2 ...
                *((u_(i1,i2+1,i3)-u_(i1,i2-1,i3))^2+(w_(i1,i2+1,i3)-w_(i1,i2-1,i3))^2)/4/y1^2-u_(i1,i2,i3)* ...
                (T_new(i1+1,i2,i3)-T_new(i1-1,i2,i3))/2/x1-1/h_(i1,i2,i3)*(v_(i1,i2,i3)-u_(i1,i2,i3)*y_(i1,i2,i3)*h_phi(i1,i2,i3))...
                * (T_new(i1,i2+1,i3)-T_new(i1,i2-1,i3))/2/y1-w_(i1,i2,i3)*(T_new(i1,i2,i3+1)-T_new(i1,i2,i3-1))/2/z1;
                T_new(i1,i2,i3) = (1-omega)*T_new(i1,i2,i3)+omega/aii*bi;
            end
        end
    end
    if sqrt(sum((T_new-T_old).^2,"all"))<si
        break
    end
end
T_dau = T_new;
end