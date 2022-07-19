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
T_plot_be_day_reshape = reshape(T_plot_be_day,[(k+2)*(k2+2) 1]);
[M,i_max] = max(T_plot_be_day_reshape);
X_T = X';
Y_T = Y';
X_max = X_T(i_max);
Y_max = Y_T(i_max);
T_max = M;
text(X_max + 5, Y_max + 5, T_max+5, "T_{max} ="+num2str(T_max), "FontSize",16);
hold on
s1= scatter3(X_max,Y_max,T_max);
s1.MarkerFaceColor = 'black';
s1.SizeData = 100;
Xk = (Y+38).*cosd(X);
Yk = (Y+38).*sind(X);
figure(4);
surf(Xk',Yk',T_plot_be_day);
set(gca,'XTick',[]);
set(gca,'YTick',[]);
title('Phan bo nhiet theo he toa do tru');
Xk_T = Xk';
Yk_T = Yk';
Xk_max = Xk_T(i_max);
Yk_max = Yk_T(i_max);
text(Xk_max - 20, Yk_max +20, T_max+5, "T_{max} ="+num2str(T_max), "FontSize",12);
for i = 0:90:270
    text(33*cosd(i),33*sind(i),T_max,num2str(i),"FontSize",16);
end
text(33*cosd(X_max),33*sind(X_max),T_max,num2str(round(X_max)),"FontSize",16,'HorizontalAlignment', 'center','VerticalAlignment','middle');
hold on
s2 = scatter3(Xk_max,Yk_max,T_max);
s2.MarkerFaceColor = 'black';
s2.SizeData = 100;
colormap autumn
axis equal
