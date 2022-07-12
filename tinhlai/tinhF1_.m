function [F1_,F0_,F3,F,F2]=tinhF1_(T_dau)
K = 0.034;
T0 = 45;
muy = exp(-K*(T_dau-T0));
k1 = size(T_dau,2)-1;
y1 = 1/k1;
hamy_ = zeros(size(T_dau));
for i = 0:k1
    hamy_(:,i+1,:)=y1*i;
end
hamF1_ = hamy_./muy;
F1_ = sum(hamF1_,2)*y1;
hamF0_ = 1./muy;
F0_ = sum(hamF0_,2)*y1;
F3 = F1_./F0_;
F = 1-F3;
hamF2 = hamy_./muy.*(hamy_-F3);
F2 = sum(hamF2,2)*y1;
F = reshape(F,size(F,1),size(F,3));
F2 = reshape(F2,size(F2,1),size(F2,3));
end