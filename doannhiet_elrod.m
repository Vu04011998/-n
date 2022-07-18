%% Reset environment
clear;
close all;
clc;
%% Time step
%% Variable
%% Parameter
k = 60;
k1 = 15;
D=315e-3;
L=190e-3;
C=0.038e-3;
eps=0.7;
pc=0;
beta=1e8; % ?
muy=0.026; 
n = 50; 
omega = 0.3;
si=1e-6;
delta_x=pi*D/(k-1);
delta_y=L/(k1-1);
U=2*pi*n*D/2;
%% Initial value
theta_old = 1*ones(k+2,k1+2);
theta_old(2:k+1,2:k1+1)=rand(k,k1)*2;
%% Simulation
a=zeros(k,k1);
x = linspace(0,2*pi*D/2,k);
y = linspace(0,L,k1);
[X,Y]=meshgrid(x,y);
h=C*(1+eps*cos(x*2/D));
h_save = h;
%figure(1);
%plot(x,h*1e6,'-o');
%ylabel(' Chieu day mang dau(um)');
%xlabel('Chu vi (m)');
%grid on;
h=[h(1) h h(k)];
h=h';
h=repmat(h,[1 k1+2]);
theta_new=theta_old;
g = theta_new > 1;
g = g*1.0;
for kk=1:60000
    theta_old=theta_new;
    for i=2:k+1
        for j=2:k1+1
            h_forw_x=(h(i,j)+h(i+1,j))/2;
            h_back_x=(h(i,j)+h(i-1,j))/2;
            h_forw_y=(h(i,j+1)+h(i,j))/2;
            h_back_y=(h(i,j-1)+h(i,j))/2;
            aii=U/(2*delta_x)*((1-g(i,j))*h(i,j))+beta/12/muy/delta_x^2*(g(i,j)*(h_forw_x^3+h_back_x^3))+beta/12/muy/delta_y^2*(g(i,j)*(h_forw_y^3+h_back_y^3));
            b1=U/2/delta_x*((1-g(i-1,j))*h(i-1,j))+beta/12/muy/delta_x^2*(g(i-1,j)*h_back_x^3);
            b2=beta/12/muy/delta_x^2*g(i+1,j)*h_forw_x^3;
            b3=beta/12/muy/delta_y^2*g(i,j-1)*h_back_y^3;
            b4=beta/12/muy/delta_y^2*g(i,j+1)*h_forw_y^3;
            b5=U/2/delta_x*((g(i-1,j)*(2-g(i,j))/2)*h(i-1,j)+g(i,j)*(g(i-1,j)-2+g(i+1,j))/2*h(i,j)-(g(i+1,j)*g(i,j))/2*h(i+1,j));
            b6=beta/12/muy/delta_x^2*(-g(i-1,j)*h_back_x^3+g(i,j)*(h_forw_x^3+h_back_x^3)-g(i+1,j)*h_forw_x^3);
            b7=beta/12/muy/delta_y^2*(-g(i,j-1)*h_back_y^3+g(i,j)*(h_forw_y^3+h_back_y^3)-g(i,j+1)*h_forw_y^3);
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
fprintf('Thuat toan hoi tu sau %d lan lap',kk);

theta1 = theta_new(2:k+1,round((k1+1)/8));
theta2 = theta_new(2:k+1,round((k1+1)/2));
p1 = beta/100000*log(theta1);
p2 = beta/100000*log(theta2);
p1 = (p1>0) .* p1;
p2 = (p2>0) .* p2;
figure(1);
yyaxis left;
plot(x,p1,'-bo',x,p2,'-ro');
ylabel('Ap suat (bar)');
yyaxis right;
plot(x,h_save*1e6,'-go');
ylabel('Be day mang dau (um)');
legend('y=L/8','y=L/2','h(x)');
title('Ap suat mang dau theo phuong chu vi');
xlabel('Chu vi (m)');
grid on;
figure(2);
theta = theta_new(2:k+1,2:k1+1);
theta = beta/100000*log(theta);
Z = (theta>0).*(theta);
surf(X',Y',Z);
xlabel('Phuong Chu vi (m)');
ylabel('Phuong Chieu dai (m)');
zlabel('Ap suat (bar)');
fprintf('Kha nang tai cua may la %.1f kN\n', checktai(Z,L,D)*100000/1000);