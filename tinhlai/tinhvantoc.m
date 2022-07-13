function [u_,w_]=tinhvantoc(p_,A1,B1)
p_=reshape(p_,[size(p_,1) 1 size(p_,2)]);
p_ = repmat(p_,[1 size(A1,2) 1]);
[~,dn1hr,~,dn1ht]=hamdanghinhhop();
k = size(A1,1)-1;
k1 = size(A1,2)-1;
k2 = size(A1,3)-1;
L = 190e-3;
D=315e-3;
R = D/2;
x1 = 2*pi/k;
y1 = 1/k1;
z1 = L/R/k2;
J = diag([x1 y1 z1]);
dp_dx = zeros(size(A1));
dp_dz = zeros(size(A1));
for i1 = 1:k
    for i2 = 1:k1
        for i3 = 1:k2
            p_curr = [p_(i1,i2,i3);p_(i1+1,i2,i3);p_(i1+1,i2+1,i3);p_(i1,i2+1,i3);p_(i1,i2,i3+1);p_(i1+1,i2,i3+1);p_(i1+1,i2+1,i3+1);p_(i1,i2+1,i3+1)];
            dp_dr = 2/x1*dn1hr*p_curr;

            dp_dx(i1,i2,i3)=dp_dr(1);
            dp_dx(i1+1,i2,i3)=dp_dr(2);
            dp_dx(i1+1,i2+1,i3)=dp_dr(3);
            dp_dx(i1,i2+1,i3)=dp_dr(4);
            dp_dx(i1,i2,i3+1)=dp_dr(5);
            dp_dx(i1+1,i2,i3+1)=dp_dr(6);
            dp_dx(i1+1,i2+1,i3+1)=dp_dr(7);
            dp_dx(i1,i2+1,i3+1)=dp_dr(8);

            dp_dt = 2/z1*dn1ht*p_curr;
            
            dp_dz(i1,i2,i3)=dp_dt(1);
            dp_dz(i1+1,i2,i3)=dp_dt(2);
            dp_dz(i1+1,i2+1,i3)=dp_dt(3);
            dp_dz(i1,i2+1,i3)=dp_dt(4);
            dp_dz(i1,i2,i3+1)=dp_dt(5);
            dp_dz(i1+1,i2,i3+1)=dp_dt(6);
            dp_dz(i1+1,i2+1,i3+1)=dp_dt(7);
            dp_dz(i1,i2+1,i3+1)=dp_dt(8);
        end
    end
end
u_ = dp_dx.*A1+B1;
w_ = dp_dz.*A1;
v_ = zeros(size(u_));
du_dx = zeros(size(A1));
dw_dz = zeros(size(A1));

for i1 = 1:k
    for i2 = 1:k1
        for i3 = 1:k2
            u_curr = [u_(i1,i2,i3);u_(i1+1,i2,i3);u_(i1+1,i2+1,i3);u_(i1,i2+1,i3);u_(i1,i2,i3+1);u_(i1+1,i2,i3+1);u_(i1+1,i2+1,i3+1);u_(i1,i2+1,i3+1)];
            du_dr = 2/x1*dn1hr*u_curr;

            du_dx(i1,i2,i3)=du_dr(1);
            du_dx(i1+1,i2,i3)=du_dr(2);
            du_dx(i1+1,i2+1,i3)=du_dr(3);
            du_dx(i1,i2+1,i3)=du_dr(4);
            du_dx(i1,i2,i3+1)=du_dr(5);
            du_dx(i1+1,i2,i3+1)=du_dr(6);
            du_dx(i1+1,i2+1,i3+1)=du_dr(7);
            du_dx(i1,i2+1,i3+1)=du_dr(8);
            
            u_curr = [u_(i1,i2,i3);u_(i1+1,i2,i3);u_(i1+1,i2+1,i3);u_(i1,i2+1,i3);u_(i1,i2,i3+1);u_(i1+1,i2,i3+1);u_(i1+1,i2+1,i3+1);u_(i1,i2+1,i3+1)];
            dw_dt = 2/z1*dn1ht*p_curr;
            
            dp_dz(i1,i2,i3)=dp_dt(1);
            dp_dz(i1+1,i2,i3)=dp_dt(2);
            dp_dz(i1+1,i2+1,i3)=dp_dt(3);
            dp_dz(i1,i2+1,i3)=dp_dt(4);
            dp_dz(i1,i2,i3+1)=dp_dt(5);
            dp_dz(i1+1,i2,i3+1)=dp_dt(6);
            dp_dz(i1+1,i2+1,i3+1)=dp_dt(7);
            dp_dz(i1,i2+1,i3+1)=dp_dt(8);
        end
    end
end
end