function [val0,val1,val2] = seq_comp_convert(valA,valB,valC)
    % Get phase elements from sequence components
    alf = 1*cos(120*pi/180)+i*1*sin(120*pi/180);
    matrix = [1 1 1; 1 alf alf*alf; 1 alf*alf alf];
    matrix2 = [valA; valB; valC];
    matrix = matrix*matrix2;
    val0 = matrix(1,1);
    val1 = matrix(2,1);
    val2 = matrix(3,1);
end