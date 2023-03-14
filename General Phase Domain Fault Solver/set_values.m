function [VAS,VBS,VCS,VAR,VBR,VCR,ZSS,ZSR,ZMS,ZMR,ZSL,ZML,Z0L,Z1L,Z2L,m,RAF,RBF,RCF,RGF] = set_values()

    % set all values %
    
    VAS = 70;
    VBS = VAS*cos(-120*pi/180) + i*VAS*sin(-120*pi/180);
    VCS = VAS*cos(-240*pi/180) + i*VAS*sin(-240*pi/180);
    VAR = 80;
    VBR = VAR*cos(-120*pi/180) + i*VAR*sin(-120*pi/180);
    VCR = VAR*cos(-240*pi/180) + i*VAR*sin(-240*pi/180);

    Z0L = 24.8*cos(81.5*pi/180) + i*24.8*sin(81.5*pi/180);
    Z1L = 7.8*cos(84*pi/180) + i*7.8*sin(84*pi/180);
    Z2L = Z1L;

    ZML = (1/3)*(Z0L-Z1L);
    ZSL = Z1L + ZML;

    ZMS = ZML;
    ZSS = ZSL;

    ZMR = ZMS;
    ZSR = ZSS;

    m = 0.4;
    RAF = 0;
    RBF = 1000000;
    RCF = 1000000;
    RGF = 5;

end





