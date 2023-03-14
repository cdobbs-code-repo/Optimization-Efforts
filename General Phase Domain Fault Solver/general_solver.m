function [IAS,IBS,ICS,IAR,IBR,ICR,VASr,VBSr,VCSr,VARr,VBRr,VCRr] = general_solver(VAS,VBS,VCS,VAR,VBR,VCR,ZSS,ZSR,ZMS,ZMR,ZSL,ZML,m,RAF,RBF,RCF,RGF)

    % general solver %
    
    temp_matrix = [m*ZSL+ZSS m*ZML+ZMS m*ZML+ZMS -(1-m)*ZSL-ZSR -(1-m)*ZML-ZMR -(1-m)*ZML-ZMR VAS-VAR;...
    m*ZML+ZMS m*ZSL+ZSS m*ZML+ZMS -(1-m)*ZML-ZMR -(1-m)*ZSL-ZSR -(1-m)*ZML-ZMR VBS-VBR;...
    m*ZML+ZMS m*ZML+ZMS m*ZSL+ZSS -(1-m)*ZML-ZMR -(1-m)*ZML-ZMR -(1-m)*ZSL-ZSR VCS-VCR;...
    ZMS+m*ZML+RGF ZMS+m*ZML+RGF ZSS+m*ZSL+RCF+RGF RGF RGF RCF+RGF VCS;...
    ZMS+m*ZML+RGF ZSS+m*ZSL+RBF+RGF ZMS+m*ZML+RGF RGF RBF+RGF RGF VBS;...
    ZSS+m*ZSL+RAF+RGF ZMS+m*ZML+RGF ZMS+m*ZML+RGF RAF+RGF RGF RGF VAS];
    temp_matrix = rref(temp_matrix);
    
    IAS = temp_matrix(1,7);
    IBS = temp_matrix(2,7);
    ICS = temp_matrix(3,7);
    IAR = temp_matrix(4,7);
    IBR = temp_matrix(5,7);
    ICR = temp_matrix(6,7);
    
    VASr = VAS - IAS*ZSS - IBS*ZMS - ICS*ZMS;
    VBSr = VBS - IAS*ZMS - IBS*ZSS - ICS*ZMS;
    VCSr = VCS - IAS*ZMS - IBS*ZMS - ICS*ZSS;
    
    VARr = VAR - IAR*ZSR - IBR*ZMR - ICR*ZMR;
    VBRr = VBR - IAR*ZMR - IBR*ZSR - ICR*ZMR;
    VCRr = VCR - IAR*ZMR - IBR*ZMR - ICR*ZSR;

end





