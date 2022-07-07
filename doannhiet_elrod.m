%% Reset environment
clear;
close all;
clc;
%% Time step
%% Variable
%% Parameter
D=0.07;
L=0.07;
C=0.038e-3;
eps=0.3;
pc=0;
beta=1e8;
muy=0.039;
n = 25;
omega =0.3;
si=1e-6;
delta_x=2*pi/59;
delta_y=0.07/14;
U=19.7;
%% Initial value
theta_old = 1*ones(62,17);
theta_old(2:61,2:16)=rand(60,15)*2;
%% Simulation
a=zeros(60,15);
x = linspace(0,2*pi,60);
y = linspace(0,0.07,15);
[X,Y]=meshgrid(x,y);
h=C*(1+eps*cos(x));
h=[h(1) h h(60)];
h=h';
h=repmat(h,[1 17]);
theta_new=theta_old;
g = theta_new > 1;
g = g*1.0;
for k=1:20000
    theta_old=theta_new;
    for i=2:61
        for j=2:16
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

theta1 = theta_new(2:61,3);
theta2 = theta_new(2:61,9);
p1 = beta/100000*log(theta1);
p2 = beta/100000*log(theta2);
p1 = (p1>0) .* p1;
p2 = (p2>0) .* p2;
figure(1);
plot(x,p1,'-o',x,p2,'-o');
figure(2);
theta = theta_new(2:61,2:16);
theta = beta/100000*log(theta);
Z = (theta>0).*(theta);
surf(X',Y',Z);