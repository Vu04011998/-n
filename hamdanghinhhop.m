function [N1h,dn1hx,dn1hz,dn1ht]=hamdanghinhhop()
phu1 = sqrt(1/3);
N1h = zeros(8,8);
dn1hx = zeros(8,8);
dn1hz = zeros(8,8);
dn1ht = zeros(8,8);
const_parameter = [-1 -1 -1;
    1 -1 -1;
    1 1 -1;
    -1 1 -1;
    -1 -1 1;
    1 -1 1;
    1 1 1;
    -1 1 1];
for i=1:8
    r = const_parameter(i,1)*phu1;
    s = const_parameter(i,2)*phu1;
    t = const_parameter(i,3)*phu1;
    N1h(i,1)=(1-r)*(1-s)*(1-t)/8;
    N1h(i,2)=(1+r)*(1-s)*(1-t)/8;
    N1h(i,3)=(1+r)*(1+s)*(1-t)/8;
    N1h(i,4)=(1-r)*(1+s)*(1-t)/8;
    N1h(i,5)=(1-r)*(1-s)*(1+t)/8;
    N1h(i,6)=(1+r)*(1-s)*(1+t)/8;
    N1h(i,7)=(1+r)*(1+s)*(1+t)/8;
    N1h(i,8)=(1-r)*(1+s)*(1+t)/8;

    dn1hx(i,1)=-(1-s)*(1-t)/8;
    dn1hx(i,2)=(1-s)*(1-t)/8;
    dn1hx(i,3)=(1+s)*(1-t)/8;
    dn1hx(i,4)=-(1+s)*(1-t)/8;
    dn1hx(i,5)=-(1-s)*(1+t)/8;
    dn1hx(i,6)=(1-s)*(1+t)/8;
    dn1hx(i,7)=(1+s)*(1+t)/8;
    dn1hx(i,8)=-(1+s)*(1+t)/8;

    dn1hz(i,1)=-(1-r)*(1-t)/8;
    dn1hz(i,2)=-(1+r)*(1-t)/8;
    dn1hz(i,3)=(1+r)*(1-t)/8;
    dn1hz(i,4)=(1-r)*(1-t)/8;
    dn1hz(i,5)=-(1-r)*(1+t)/8;
    dn1hz(i,6)=-(1+r)*(1+t)/8;
    dn1hz(i,7)=(1+r)*(1+t)/8;
    dn1hz(i,8)=(1-r)*(1+t)/8;

    dn1ht(i,1)=-(1-r)*(1-s)/8;
    dn1ht(i,2)=-(1+r)*(1-s)/8;
    dn1ht(i,3)=-(1+r)*(1+s)/8;
    dn1ht(i,4)=-(1-r)*(1+s)/8;
    dn1ht(i,5)=(1-r)*(1-s)/8;
    dn1ht(i,6)=(1+r)*(1-s)/8;
    dn1ht(i,7)=(1+r)*(1+s)/8;
    dn1ht(i,8)=(1-r)*(1+s)/8;
end
end