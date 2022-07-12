function [BVD,PTT]=deleteRow (row,AVD,hx,PT,tbien)
index = 1:row;
del_index = setdiff(index,hx);
BVD = AVD (del_index,del_index);
AVD_cut = AVD(:,hx);
PTT = PT - sum(AVD_cut,2)*tbien;
end