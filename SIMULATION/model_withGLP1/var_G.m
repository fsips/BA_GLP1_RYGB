function [out] = var_G(t, x, p, u)
% ODE file for the bile acid model + GLP-1

%% MODEL1: STATES OF THE BA MODEL

% LIVER (conjugated only)
li_pc           = x(1);
li_sc           = x(2);
% GALLBLADDER (conjugated only)
gb_pc           = x(3);
gb_sc           = x(4); 
% SI (primary ba)
si1_pu          = x(5);
si1_pc          = x(6);
si2_pu          = x(7);
si2_pc          = x(8);
si3_pu          = x(9);
si3_pc          = x(10);
si4_pu          = x(11);
si4_pc          = x(12);
si5_pu          = x(13);
si5_pc          = x(14);
si6_pu          = x(15);
si6_pc          = x(16);
si7_pu          = x(17);
si7_pc          = x(18);
si8_pu          = x(19);
si8_pc          = x(20);
si9_pu          = x(21);
si9_pc          = x(22);
si10_pu         = x(23);
si10_pc         = x(24);
co11_pu         = x(25);
co11_pc         = x(26);
co12_pu         = x(27);
co12_pc         = x(28);
co13_pu         = x(29);
co13_pc         = x(30);
co14_pu         = x(31);
co14_pc         = x(32);
co15_pu         = x(33);
co15_pc         = x(34);
% SI (secondary ba)
si1_su          = x(35);
si1_sc          = x(36);
si2_su          = x(37);
si2_sc          = x(38);
si3_su          = x(39);
si3_sc          = x(40);
si4_su          = x(41);
si4_sc          = x(42);
si5_su          = x(43);
si5_sc          = x(44);
si6_su          = x(45);
si6_sc          = x(46);
si7_su          = x(47);
si7_sc          = x(48);
si8_su          = x(49);
si8_sc          = x(50);
si9_su          = x(51);
si9_sc          = x(52);
si10_su         = x(53);
si10_sc         = x(54);
co11_su         = x(55);
co11_sc         = x(56);
co12_su         = x(57);
co12_sc         = x(58);
co13_su         = x(59);
co13_sc         = x(60);
co14_su         = x(61);
co14_sc         = x(62);
co15_su         = x(63);
co15_sc         = x(64);
% FECES 
fa_pu           = x(65);
fa_pc           = x(66);
fa_su           = x(67);
fa_sc           = x(68);
% PLASMA 
pl_pu           = x(69);
pl_pc           = x(70);
pl_su           = x(71);
pl_sc           = x(72);
% FXR REGULATION
D1              = x(73);
D2              = x(74);
D3              = x(75);
DIS             = x(76);

%% MODEL2: STATES OF THE NUTRIENT INPUT / GLP-1 MODEL

% STOMACH
st1_vol         = x(77);
st2_vol         = x(78);
st3_vol         = x(79);
st1_quick       = x(80);
st2_quick       = x(81);
st3_quick       = x(82);
st1_slow        = x(83);
st2_slow        = x(84);
st3_slow        = x(85);
st1_su          = x(86);
st2_su          = x(87);
st3_su          = x(88);
st1_sc          = x(89);
st2_sc          = x(90);
st3_sc          = x(91);
% SMALL INTESTINAL NUTRIENTS
si1_quick       = x(92);
si2_quick       = x(93);
si3_quick       = x(94);
si4_quick       = x(95);
si5_quick       = x(96);
si6_quick       = x(97);
si7_quick       = x(98);
si8_quick       = x(99);
si9_quick       = x(100);
si10_quick      = x(101);
out_quick       = x(102);
si1_slow        = x(103);
si2_slow        = x(104);
si3_slow        = x(105);
si4_slow        = x(106);
si5_slow        = x(107);
si6_slow        = x(108);
si7_slow        = x(109);
si8_slow        = x(110);
si9_slow        = x(111);
si10_slow       = x(112);
out_slow        = x(113);
% GLP1
GLP1_act        = x(114);
GLP1_ina        = x(115);

%% MODEL1: Inputs
tau             = u(1); 
V_P             = u(2); 
Q_L             = u(3); 
Q_P             = u(4); 
k_bact_psi      = u(5); 
RYGB            = u(6);
L0              = u(7);
ASBT0           = u(8);

%% MODEL2: Inputs
DPP4            = u(9);
VOL             = u(10);
QUICK           = u(11);
SLOW            = u(12);
meal_time       = u(13);
int_dist        = u(14); 
SU              = u(15);
SC              = u(16);
EXEN            = u(17); 
CC              = u(18);
SITA            = u(19);
STOM_VOLUME     = u(20);
RYGB_factor     = u(21);

%% MODEL1: Parameters 
GIr_beta_GB     = p(1)* (QUICK + SLOW) / 500; 
GIr_beta_SI     = p(2)* (1);
GIr_delta_GB    = p(3)* (QUICK + SLOW) / 500 * (1- RYGB*0.5);
GIr_delta_SI    = p(4)* (1+ RYGB*1/(1-RYGB_factor).^2); 
k_xl            = p(5); 
frac_gb         = p(6) * (1-CC); 
k_xg            = p(7); 
k_xi_up_si      = p(8); 
k_xi_up_co      = p(9); 
vmax_asbt       = p(10); 
km_asbt         = p(11); 
frac_li_pu      = p(12); 
frac_li_pc      = p(13); 
frac_li_su      = p(14); 
frac_li_sc      = p(15); 
k_uc            = p(16); 
k_bact_dsi      = p(17)* (1+ RYGB*2); 
k_si_1          = p(18)* (1- RYGB*RYGB_factor); 
k_si_2          = p(19)* (1- RYGB*RYGB_factor); 
k_co_1          = p(20)* (1- RYGB*RYGB_factor); 
k_u             = p(21); 
k_FXR1          = p(22);
k_FXR2          = p(23);
k_ASBT          = p(24);
k_d1            = p(25);
k_d2            = p(26);
k_d3            = p(27);
k_deh           = p(28);
k_dis           = p(29);
k_app           = p(30);
k_sp            = p(31);

%% MODEL2: Parameters 
k_st_1          = p(32);
k_st_2          = p(33);
glp1_st         = p(34);
k_dpp4          = p(35) / SITA;
vmax_quick      = p(36);
km_quick        = p(37);
vmax_slow       = p(38); 
km_slow         = p(39);
GLP1_c1         = p(40);
GLP1_c2         = p(41); 
GLP1_xa         = p(42);
GLP1_xb         = p(43);
k_denat         = p(44);
GLP1_basal      = p(45);
V_GLP1          = p(46);

if length(p)>46;
    k_BAGLP1    = p(47);
    if RYGB
        STOM_VOLUME = STOM_VOLUME/p(48);
    end
else
    k_BAGLP1    = 0;
    if RYGB
        STOM_VOLUME = STOM_VOLUME/10;
    end
end

%% MODEL1: Fluxes
% Intestinal transit 
k_si_trans_1_2  = k_si_1 * (1-RYGB); 
k_si_trans_1_4  = k_si_1 * (RYGB);  
k_si_trans_2_3  = k_si_1; 
k_si_trans_3_4  = k_si_1; 
k_si_trans_4_5  = k_si_1; 
k_si_trans_5_6  = k_si_1; 
k_si_trans_6_7  = k_si_1; 
k_si_trans_7_8  = k_si_1; 
k_si_trans_8_9  = k_si_1; 
k_si_trans_9_10 = k_si_2; 
k_si_trans_10_11 = k_si_2; 
k_co_trans_11_12 = k_co_1; 
k_co_trans_12_13 = k_co_1; 
k_co_trans_13_14 = k_co_1; 
k_co_trans_14_15 = k_co_1; 
k_co_trans_15_16 = k_co_1; 
% Biotransformation
bact_1          = k_bact_psi; 
bact_2          = k_bact_psi; 
bact_3          = k_bact_psi; 
bact_4          = k_bact_psi; 
bact_5          = k_bact_psi; 
bact_6          = k_bact_dsi; 
bact_7          = k_bact_dsi; 
bact_8          = k_bact_dsi; 
bact_9          = k_bact_dsi; 
bact_10         = k_bact_dsi; 
bact_11         = 1;
bact_12         = 1;
bact_13         = 1;
bact_14         = 1;
bact_15         = 1;
% Hepatic extraction 
hep_extr_pc     = frac_li_pc; 
hep_extr_pu     = frac_li_pu; 
hep_extr_sc     = frac_li_sc; 
hep_extr_su     = frac_li_su;
k_lp_pc         = Q_L * hep_extr_pc; 
k_lp_pu         = Q_L * hep_extr_pu; 
k_lp_sc         = Q_L * hep_extr_sc; 
k_lp_su         = Q_L * hep_extr_su; 
% Postprandial reflex: gallbladder 
curr_GI_reflex_GB = max(reflex(GIr_beta_GB, GIr_delta_GB, t - tau), 1); 
k_xg            = k_xg          * curr_GI_reflex_GB; 
% Postprandial reflex: intestines
curr_GI_reflex_SI = max(reflex(GIr_beta_SI, GIr_delta_SI, t - tau), 1); 
k_si_trans_1_2 = k_si_trans_1_2         * curr_GI_reflex_SI; 
k_si_trans_1_4 = k_si_trans_1_4         * curr_GI_reflex_SI;  
k_si_trans_2_3 = k_si_trans_2_3         * curr_GI_reflex_SI; 
k_si_trans_3_4 = k_si_trans_3_4         * curr_GI_reflex_SI; 
k_si_trans_4_5 = k_si_trans_4_5         * curr_GI_reflex_SI; 
k_si_trans_5_6 = k_si_trans_5_6         * curr_GI_reflex_SI; 
k_si_trans_6_7 = k_si_trans_6_7         * curr_GI_reflex_SI; 
k_si_trans_7_8 = k_si_trans_7_8         * curr_GI_reflex_SI; 
k_si_trans_8_9 = k_si_trans_8_9         * curr_GI_reflex_SI; 
k_si_trans_9_10 = k_si_trans_9_10       * curr_GI_reflex_SI; 
k_si_trans_10_11 = k_si_trans_10_11     * curr_GI_reflex_SI; 
k_co_trans_11_12 = k_co_trans_11_12     * curr_GI_reflex_SI; 
k_co_trans_12_13 = k_co_trans_12_13  	* curr_GI_reflex_SI; 
k_co_trans_13_14 = k_co_trans_13_14     * curr_GI_reflex_SI; 
k_co_trans_14_15 = k_co_trans_14_15     * curr_GI_reflex_SI; 
k_co_trans_15_16 = k_co_trans_15_16     * curr_GI_reflex_SI; 
%
% LIVER (only conjugated)
%   Liver to gallbladder / intestines
x_li_pc         = k_xl * li_pc; 
x_li_sc         = k_xl * li_sc; 
% GALLBLADDER
% 	Gallbladder from liver (only conjugated)
gb_li_pc        = frac_gb * x_li_pc; 
gb_li_sc        = frac_gb * x_li_sc; 
%   Gallbladder to intestines (only conjugated)
x_gb_pc         = k_xg * gb_pc; 
x_gb_sc         = k_xg * gb_sc; 
%
% INTESTINES
%   input from liver, directly
si1_li_pc       =(1.0-frac_gb) * x_li_pc;
si1_li_sc       =(1.0-frac_gb) * x_li_sc;
%   input from gallbladder 
si1_gb_pc       = x_gb_pc; 
si1_gb_sc       = x_gb_sc; 
%   intestinal transit: input of primary, unconjugated bile acids
si_trans_in_pu_2 = si1_pu * k_si_trans_1_2; 
si_trans_in_pu_3 = si2_pu * k_si_trans_2_3; 
si_trans_in_pu_4 = si3_pu * k_si_trans_3_4 + si1_pu * k_si_trans_1_4;
si_trans_in_pu_5 = si4_pu * k_si_trans_4_5;
si_trans_in_pu_6 = si5_pu * k_si_trans_5_6;
si_trans_in_pu_7 = si6_pu * k_si_trans_6_7; 
si_trans_in_pu_8 = si7_pu * k_si_trans_7_8; 
si_trans_in_pu_9 = si8_pu * k_si_trans_8_9;
si_trans_in_pu_10 = si9_pu * k_si_trans_9_10;
co_trans_in_pu_11 = si10_pu * k_si_trans_10_11; 
co_trans_in_pu_12 = co11_pu * k_co_trans_11_12; 
co_trans_in_pu_13 = co12_pu * k_co_trans_12_13; 
co_trans_in_pu_14 = co13_pu * k_co_trans_13_14; 
co_trans_in_pu_15 = co14_pu * k_co_trans_14_15; 
co_trans_in_pu_16 = co15_pu * k_co_trans_15_16; 
%   intestinal transit: input of secondary, unconjugated bile acids
si_trans_in_su_2 = si1_su * k_si_trans_1_2; 
si_trans_in_su_3 = si2_su * k_si_trans_2_3; 
si_trans_in_su_4 = si3_su * k_si_trans_3_4 + si1_su * k_si_trans_1_4;
si_trans_in_su_5 = si4_su * k_si_trans_4_5;
si_trans_in_su_6 = si5_su * k_si_trans_5_6;
si_trans_in_su_7 = si6_su * k_si_trans_6_7; 
si_trans_in_su_8 = si7_su * k_si_trans_7_8; 
si_trans_in_su_9 = si8_su * k_si_trans_8_9;
si_trans_in_su_10 = si9_su * k_si_trans_9_10;
co_trans_in_su_11 = si10_su * k_si_trans_10_11; 
co_trans_in_su_12 = co11_su * k_co_trans_11_12; 
co_trans_in_su_13 = co12_su * k_co_trans_12_13; 
co_trans_in_su_14 = co13_su * k_co_trans_13_14; 
co_trans_in_su_15 = co14_su * k_co_trans_14_15; 
co_trans_in_su_16 = co15_su * k_co_trans_15_16; 
%   intestinal transit: output of primary, unconjugated bile acids
si_trans_out_pu_1 = si1_pu * k_si_trans_1_2 + si1_pu * k_si_trans_1_4;
si_trans_out_pu_2 = si2_pu * k_si_trans_2_3; 
si_trans_out_pu_3 = si3_pu * k_si_trans_3_4;
si_trans_out_pu_4 = si4_pu * k_si_trans_4_5;
si_trans_out_pu_5 = si5_pu * k_si_trans_5_6;
si_trans_out_pu_6 = si6_pu * k_si_trans_6_7; 
si_trans_out_pu_7 = si7_pu * k_si_trans_7_8; 
si_trans_out_pu_8 = si8_pu * k_si_trans_8_9; 
si_trans_out_pu_9 = si9_pu * k_si_trans_9_10;
si_trans_out_pu_10= si10_pu * k_si_trans_10_11; 
co_trans_out_pu_11= co11_pu * k_co_trans_11_12; 
co_trans_out_pu_12= co12_pu * k_co_trans_12_13; 
co_trans_out_pu_13= co13_pu * k_co_trans_13_14; 
co_trans_out_pu_14= co14_pu * k_co_trans_14_15; 
co_trans_out_pu_15= co15_pu * k_co_trans_15_16;
%   intestinal transit: output of secondary, unconjugated bile acids
si_trans_out_su_1 = si1_su * k_si_trans_1_2 + si1_su * k_si_trans_1_4;
si_trans_out_su_2 = si2_su * k_si_trans_2_3; 
si_trans_out_su_3 = si3_su * k_si_trans_3_4;
si_trans_out_su_4 = si4_su * k_si_trans_4_5;
si_trans_out_su_5 = si5_su * k_si_trans_5_6;
si_trans_out_su_6 = si6_su * k_si_trans_6_7; 
si_trans_out_su_7 = si7_su * k_si_trans_7_8; 
si_trans_out_su_8 = si8_su * k_si_trans_8_9; 
si_trans_out_su_9 = si9_su * k_si_trans_9_10;
si_trans_out_su_10= si10_su * k_si_trans_10_11; 
co_trans_out_su_11= co11_su * k_co_trans_11_12; 
co_trans_out_su_12= co12_su * k_co_trans_12_13; 
co_trans_out_su_13= co13_su * k_co_trans_13_14; 
co_trans_out_su_14= co14_su * k_co_trans_14_15; 
co_trans_out_su_15= co15_su * k_co_trans_15_16;
%   intestinal transit: input of primary, conjugated bile acids
si_trans_in_pc_2 = si1_pc * k_si_trans_1_2; 
si_trans_in_pc_3 = si2_pc * k_si_trans_2_3; 
si_trans_in_pc_4 = si3_pc * k_si_trans_3_4 + si1_pc * k_si_trans_1_4; 
si_trans_in_pc_5 = si4_pc * k_si_trans_4_5;
si_trans_in_pc_6 = si5_pc * k_si_trans_5_6; 
si_trans_in_pc_7 = si6_pc * k_si_trans_6_7; 
si_trans_in_pc_8 = si7_pc * k_si_trans_7_8; 
si_trans_in_pc_9 = si8_pc * k_si_trans_8_9; 
si_trans_in_pc_10 = si9_pc * k_si_trans_9_10; 
co_trans_in_pc_11 = si10_pc * k_si_trans_10_11; 
co_trans_in_pc_12 = co11_pc * k_co_trans_11_12; 
co_trans_in_pc_13 = co12_pc * k_co_trans_12_13; 
co_trans_in_pc_14 = co13_pc * k_co_trans_13_14; 
co_trans_in_pc_15 = co14_pc * k_co_trans_14_15; 
co_trans_in_pc_16 = co15_pc * k_co_trans_15_16; 
%   intestinal transit: input of secondary, conjugated bile acids
si_trans_in_sc_2 = si1_sc * k_si_trans_1_2; 
si_trans_in_sc_3 = si2_sc * k_si_trans_2_3; 
si_trans_in_sc_4 = si3_sc * k_si_trans_3_4 + si1_sc * k_si_trans_1_4; 
si_trans_in_sc_5 = si4_sc * k_si_trans_4_5;
si_trans_in_sc_6 = si5_sc * k_si_trans_5_6; 
si_trans_in_sc_7 = si6_sc * k_si_trans_6_7; 
si_trans_in_sc_8 = si7_sc * k_si_trans_7_8; 
si_trans_in_sc_9 = si8_sc * k_si_trans_8_9; 
si_trans_in_sc_10 = si9_sc * k_si_trans_9_10; 
co_trans_in_sc_11 = si10_sc * k_si_trans_10_11; 
co_trans_in_sc_12 = co11_sc * k_co_trans_11_12; 
co_trans_in_sc_13 = co12_sc * k_co_trans_12_13; 
co_trans_in_sc_14 = co13_sc * k_co_trans_13_14; 
co_trans_in_sc_15 = co14_sc * k_co_trans_14_15; 
co_trans_in_sc_16 = co15_sc * k_co_trans_15_16; 
%   intestinal transit: output of primary, conjugated bile acids
si_trans_out_pc_1= si1_pc * k_si_trans_1_2 + si1_pc * k_si_trans_1_4; 
si_trans_out_pc_2= si2_pc * k_si_trans_2_3; 
si_trans_out_pc_3= si3_pc * k_si_trans_3_4; 
si_trans_out_pc_4= si4_pc * k_si_trans_4_5; 
si_trans_out_pc_5= si5_pc * k_si_trans_5_6; 
si_trans_out_pc_6= si6_pc * k_si_trans_6_7; 
si_trans_out_pc_7= si7_pc * k_si_trans_7_8;  
si_trans_out_pc_8= si8_pc * k_si_trans_8_9; 
si_trans_out_pc_9= si9_pc * k_si_trans_9_10;
si_trans_out_pc_10= si10_pc * k_si_trans_10_11;
co_trans_out_pc_11= co11_pc * k_co_trans_11_12; 
co_trans_out_pc_12= co12_pc * k_co_trans_12_13; 
co_trans_out_pc_13= co13_pc * k_co_trans_13_14; 
co_trans_out_pc_14= co14_pc * k_co_trans_14_15; 
co_trans_out_pc_15= co15_pc * k_co_trans_15_16; 
%   intestinal transit: output of secondary, conjugated bile acids
si_trans_out_sc_1= si1_sc * k_si_trans_1_2 + si1_sc * k_si_trans_1_4; 
si_trans_out_sc_2= si2_sc * k_si_trans_2_3; 
si_trans_out_sc_3= si3_sc * k_si_trans_3_4; 
si_trans_out_sc_4= si4_sc * k_si_trans_4_5; 
si_trans_out_sc_5= si5_sc * k_si_trans_5_6; 
si_trans_out_sc_6= si6_sc * k_si_trans_6_7; 
si_trans_out_sc_7= si7_sc * k_si_trans_7_8;  
si_trans_out_sc_8= si8_sc * k_si_trans_8_9; 
si_trans_out_sc_9= si9_sc * k_si_trans_9_10;
si_trans_out_sc_10= si10_sc * k_si_trans_10_11;
co_trans_out_sc_11= co11_sc * k_co_trans_11_12; 
co_trans_out_sc_12= co12_sc * k_co_trans_12_13; 
co_trans_out_sc_13= co13_sc * k_co_trans_13_14; 
co_trans_out_sc_14= co14_sc * k_co_trans_14_15; 
co_trans_out_sc_15= co15_sc * k_co_trans_15_16; 
%   deconjugation
si1_puc          = k_uc* bact_1 * si1_pc; 
si2_puc          = k_uc* bact_2 * si2_pc; 
si3_puc          = k_uc* bact_3 * si3_pc; 
si4_puc          = k_uc* bact_4 * si4_pc; 
si5_puc          = k_uc* bact_5 * si5_pc; 
si6_puc          = k_uc* bact_6 * si6_pc; 
si7_puc          = k_uc* bact_7 * si7_pc; 
si8_puc          = k_uc* bact_8 * si8_pc; 
si9_puc          = k_uc* bact_9 * si9_pc; 
si10_puc         = k_uc* bact_10 * si10_pc; 
co11_puc         = k_uc* bact_11 * co11_pc; 
co12_puc         = k_uc* bact_12 * co12_pc; 
co13_puc         = k_uc* bact_13 * co13_pc; 
co14_puc         = k_uc* bact_14 * co14_pc; 
co15_puc         = k_uc* bact_15 * co15_pc; 
si1_suc          = k_uc* bact_1 * si1_sc; 
si2_suc          = k_uc* bact_2 * si2_sc; 
si3_suc          = k_uc* bact_3 * si3_sc; 
si4_suc          = k_uc* bact_4 * si4_sc; 
si5_suc          = k_uc* bact_5 * si5_sc; 
si6_suc          = k_uc* bact_6 * si6_sc; 
si7_suc          = k_uc* bact_7 * si7_sc; 
si8_suc          = k_uc* bact_8 * si8_sc; 
si9_suc          = k_uc* bact_9 * si9_sc; 
si10_suc         = k_uc* bact_10 * si10_sc; 
co11_suc         = k_uc* bact_11 * co11_sc; 
co12_suc         = k_uc* bact_12 * co12_sc; 
co13_suc         = k_uc* bact_13 * co13_sc; 
co14_suc         = k_uc* bact_14 * co14_sc; 
co15_suc         = k_uc* bact_15 * co15_sc; 
%   dehydroxylation
co11_deh         = k_deh* bact_11 * co11_pu; 
co12_deh         = k_deh* bact_12 * co12_pu; 
co13_deh         = k_deh* bact_13 * co13_pu; 
co14_deh         = k_deh* bact_14 * co14_pu; 
co15_deh         = k_deh* bact_15 * co15_pu; 
%   passive uptake 
si1_pu_pu        = k_xi_up_si * si1_pu; 
si2_pu_pu        = k_xi_up_si * si2_pu; 
si3_pu_pu        = k_xi_up_si * si3_pu; 
si4_pu_pu        = k_xi_up_si * si4_pu; 
si5_pu_pu        = k_xi_up_si * si5_pu; 
si6_pu_pu        = k_xi_up_si * si6_pu; 
si7_pu_pu        = k_xi_up_si * si7_pu; 
si8_pu_pu        = k_xi_up_si * si8_pu; 
si9_pu_pu        = k_xi_up_si * si9_pu; 
si10_pu_pu       = k_xi_up_si * si10_pu; 
co11_pu_pu       = k_xi_up_co * co11_pu; 
co12_pu_pu       = k_xi_up_co * co12_pu; 
co13_pu_pu       = k_xi_up_co * co13_pu; 
co14_pu_pu       = k_xi_up_co * co14_pu; 
co15_pu_pu       = k_xi_up_co * co15_pu; 
si1_pu_su        = k_xi_up_si * si1_su; 
si2_pu_su        = k_xi_up_si * si2_su; 
si3_pu_su        = k_xi_up_si * si3_su; 
si4_pu_su        = k_xi_up_si * si4_su; 
si5_pu_su        = k_xi_up_si * si5_su; 
si6_pu_su        = k_xi_up_si * si6_su; 
si7_pu_su        = k_xi_up_si * si7_su; 
si8_pu_su        = k_xi_up_si * si8_su; 
si9_pu_su        = k_xi_up_si * si9_su; 
si10_pu_su       = k_xi_up_si * si10_su; 
co11_pu_su       = k_xi_up_co * co11_su; 
co12_pu_su       = k_xi_up_co * co12_su; 
co13_pu_su       = k_xi_up_co * co13_su; 
co14_pu_su       = k_xi_up_co * co14_su; 
co15_pu_su       = k_xi_up_co * co15_su; 
%   active uptake
total_si9        = si9_pu + si9_pc + si9_su + si9_sc; 
total_si10       = si10_pu + si10_pc + si10_su + si10_sc; 
si9_au_pu        = vmax_asbt*max((1-k_ASBT*D3),0) * si9_pu  / (total_si9 + km_asbt); 
si10_au_pu       = vmax_asbt*max((1-k_ASBT*D3),0) * si10_pu / (total_si10 + km_asbt); 
si9_au_pc        = vmax_asbt*max((1-k_ASBT*D3),0) * si9_pc  / (total_si9 + km_asbt); 
si10_au_pc       = vmax_asbt*max((1-k_ASBT*D3),0) * si10_pc / (total_si10 + km_asbt); 
si9_au_su        = vmax_asbt*max((1-k_ASBT*D3),0) * si9_su  / (total_si9 + km_asbt); 
si10_au_su       = vmax_asbt*max((1-k_ASBT*D3),0) * si10_su / (total_si10 + km_asbt); 
si9_au_sc        = vmax_asbt*max((1-k_ASBT*D3),0) * si9_sc  / (total_si9 + km_asbt); 
si10_au_sc       = vmax_asbt*max((1-k_ASBT*D3),0) * si10_sc / (total_si10 + km_asbt); 
%
% PLASMA 
% 	input from the intestines
x_si_pu          = si9_au_pu + si10_au_pu + si1_pu_pu + si2_pu_pu + si3_pu_pu + si4_pu_pu + si5_pu_pu + si6_pu_pu + si7_pu_pu + si8_pu_pu + si9_pu_pu + si10_pu_pu;
x_si_pc          = si9_au_pc + si10_au_pc;
x_co_pu          = co11_pu_pu + co12_pu_pu + co13_pu_pu + co14_pu_pu + co15_pu_pu;
x_si_su          = si9_au_su + si10_au_su + si1_pu_su + si2_pu_su + si3_pu_su + si4_pu_su + si5_pu_su + si6_pu_su + si7_pu_su + si8_pu_su + si9_pu_su + si10_pu_su;
x_si_sc          = si9_au_sc + si10_au_sc;
x_co_su          = co11_pu_su + co12_pu_su + co13_pu_su + co14_pu_su + co15_pu_su;
pl_si_pu         = (1.0-hep_extr_pu) * x_si_pu/ V_P;
pl_si_pc         = (1.0-hep_extr_pc) * x_si_pc/ V_P;
pl_co_pu         = (1.0-hep_extr_pu) * x_co_pu/ V_P;
pl_si_su         = (1.0-hep_extr_su) * x_si_su/ V_P;
pl_si_sc         = (1.0-hep_extr_sc) * x_si_sc/ V_P;
pl_co_su         = (1.0-hep_extr_su) * x_co_su/ V_P;
%   hepatic clearance 
x_pl_pu          = k_lp_pu * (pl_pu)/ V_P;
x_pl_pc          = k_lp_pc * (pl_pc)/ V_P;
x_pl_su          = k_lp_su * (pl_su)/ V_P;
x_pl_sc          = k_lp_sc * (pl_sc)/ V_P;
%
% LIVER
%   hepatic FXR
d1_in            = k_d1 * ((li_pc*k_sp   + li_sc) - L0);
d1_out           = k_d1 * D1;
%   intestinal FXR
d2_in            = k_d2 * ((x_si_pc*k_sp + x_si_sc) - ASBT0);
d2_out           = k_d2 * D2;
%   intestinal FXR
d3_in            = k_d3 * ((x_si_pc*k_sp + x_si_sc) - ASBT0);
d3_out           = k_d3 * D3;
%   synthesis
li_x_pc          = max(k_u - k_FXR1 * D1 - k_FXR2 * D2, 0);
%   hepatic extraction of bile acids in the plasma compartment
li_pl_pc         = k_lp_pc * pl_pc + k_lp_pu * pl_pu;
li_pl_sc         = k_lp_sc * pl_sc + k_lp_su * pl_su;
%   first pass extraction of intestinal uptake ("from portal blood")
li_si_pc         =  x_si_pc * hep_extr_pc + x_si_pu * hep_extr_pu;
li_co_pc         =  x_co_pu * hep_extr_pu;
li_si_sc         =  x_si_sc * hep_extr_sc + x_si_su * hep_extr_su;
li_co_sc         =  x_co_su * hep_extr_su;

%% MODEL2: Fluxes
%
% STOMACH 
% Input
st1_vol_input    = VOL * (SLOW / (QUICK+SLOW)) / meal_time * ((t-tau) <= meal_time);
st3_vol_input    = VOL * (QUICK / (QUICK+SLOW)) / meal_time * ((t-tau) <= meal_time);
st3_quick_input  = QUICK / meal_time * ((t-tau) <= meal_time);
st1_slow_input   = SLOW / meal_time * ((t-tau) <= meal_time);
st3_su_input     = SU / meal_time * ((t-tau) <= meal_time);
st3_sc_input     = SC / meal_time * ((t-tau) <= meal_time);
% Empyting rate
GLP1_b           = GLP1_basal / k_dpp4;
effect_GLP1_ST   = glp1_st./(((1-EXEN)*(GLP1_act-GLP1_b)) + glp1_st); 
empt_rate_1      = (k_st_1 + k_st_2 .* st1_vol/STOM_VOLUME)  .* effect_GLP1_ST; 
empt_rate_2      = (k_st_1 + k_st_2 .* st2_vol/STOM_VOLUME)  .* effect_GLP1_ST; 
empt_rate_3      = (k_st_1 + k_st_2 .* st3_vol/STOM_VOLUME)  .* effect_GLP1_ST; 
% Stomach transit
st_trans_1_vol   = empt_rate_1 .* st1_vol;
st_trans_2_vol   = empt_rate_2 .* st2_vol;
st_trans_3_vol   = empt_rate_3 .* st3_vol;
st_trans_1_quick = empt_rate_1 .* st1_quick;
st_trans_2_quick = empt_rate_2 .* st2_quick;
st_trans_3_quick = empt_rate_3 .* st3_quick;
st_trans_1_slow  = empt_rate_1 .* st1_slow;
st_trans_2_slow  = empt_rate_2 .* st2_slow;
st_trans_3_slow  = empt_rate_3 .* st3_slow;
% Intestinal transit - out (do not model for volume, only for "quick" and "slow")
si_trans_out_quick_1= si1_quick * k_si_trans_1_2 + si1_quick * k_si_trans_1_4; 
si_trans_out_quick_2= si2_quick * k_si_trans_2_3; 
si_trans_out_quick_3= si3_quick * k_si_trans_3_4; 
si_trans_out_quick_4= si4_quick * k_si_trans_4_5; 
si_trans_out_quick_5= si5_quick * k_si_trans_5_6; 
si_trans_out_quick_6= si6_quick * k_si_trans_6_7; 
si_trans_out_quick_7= si7_quick * k_si_trans_7_8;  
si_trans_out_quick_8= si8_quick * k_si_trans_8_9; 
si_trans_out_quick_9= si9_quick * k_si_trans_9_10;
si_trans_out_quick_10= si10_quick * k_si_trans_10_11;
si_trans_out_slow_1= si1_slow * k_si_trans_1_2 + si1_slow * k_si_trans_1_4; 
si_trans_out_slow_2= si2_slow * k_si_trans_2_3; 
si_trans_out_slow_3= si3_slow * k_si_trans_3_4; 
si_trans_out_slow_4= si4_slow * k_si_trans_4_5; 
si_trans_out_slow_5= si5_slow * k_si_trans_5_6; 
si_trans_out_slow_6= si6_slow * k_si_trans_6_7; 
si_trans_out_slow_7= si7_slow * k_si_trans_7_8;  
si_trans_out_slow_8= si8_slow * k_si_trans_8_9; 
si_trans_out_slow_9= si9_slow * k_si_trans_9_10;
si_trans_out_slow_10= si10_slow * k_si_trans_10_11;
% Intestinal transit - in (for "quick" and "slow")
si_trans_in_quick_1= st_trans_3_quick * (1-RYGB) + st_trans_1_quick * RYGB;
si_trans_in_quick_2= si1_quick * k_si_trans_1_2;
si_trans_in_quick_3= si2_quick * k_si_trans_2_3; 
si_trans_in_quick_4= si3_quick * k_si_trans_3_4 + si1_quick * k_si_trans_1_4; 
si_trans_in_quick_5= si4_quick * k_si_trans_4_5; 
si_trans_in_quick_6= si5_quick * k_si_trans_5_6; 
si_trans_in_quick_7= si6_quick * k_si_trans_6_7; 
si_trans_in_quick_8= si7_quick * k_si_trans_7_8;  
si_trans_in_quick_9= si8_quick * k_si_trans_8_9; 
si_trans_in_quick_10= si9_quick * k_si_trans_9_10;
si_trans_in_slow_1= st_trans_3_slow * (1-RYGB) + st_trans_1_slow * RYGB;
si_trans_in_slow_2= si1_slow * k_si_trans_1_2;
si_trans_in_slow_3= si2_slow * k_si_trans_2_3; 
si_trans_in_slow_4= si3_slow * k_si_trans_3_4 + si1_slow * k_si_trans_1_4; 
si_trans_in_slow_5= si4_slow * k_si_trans_4_5; 
si_trans_in_slow_6= si5_slow * k_si_trans_5_6; 
si_trans_in_slow_7= si6_slow * k_si_trans_6_7; 
si_trans_in_slow_8= si7_slow * k_si_trans_7_8;  
si_trans_in_slow_9= si8_slow * k_si_trans_8_9; 
si_trans_in_slow_10= si9_slow * k_si_trans_9_10;
% Intestinal uptake(do not model for volume, only for "quick" and "slow")
si_upt_quick_1= si1_quick * vmax_quick / (si1_quick + km_quick); 
si_upt_quick_2= si2_quick * vmax_quick / (si2_quick + km_quick); 
si_upt_quick_3= si3_quick * vmax_quick / (si3_quick + km_quick); 
si_upt_quick_4= si4_quick * vmax_quick / (si4_quick + km_quick); 
si_upt_quick_5= si5_quick * vmax_quick / (si5_quick + km_quick); 
si_upt_quick_6= si6_quick * vmax_quick / (si6_quick + km_quick); 
si_upt_quick_7= si7_quick * vmax_quick / (si7_quick + km_quick);   
si_upt_quick_8= si8_quick * vmax_quick / (si8_quick + km_quick); 
si_upt_quick_9= si9_quick * vmax_quick / (si9_quick + km_quick); 
si_upt_quick_10= si10_quick * vmax_quick / (si10_quick + km_quick); 
si_upt_slow_1= si1_slow * vmax_slow / (si1_slow + km_slow); 
si_upt_slow_2= si2_slow * vmax_slow / (si2_slow + km_slow); 
si_upt_slow_3= si3_slow * vmax_slow / (si3_slow + km_slow); 
si_upt_slow_4= si4_slow * vmax_slow / (si4_slow + km_slow); 
si_upt_slow_5= si5_slow * vmax_slow / (si5_slow + km_slow); 
si_upt_slow_6= si6_slow * vmax_slow / (si6_slow + km_slow); 
si_upt_slow_7= si7_slow * vmax_slow / (si7_slow + km_slow);   
si_upt_slow_8= si8_slow * vmax_slow / (si8_slow + km_slow); 
si_upt_slow_9= si9_slow * vmax_slow / (si9_slow + km_slow); 
si_upt_slow_10= si10_slow * vmax_slow / (si10_slow + km_slow); 
% Bile acid stomach 
st_trans_1_su = empt_rate_1 .* st1_su;
st_trans_2_su = empt_rate_2 .* st2_su;
st_trans_3_su = empt_rate_3 .* st3_su;
st_trans_1_sc = empt_rate_1 .* st1_sc;
st_trans_2_sc = empt_rate_2 .* st2_sc;
st_trans_3_sc = empt_rate_3 .* st3_sc;
% GLP1 degradation
GLP1_DPP4    = GLP1_act  * k_dpp4 * DPP4;
GLP1_denat   = GLP1_ina  * k_denat;
% GLP1 secretion
GLP1_q1              = si_upt_quick_1 .* GLP1_c1*(GLP1_xa+GLP1_xb* 1 *int_dist ).^2 / V_GLP1;
GLP1_q2              = si_upt_quick_2 .* GLP1_c1*(GLP1_xa+GLP1_xb* 2 *int_dist ).^2 / V_GLP1;
GLP1_q3              = si_upt_quick_3 .* GLP1_c1*(GLP1_xa+GLP1_xb* 3 *int_dist ).^2 / V_GLP1;
GLP1_q4              = si_upt_quick_4 .* GLP1_c1*(GLP1_xa+GLP1_xb* 4 *int_dist ).^2 / V_GLP1;
GLP1_q5              = si_upt_quick_5 .* GLP1_c1*(GLP1_xa+GLP1_xb* 5 *int_dist ).^2 / V_GLP1;
GLP1_q6              = si_upt_quick_6 .* GLP1_c1*(GLP1_xa+GLP1_xb* 6 *int_dist ).^2 / V_GLP1;
GLP1_q7              = si_upt_quick_7 .* GLP1_c1*(GLP1_xa+GLP1_xb* 7 *int_dist ).^2 / V_GLP1;
GLP1_q8              = si_upt_quick_8 .* GLP1_c1*(GLP1_xa+GLP1_xb* 8 *int_dist ).^2 / V_GLP1;
GLP1_q9              = si_upt_quick_9 .* GLP1_c1*(GLP1_xa+GLP1_xb* 9 *int_dist ).^2 / V_GLP1;
GLP1_q10             = si_upt_quick_10.* GLP1_c1*(GLP1_xa+GLP1_xb* 10 *int_dist).^2 / V_GLP1;
GLP1_quick             = GLP1_q1 + GLP1_q2 + GLP1_q3 + GLP1_q4 + GLP1_q5 ...
    + GLP1_q6 + GLP1_q7 + GLP1_q8 + GLP1_q9 + GLP1_q10;
GLP1_s1              = si_upt_slow_1 .* GLP1_c2*(GLP1_xa+GLP1_xb*1*int_dist).^2 / V_GLP1;
GLP1_s2              = si_upt_slow_2 .* GLP1_c2*(GLP1_xa+GLP1_xb*2*int_dist).^2 / V_GLP1;
GLP1_s3              = si_upt_slow_3 .* GLP1_c2*(GLP1_xa+GLP1_xb*3*int_dist).^2 / V_GLP1;
GLP1_s4              = si_upt_slow_4 .* GLP1_c2*(GLP1_xa+GLP1_xb*4*int_dist).^2 / V_GLP1;
GLP1_s5              = si_upt_slow_5 .* GLP1_c2*(GLP1_xa+GLP1_xb*5*int_dist).^2 / V_GLP1;
GLP1_s6              = si_upt_slow_6 .* GLP1_c2*(GLP1_xa+GLP1_xb*6*int_dist).^2 / V_GLP1;
GLP1_s7              = si_upt_slow_7 .* GLP1_c2*(GLP1_xa+GLP1_xb*7*int_dist).^2 / V_GLP1;
GLP1_s8              = si_upt_slow_8 .* GLP1_c2*(GLP1_xa+GLP1_xb*8*int_dist).^2 / V_GLP1;
GLP1_s9              = si_upt_slow_9 .* GLP1_c2*(GLP1_xa+GLP1_xb*9*int_dist).^2 / V_GLP1;
GLP1_s10             = si_upt_slow_10.* GLP1_c2*(GLP1_xa+GLP1_xb*10*int_dist).^2 / V_GLP1;
GLP1_slow            = GLP1_s1 + GLP1_s2 + GLP1_s3 + GLP1_s4 + GLP1_s5 ...
    + GLP1_s6 + GLP1_s7 + GLP1_s8 + GLP1_s9 + GLP1_s10;
GLP1_b1              = si1_sc .* k_BAGLP1*(GLP1_xa+GLP1_xb* 1 *int_dist).^2 / V_GLP1;
GLP1_b2              = si2_sc .* k_BAGLP1*(GLP1_xa+GLP1_xb* 2 *int_dist).^2 / V_GLP1;
GLP1_b3              = si3_sc .* k_BAGLP1*(GLP1_xa+GLP1_xb* 3 *int_dist).^2 / V_GLP1;
GLP1_b4              = si4_sc .* k_BAGLP1*(GLP1_xa+GLP1_xb* 4 *int_dist).^2 / V_GLP1;
GLP1_b5              = si5_sc .* k_BAGLP1*(GLP1_xa+GLP1_xb* 5 *int_dist).^2 / V_GLP1;
GLP1_b6              = si6_sc .* k_BAGLP1*(GLP1_xa+GLP1_xb* 6 *int_dist).^2 / V_GLP1;
GLP1_b7              = si7_sc .* k_BAGLP1*(GLP1_xa+GLP1_xb* 7 *int_dist).^2 / V_GLP1;
GLP1_b8              = si8_sc .* k_BAGLP1*(GLP1_xa+GLP1_xb* 8 *int_dist).^2 / V_GLP1;
GLP1_b9              = si9_sc .* k_BAGLP1*(GLP1_xa+GLP1_xb* 9 *int_dist).^2 / V_GLP1;
GLP1_b10             = si10_sc .* k_BAGLP1*(GLP1_xa+GLP1_xb* 10 *int_dist).^2 / V_GLP1;
GLP1_ba              = GLP1_b9 + GLP1_b10;
%GLP1_b1 + GLP1_b2 + GLP1_b3 + GLP1_b4 + GLP1_b5 ...
%    + GLP1_b6 + GLP1_b7 + GLP1_b8 + GLP1_b9 + GLP1_b10;

%% MODEL1: ODEs

% Liver : (synthesis)  (first pass (si))  (first pass (co)) (hepatic extraction)
dx_li_pc = + li_x_pc     + li_si_pc +           + li_co_pc         + li_pl_pc   ...
...   % (liver to gb/in)         
        - x_li_pc      ;
    
% Liver : (synthesis)  (first pass (si))  (first pass (co)) (hepatic extraction)
dx_li_sc =               + li_si_sc          + li_co_sc         + li_pl_sc   ...
...   % (liver to gb/in)           
        - x_li_sc      ;

% Gallbladder : input           output
dx_gb_pc =       + gb_li_pc       - x_gb_pc;
dx_gb_sc =       + gb_li_sc       - x_gb_sc;
 
% Small intestines / colon : unconjugated
%             (input gb)       (input gb)       (transit in)    (deconjugation in)     (transit out)       (active out)       (passive out)           
dx_si1_pu   =                                                          +si1_puc       - si_trans_out_pu_1                         - si1_pu_pu;
dx_si2_pu   =                                + si_trans_in_pu_2         +si2_puc       - si_trans_out_pu_2                         - si2_pu_pu;
dx_si3_pu   =                                + si_trans_in_pu_3         +si3_puc       - si_trans_out_pu_3                         - si3_pu_pu;
dx_si4_pu   =                                + si_trans_in_pu_4         +si4_puc       - si_trans_out_pu_4                         - si4_pu_pu;
dx_si5_pu   =                                + si_trans_in_pu_5         +si5_puc       - si_trans_out_pu_5                         - si5_pu_pu;
dx_si6_pu   =                                + si_trans_in_pu_6         +si6_puc       - si_trans_out_pu_6                         - si6_pu_pu;
dx_si7_pu   =                                + si_trans_in_pu_7         +si7_puc       - si_trans_out_pu_7                         - si7_pu_pu;
dx_si8_pu   =                                + si_trans_in_pu_8         +si8_puc       - si_trans_out_pu_8                         - si8_pu_pu;
dx_si9_pu   =                                + si_trans_in_pu_9         +si9_puc       - si_trans_out_pu_9      - si9_au_pu         - si9_pu_pu;
dx_si10_pu  =                                + si_trans_in_pu_10        +si10_puc      - si_trans_out_pu_10     - si10_au_pu        - si10_pu_pu;

dx_co11_pu  =                                + co_trans_in_pu_11        +co11_puc      - co_trans_out_pu_11                        - co11_pu_pu - co11_deh;
dx_co12_pu  =                                + co_trans_in_pu_12        +co12_puc      - co_trans_out_pu_12                        - co12_pu_pu - co12_deh;
dx_co13_pu  =                                + co_trans_in_pu_13        +co13_puc      - co_trans_out_pu_13                        - co13_pu_pu - co13_deh;
dx_co14_pu  =                                + co_trans_in_pu_14        +co14_puc      - co_trans_out_pu_14                        - co14_pu_pu - co14_deh;
dx_co15_pu  =                                + co_trans_in_pu_15        +co15_puc      - co_trans_out_pu_15                        - co15_pu_pu - co15_deh;

dx_si1_su   =                                                          +si1_suc       - si_trans_out_su_1                          - si1_pu_su + (RYGB) * st_trans_1_su + (1-RYGB) * st_trans_3_su;
dx_si2_su   =                                + si_trans_in_su_2         +si2_suc       - si_trans_out_su_2                         - si2_pu_su;
dx_si3_su   =                                + si_trans_in_su_3         +si3_suc       - si_trans_out_su_3                         - si3_pu_su;
dx_si4_su   =                                + si_trans_in_su_4         +si4_suc       - si_trans_out_su_4                         - si4_pu_su;
dx_si5_su   =                                + si_trans_in_su_5         +si5_suc       - si_trans_out_su_5                         - si5_pu_su;
dx_si6_su   =                                + si_trans_in_su_6         +si6_suc       - si_trans_out_su_6                         - si6_pu_su;
dx_si7_su   =                                + si_trans_in_su_7         +si7_suc       - si_trans_out_su_7                         - si7_pu_su;
dx_si8_su   =                                + si_trans_in_su_8         +si8_suc       - si_trans_out_su_8                         - si8_pu_su;
dx_si9_su   =                                + si_trans_in_su_9         +si9_suc       - si_trans_out_su_9      - si9_au_su         - si9_pu_su;
dx_si10_su  =                                + si_trans_in_su_10        +si10_suc      - si_trans_out_su_10     - si10_au_su        - si10_pu_su;

dx_co11_su  =                                + co_trans_in_su_11        +co11_suc      - co_trans_out_su_11                        - co11_pu_su + co11_deh;
dx_co12_su  =                                + co_trans_in_su_12        +co12_suc      - co_trans_out_su_12                        - co12_pu_su + co12_deh;
dx_co13_su  =                                + co_trans_in_su_13        +co13_suc      - co_trans_out_su_13                        - co13_pu_su + co13_deh;
dx_co14_su  =                                + co_trans_in_su_14        +co14_suc      - co_trans_out_su_14                        - co14_pu_su + co14_deh;
dx_co15_su  =                                + co_trans_in_su_15        +co15_suc      - co_trans_out_su_15                        - co15_pu_su + co15_deh;

% Small intestines / colon : conjugated
%             (input gb)       (input gb)       (transit in)    (deconjugation out)    (transit out)       (active out)
dx_si1_pc   =  + si1_li_pc       + si1_gb_pc                             -si1_puc       - si_trans_out_pc_1;
dx_si2_pc   =                                + si_trans_in_pc_2         -si2_puc       - si_trans_out_pc_2;
dx_si3_pc   =                                + si_trans_in_pc_3         -si3_puc       - si_trans_out_pc_3;
dx_si4_pc   =                                + si_trans_in_pc_4         -si4_puc       - si_trans_out_pc_4     - k_dis*si4_pc      + k_app ;
dx_si5_pc   =                                + si_trans_in_pc_5         -si5_puc       - si_trans_out_pc_5;
dx_si6_pc   =                                + si_trans_in_pc_6         -si6_puc       - si_trans_out_pc_6;
dx_si7_pc   =                                + si_trans_in_pc_7         -si7_puc       - si_trans_out_pc_7;
dx_si8_pc   =                                + si_trans_in_pc_8         -si8_puc       - si_trans_out_pc_8;
dx_si9_pc   =                                + si_trans_in_pc_9         -si9_puc       - si_trans_out_pc_9     - si9_au_pc;
dx_si10_pc  =                                + si_trans_in_pc_10        -si10_puc      - si_trans_out_pc_10    - si10_au_pc;

dx_co11_pc  =                                + co_trans_in_pc_11        -co11_puc      - co_trans_out_pc_11;
dx_co12_pc  =                                + co_trans_in_pc_12        -co12_puc      - co_trans_out_pc_12;
dx_co13_pc  =                                + co_trans_in_pc_13        -co13_puc      - co_trans_out_pc_13;
dx_co14_pc  =                                + co_trans_in_pc_14        -co14_puc      - co_trans_out_pc_14;
dx_co15_pc  =                                + co_trans_in_pc_15        -co15_puc      - co_trans_out_pc_15;

dx_si1_sc   =  + si1_li_sc       + si1_gb_sc                            -si1_suc       - si_trans_out_sc_1  + (RYGB) * st_trans_1_sc + (1-RYGB) * st_trans_3_sc;
dx_si2_sc   =                                + si_trans_in_sc_2         -si2_suc       - si_trans_out_sc_2;
dx_si3_sc   =                                + si_trans_in_sc_3         -si3_suc       - si_trans_out_sc_3;
dx_si4_sc   =                                + si_trans_in_sc_4         -si4_suc       - si_trans_out_sc_4     - k_dis*si4_sc; 
dx_si5_sc   =                                + si_trans_in_sc_5         -si5_suc       - si_trans_out_sc_5;
dx_si6_sc   =                                + si_trans_in_sc_6         -si6_suc       - si_trans_out_sc_6;
dx_si7_sc   =                                + si_trans_in_sc_7         -si7_suc       - si_trans_out_sc_7;
dx_si8_sc   =                                + si_trans_in_sc_8         -si8_suc       - si_trans_out_sc_8;
dx_si9_sc   =                                + si_trans_in_sc_9         -si9_suc       - si_trans_out_sc_9     - si9_au_sc;
dx_si10_sc  =                                + si_trans_in_sc_10        -si10_suc      - si_trans_out_sc_10    - si10_au_sc;

dx_co11_sc  =                                + co_trans_in_sc_11        -co11_suc      - co_trans_out_sc_11;
dx_co12_sc  =                                + co_trans_in_sc_12        -co12_suc      - co_trans_out_sc_12;
dx_co13_sc  =                                + co_trans_in_sc_13        -co13_suc      - co_trans_out_sc_13;
dx_co14_sc  =                                + co_trans_in_sc_14        -co14_suc      - co_trans_out_sc_14;
dx_co15_sc  =                                + co_trans_in_sc_15        -co15_suc      - co_trans_out_sc_15;


% Feces 
dx_fa_pu    = + co_trans_in_pu_16;
dx_fa_pc    = + co_trans_in_pc_16;

dx_fa_su    = + co_trans_in_su_16;
dx_fa_sc    = + co_trans_in_sc_16;

% Plasma
%           (spillover, SI components)  (spillover, colon components)   (hepatic clearance)
%           
dx_pl_pu    = + pl_si_pu                  + pl_co_pu                      - x_pl_pu;
dx_pl_pc    = + pl_si_pc                                                  - x_pl_pc;
dx_pl_su    = + pl_si_su                  + pl_co_su                      - x_pl_su;
dx_pl_sc    = + pl_si_sc                                                  - x_pl_sc;
 
% Regulation
dx_D1        = d1_in - d1_out;
dx_D2        = d2_in - d2_out;
dx_D3        = d3_in - d3_out;

% Disappearance
dx_DIS       = k_dis*si4_pc + - k_dis*si4_sc;

%% MODEL 2: ODEs

dx_st1_vol         = st1_vol_input + (RYGB) * st3_vol_input  - st_trans_1_vol;
dx_st2_vol         = st_trans_1_vol * (1-RYGB)    - st_trans_2_vol;
dx_st3_vol         = (1-RYGB) * st3_vol_input + st_trans_2_vol - st_trans_3_vol;

dx_st1_quick       = (RYGB) * st3_quick_input     - st_trans_1_quick;
dx_st2_quick       = st_trans_1_quick * (1-RYGB)  - st_trans_2_quick;
dx_st3_quick       = (1- RYGB) * st3_quick_input  + st_trans_2_quick  - st_trans_3_quick;

dx_st1_slow        = st1_slow_input                  - st_trans_1_slow;
dx_st2_slow        = st_trans_1_slow * (1-RYGB)   - st_trans_2_slow;
dx_st3_slow        = st_trans_2_slow                 - st_trans_3_slow;

dx_st1_su          = 0;
dx_st2_su          = 0;
dx_st3_su          = st3_su_input           - st_trans_3_su;

dx_st1_sc          = 0;
dx_st2_sc          = 0;
dx_st3_sc          = st3_sc_input           - st_trans_3_sc;

dx_si1_quick      = si_trans_in_quick_1       - si_trans_out_quick_1  - si_upt_quick_1;
dx_si2_quick      = si_trans_in_quick_2       - si_trans_out_quick_2  - si_upt_quick_2;
dx_si3_quick      = si_trans_in_quick_3       - si_trans_out_quick_3  - si_upt_quick_3;
dx_si4_quick      = si_trans_in_quick_4       - si_trans_out_quick_4  - si_upt_quick_4;
dx_si5_quick      = si_trans_in_quick_5       - si_trans_out_quick_5  - si_upt_quick_5;
dx_si6_quick      = si_trans_in_quick_6       - si_trans_out_quick_6  - si_upt_quick_6;
dx_si7_quick      = si_trans_in_quick_7       - si_trans_out_quick_7  - si_upt_quick_7;
dx_si8_quick      = si_trans_in_quick_8       - si_trans_out_quick_8  - si_upt_quick_8;
dx_si9_quick      = si_trans_in_quick_9       - si_trans_out_quick_9  - si_upt_quick_9;
dx_si10_quick     = si_trans_in_quick_10      - si_trans_out_quick_10 - si_upt_quick_10;
dx_out_quick      = si_trans_out_quick_10;

dx_si1_slow       = si_trans_in_slow_1        - si_trans_out_slow_1  - si_upt_slow_1;
dx_si2_slow       = si_trans_in_slow_2        - si_trans_out_slow_2  - si_upt_slow_2;
dx_si3_slow       = si_trans_in_slow_3        - si_trans_out_slow_3  - si_upt_slow_3;
dx_si4_slow       = si_trans_in_slow_4        - si_trans_out_slow_4  - si_upt_slow_4;
dx_si5_slow       = si_trans_in_slow_5        - si_trans_out_slow_5  - si_upt_slow_5;
dx_si6_slow       = si_trans_in_slow_6        - si_trans_out_slow_6  - si_upt_slow_6;
dx_si7_slow       = si_trans_in_slow_7        - si_trans_out_slow_7  - si_upt_slow_7;
dx_si8_slow       = si_trans_in_slow_8        - si_trans_out_slow_8  - si_upt_slow_8;
dx_si9_slow       = si_trans_in_slow_9        - si_trans_out_slow_9  - si_upt_slow_9;
dx_si10_slow      = si_trans_in_slow_10       - si_trans_out_slow_10 - si_upt_slow_10;
dx_out_slow       = si_trans_out_slow_10;

% GLP-1
dx_GLP1_act       = GLP1_basal  + GLP1_quick  + GLP1_slow + GLP1_ba - GLP1_DPP4;
dx_GLP1_ina       = GLP1_DPP4   - GLP1_denat;


%% MODEL1: ODE vector 
dx(1) = dx_li_pc;
dx(2) = dx_li_sc;
dx(3) = dx_gb_pc;
dx(4) = dx_gb_sc;
dx(5) = dx_si1_pu;
dx(6) = dx_si1_pc;
dx(7) = dx_si2_pu;
dx(8) = dx_si2_pc;
dx(9) = dx_si3_pu;
dx(10) = dx_si3_pc;
dx(11) = dx_si4_pu;
dx(12) = dx_si4_pc;
dx(13) = dx_si5_pu;
dx(14) = dx_si5_pc;
dx(15) = dx_si6_pu;
dx(16) = dx_si6_pc;
dx(17) = dx_si7_pu;
dx(18) = dx_si7_pc;
dx(19) = dx_si8_pu;
dx(20) = dx_si8_pc;
dx(21) = dx_si9_pu;
dx(22) = dx_si9_pc;
dx(23) = dx_si10_pu;
dx(24) = dx_si10_pc;
dx(25) = dx_co11_pu;
dx(26) = dx_co11_pc;
dx(27) = dx_co12_pu;
dx(28) = dx_co12_pc;
dx(29) = dx_co13_pu;
dx(30) = dx_co13_pc;
dx(31) = dx_co14_pu;
dx(32) = dx_co14_pc;
dx(33) = dx_co15_pu;
dx(34) = dx_co15_pc;
dx(35) = dx_si1_su;
dx(36) = dx_si1_sc;
dx(37) = dx_si2_su;
dx(38) = dx_si2_sc;
dx(39) = dx_si3_su;
dx(40) = dx_si3_sc;
dx(41) = dx_si4_su;
dx(42) = dx_si4_sc;
dx(43) = dx_si5_su;
dx(44) = dx_si5_sc;
dx(45) = dx_si6_su;
dx(46) = dx_si6_sc;
dx(47) = dx_si7_su;
dx(48) = dx_si7_sc;
dx(49) = dx_si8_su;
dx(50) = dx_si8_sc;
dx(51) = dx_si9_su;
dx(52) = dx_si9_sc;
dx(53) = dx_si10_su;
dx(54) = dx_si10_sc;
dx(55) = dx_co11_su;
dx(56) = dx_co11_sc;
dx(57) = dx_co12_su;
dx(58) = dx_co12_sc;
dx(59) = dx_co13_su;
dx(60) = dx_co13_sc;
dx(61) = dx_co14_su;
dx(62) = dx_co14_sc;
dx(63) = dx_co15_su;
dx(64) = dx_co15_sc;
dx(65) = dx_fa_pu;
dx(66) = dx_fa_pc;
dx(67) = dx_fa_su;
dx(68) = dx_fa_sc;
dx(69) = dx_pl_pu;
dx(70) = dx_pl_pc;
dx(71) = dx_pl_su;
dx(72) = dx_pl_sc;
dx(73) = dx_D1;
dx(74) = dx_D2;
dx(75) = dx_D3;
dx(76) = dx_DIS;

%% MODEL2: ODE vector 
dx(77) = dx_st1_vol;
dx(78) = dx_st2_vol;
dx(79) = dx_st3_vol;
dx(80) = dx_st1_quick;
dx(81) = dx_st2_quick;
dx(82) = dx_st3_quick;
dx(83) = dx_st1_slow;
dx(84) = dx_st2_slow;
dx(85) = dx_st3_slow;
dx(86) = dx_st1_su;
dx(87) = dx_st2_su;
dx(88) = dx_st3_su;
dx(89) = dx_st1_sc;
dx(90) = dx_st2_sc;
dx(91) = dx_st3_sc;

dx(92) = dx_si1_quick;
dx(93) = dx_si2_quick;
dx(94) = dx_si3_quick;
dx(95) = dx_si4_quick;
dx(96) = dx_si5_quick;
dx(97) = dx_si6_quick;
dx(98) = dx_si7_quick;
dx(99) = dx_si8_quick;
dx(100) = dx_si9_quick;
dx(101) = dx_si10_quick;
dx(102) = dx_out_quick;

dx(103) = dx_si1_slow;
dx(104) = dx_si2_slow;
dx(105) = dx_si3_slow;
dx(106) = dx_si4_slow;
dx(107) = dx_si5_slow;
dx(108) = dx_si6_slow;
dx(109) = dx_si7_slow;
dx(110) = dx_si8_slow;
dx(111) = dx_si9_slow;
dx(112) = dx_si10_slow;
dx(113) = dx_out_slow;

dx(114) = dx_GLP1_act;
dx(115) = dx_GLP1_ina;

%% Combine variables we want to calculate in out
out.D1         = D1;
out.D2         = D2;
out.D3         = D3;

out.LIp        = li_pc;
out.LIs        = li_sc;
out.ASBTp      = x_si_pc;
out.ASBTs      = x_si_sc;
out.k_sp       = k_sp;

out.feces1     = fa_pu+fa_pc+fa_su+fa_sc;
out.feces2     = DIS;

out.Vmax       = vmax_asbt*max((1-k_ASBT*D3),0);
out.li_x_pc    = li_x_pc;

out.GLP_quick = GLP1_quick;
out.GLP_slow  = GLP1_slow;
out.GLP1_ba   = GLP1_ba;
out.GLP1_q1   = GLP1_q1;    
out.GLP1_q2   = GLP1_q2; 
out.GLP1_q3   = GLP1_q3; 
out.GLP1_q4   = GLP1_q4; 
out.GLP1_q5   = GLP1_q5; 
out.GLP1_q6   = GLP1_q6; 
out.GLP1_q7   = GLP1_q7; 
out.GLP1_q8   = GLP1_q8; 
out.GLP1_q9   = GLP1_q9; 
out.GLP1_q10   = GLP1_q10; 
out.k_si_2    = k_si_2;
out.GIr_delta_SI = GIr_delta_SI;

out.Q_up      = si_upt_quick_1 + si_upt_quick_2 + si_upt_quick_3 + si_upt_quick_4 + si_upt_quick_5 +...
                    si_upt_quick_6 + si_upt_quick_7 + si_upt_quick_8 + si_upt_quick_9 + si_upt_quick_10;

