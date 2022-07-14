function Z = sor(k,k2,F2,F,L,D,eps,muy_in,n)
%% Time step
%% Variable
%% Parameter
R = D/2;
C=0.038e-3;
% pc=0;
beta_old=1e8;
beta = beta_old*C^2/muy_in/(2*pi*n)/R^2;
omega = 0.3;
si=1e-6;
delta_x=2*pi/(k-1);
delta_y=L/R/(k2-1);
%% Initial value
theta_old = 1*ones(k+2,k2+2);
theta_old(2:k+1,2:k2+1)=rand(k,k2)*2;
%% Simulation
% a=zeros(k,k2);
x = linspace(0,2*pi,k);
y = linspace(0,L/R,k2);
[X,Y]=meshgrid(x,y);
h=1+eps*cos(x);
h=[h(1) h h(k)];
h=h';
h=repmat(h,[1 k2+2]);
theta_new=theta_old;
g = theta_new > 1;
g = g*1.0;
for kk=1:60000
    theta_old=theta_new;
    for i=2:k+1
        for j=2:k2+1
            h_forw_x=(h(i,j)+h(i+1,j))/2;
            h_back_x=(h(i,j)+h(i-1,j))/2;
            h_forw_y=(h(i,j+1)+h(i,j))/2;
            h_back_y=(h(i,j-1)+h(i,j))/2;
            aii=F(i,j)/delta_x*((1-g(i,j))*h(i,j))+beta*F2(i,j)/delta_x^2*(g(i,j)*(h_forw_x^3+h_back_x^3))+beta*F2(i,j)/delta_y^2*(g(i,j)*(h_forw_y^3+h_back_y^3));
            b1=F(i,j)/delta_x*((1-g(i-1,j))*h(i-1,j))+beta*F2(i,j)/delta_x^2*(g(i-1,j)*h_back_x^3);
            b2=beta*F2(i,j)/delta_x^2*g(i+1,j)*h_forw_x^3;
            b3=beta*F2(i,j)/delta_y^2*g(i,j-1)*h_back_y^3;
            b4=beta*F2(i,j)/delta_y^2*g(i,j+1)*h_forw_y^3;
            b5=F(i,j)/delta_x*((g(i-1,j)*(2-g(i,j))/2)*h(i-1,j)+g(i,j)*(g(i-1,j)-2+g(i+1,j))/2*h(i,j)-(g(i+1,j)*g(i,j))/2*h(i+1,j));
            b6=beta*F2(i,j)/delta_x^2*(-g(i-1,j)*h_back_x^3+g(i,j)*(h_forw_x^3+h_back_x^3)-g(i+1,j)*h_forw_x^3);
            b7=beta*F2(i,j)/delta_y^2*(-g(i,j-1)*h_back_y^3+g(i,j)*(h_forw_y^3+h_back_y^3)-g(i,j+1)*h_forw_y^3);
            theta_new(i,j) = (1-omega)*theta_new(i,j)+omega/aii*(b1*theta_new(i-1,j)+b2*theta_new(i+1,j)+b3*theta_new(i,j-1)+b4*theta_new(i,j+1)+b5+b6+b7);
            if theta_new(i,j)>1
                g(i,j)=1;
            else
                g(i,j)=0;
            end
        end
    end
    if norm(theta_new-theta_old)<si
        break
    end
end
fprintf('Thuat toan hoi tu sau %d lan lap\n',kk);

theta1 = theta_new(2:k+1,round((k2+1)/8));
theta2 = theta_new(2:k+1,round((k2+1)/2));
p1 = beta*log(theta1);
p2 = beta*log(theta2);
p1 = (p1>0) .* p1;
p2 = (p2>0) .* p2;
% figure(1);
% plot(x,p1,'-o',x,p2,'-o');
% figure(2);
% theta = theta_new(2:k+1,2:k2+1);
theta = beta*log(theta_new);
Z = (theta>0).*(theta);
% surf(X',Y',Z);
end