T_dau = 5*rand(62,20,17)+45;
[F1_,F0_,F3,F,F2,A1,B1]=tinhF1_(T_dau);
Z = sor(60,15,F2,F);
[u_,v_,w_]=tinhvantoc(Z,A1,B1);