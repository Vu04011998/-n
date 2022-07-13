k = 15;
k1 =12;
k2 =10;
T_dau = 45+5*rand(k+2,k1+2,k2+2);
T_dau(1,:,:) = 45;
T_dau(k+2,:,:) =45;
T_dau(:,:,1) = 50;
T_dau(:,:,k2+2) = 50;
L = 315e-3;
D = 190e-3;
eps = 0.7;
mein = 0.026;
n = 50;
for i=1:5
[F1_,F0_,F3,F,F2,A1,B1,muy,hamy_]=tinhF1_(T_dau,eps);
Z = sor(k,k2,F2,F,L,D,eps,mein,n);
[u_,v_,w_]=tinhvantoc(Z,A1,B1,L,D,eps);
T_chuan = T_dau/45;
[T_out,kk]=giaiptmangdau(u_,v_,w_,muy,hamy_,T_chuan,L,D,eps,n,mein);
T_dau = T_out *45;
end

T_plot_bac = T_dau(:,2,:);
T_plot_bac = reshape (T_plot_bac,[k+2 k2+2]);
T_plot_bac = T_plot_bac(2:k+1,2:k2+1);
x = linspace(0,2*pi*D/2,k);
y = linspace(0,L,k2);
[X,Y]=meshgrid(x,y);
surf(X',Y',T_plot_bac);