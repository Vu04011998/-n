k = 20;
k1 =15;
k2 =15;
T_dau = 45+5*rand(k+2,k1+2,k2+2);
T_dau(1,:,:) = 45;
T_dau(k+2,:,:) =45;
T_dau(:,1,:)=45;
T_dau(:,k1+2,:)=50;
delta = 1e-3;
L = 315e-2;
D = 190e-3;
C = 0.038e-3;
eps = 0.7;
mein = 0.026;
n = 50;
T_out_old = T_dau;
for i=1:7
[F1_,F0_,F3,F,F2,A1,B1,muy,hamy_]=tinhF1_(T_dau,eps);
Z = sor(k,k2,F2,F,L,D,eps,mein,n);
[u_,v_,w_]=tinhvantoc(Z,A1,B1,L,D,eps);
T_chuan = T_dau/45;
[T_out,kk]=giaiptmangdau(u_,v_,w_,muy,hamy_,T_chuan,L,D,eps,n,mein);
T_dau = T_out *45;
if sqrt(sum((T_dau-T_out_old).^2,"all"))<delta
    break
end
T_out_old = T_dau;
end

figure(1);
T_plot_bac = T_dau(:,2,:);
T_plot_bac = reshape (T_plot_bac,[k+2 k2+2]);
T_plot_bac = T_plot_bac(:,2:k2+1);
x = linspace(0,2*pi*D/2,k+2);
y = linspace(0,L,k2);
[X,Y]=meshgrid(x,y);
surf(X',Y',T_plot_bac);
title('Phan bo nhiet cua mang dau tai mat tiep xuc voi bac');
xlabel('Phuong chu vi(m)');
ylabel('Phuong chieu dai(m)');
zlabel('Nhiet do (do C)');
figure(2);
T_plot_nhiet = T_plot_bac(:,round(k2/2));
plot(x,T_plot_nhiet,'-ro');
title('Phan bo nhiet cua mang dau theo phuong chu vi');
xlabel('Chu vi (m)');
ylabel('Nhiet do (do C)');

T_plot_be_day = T_dau(:,:,round((k2+2)/2));
x = linspace(0,360,k+2);
y = linspace(0,1,k1+2);
[X,Y] = meshgrid(x,y);
H = C*(1+eps*cosd(X));
Y = Y.*H*1e6;
figure(3);
surf(X',Y',T_plot_be_day);
colormap autumn
xlabel('Goc (do)');
ylabel('Be day (\mum)');
title('Phan bo nhiet theo be day mang dau');
Xk = (Y+38).*cosd(X);
Yk = (Y+38).*sind(X);
figure(4);
surf(Xk',Yk',T_plot_be_day);
xlabel('X(\mum)');
ylabel('Y(\mum)');
title('Phan bo nhiet theo he toa do tru');
colormap autumn
axis equal
