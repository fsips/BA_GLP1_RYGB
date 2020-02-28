function [p] = parameters_G(k_sp, BW)

p(1) = 70.2744;     %    GIr_beta_GB;
p(2) = 10.2676;     %    GIr_beta_SI;
p(3) = 44.3465;     %    GIr_delta_GB;
p(4) = 2.9318;      %    GIr_delta_SI;
p(5) = 0.11753;     %    k_xl;
p(6) = 0.94811;     %    frac_gb;
p(7) = 0.0028652;   %    k_xg;
p(8) = 9.0396e-05;  %    k_xi_up_si;
p(9) = 0.00019177;  %    k_xi_up_co;
p(10) = 439.0471;   %    vmax_asbt;
p(11) = 9661.5151;  %    km_asbt;
p(12) = 0.55822;    %    frac_li_pu;
p(13) = 0.89483;    %    frac_li_pc;
p(14) = 0.50645;    %    frac_li_su;
p(15) = 0.82305;    %    frac_li_sc;
p(16) = 0.0025175;  %    k_uc;
p(17) = 0.076861;   %    k_bact_dsi;
p(18) = 0.15218;    %    k_si_1;
p(19) = 0.010429;   %    k_si_2;
p(20) = 0.0021237;  %    k_co_1;
p(21) = 0.82363;    %    k_u;
p(22) = 0;          %    k_FXR1
p(23) = 0;          %    k_FXR2
p(24) = 0;          %    k_ASBT
p(25) = 1/6000;     %    k_d1
p(26) = 1/6000;     %    k_d2
p(27) = 1/6000;     %    k_d3
p(28) = 0.0027;     %    k_deh;
p(29) = 0;          %    k_dis
p(30) = 0;          %    k_app
p(31) = k_sp;       %    k_sp

%% MODEL2: Parameters 
p(32) = 0.25e-1;    %    k_st_1     
p(33) = 0.5e-1;     %    k_st_2          
p(34) = 5;          %    glp1_st  
p(35) = log(2)/2;   %    k_dpp4   
p(36) = 2;          %    vmax_quick     % pars(po.Vmax_sglt1)*0.004 (=0.004kcal/mg)   
p(37) = 3;          %    km_quick       % pars(po.Km_sglt1)*0.004 (=0.004kcal/mg)
p(38) = 0.5;        %    vmax_slow      % pars(po.Vmax_fat)*9 (9=kcal/gram) 
p(39) = 5;          %    km_slow        % pars(po.Km_fat)*9 (9=kcal/gram)
p(40) = 3;          %    GLP1_c1 (quick stimulated secretion)  % pars(po.GLP1_c1)*0.004
p(41) = 0.001;      %    GLP1_c2 (slow stimulated secretion)   % pars(po.GLP1_c5)*9
p(42) = 1-50*3/450; %    GLP1 secretion distribution parameter a
p(43) = 3/450;      %    GLP1 secretion distribution parameter b

p(44) = 2*p(35)/18; %    Denaturation speed
% Basal total GLP-1 concentration: 20 (so inactive: 18) pmol/L (Bagger/Nguyen)
% Basal active GLP-1 concentration: 2 pmol/L (Bagger/Nguyen)
% Input into pool = 2*p(35)
% Output from pool = 18*p(44)

p(45) = 2*p(35);    %    Basal GLP-1 secretion
p(46) = 0.111*BW;   %    GLP-1 distribution volume. 
p(47) = 0.002;      %    k_BAGLP1
p(48) = 20;        %    change in stomach volume in RYGB


end