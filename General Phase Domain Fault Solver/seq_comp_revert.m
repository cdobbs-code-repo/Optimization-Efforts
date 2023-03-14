function [Aph,Bph,Cph] = seq_comp_revert(val0,val1,val2)
    % Get phase elements from sequence components
    alf = 1*cos(120*pi/180)+i*1*sin(120*pi/180);
    matrix = [1 1 1; 1 alf*alf alf; 1 alf alf*alf];
    matrix2 = [val0; val1; val2];
    matrix = matrix*matrix2;
    Aph = matrix(1,1);
    Bph = matrix(2,1);
    Cph = matrix(3,1);
end