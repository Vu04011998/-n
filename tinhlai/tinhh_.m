function h_=tinhh_(k,k2)
eps = 0.7;
x = linspace(0,2*pi,k+2);
h_=(1+eps*cos(x));
h_=h_';
h_=repmat(h_,[1 k2+2]);
end
