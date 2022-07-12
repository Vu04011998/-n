function xp11 = solvePDE(hs,tr)
xp11 = pinv(hs)*tr;
end