function [u] = inputs_G(BW)

u(1)        = 0;        % tau
u(2)        = 0.045*BW;     % V_P (average weight)
u(3)        = 0.825;    % Q_L
u(4)        = 0.61875;  % Q_P
u(5)        = 0;        % k_bact_psi
u(6)        = 0;        % RYGB?
u(7)        = 91.9772;  % L0
u(8)        = 10.3870;  % ASBT0

u(9)        = 1;        % DPP4
u(10)       = 500;      % MEAL VOLUME
u(11)       = 2000/2/3; % MEAL QUICK CALORIES
u(12)       = 2000/2/3; % MEAL SLOW CALORIES
u(13)       = 30;       % MEAL LENGTH
u(14)       = 50;       % Length of an intestine compartment
u(15)       = 0;        % SU
u(16)       = 0;        % SC
u(17)       = 0;        % exendin [9-39]?
u(18)       = 0;        % cholecystectomy?
u(19)       = 1;        % sitagliptin? (divide k_ddp4 by this value)
u(20)       = 1000/3;   % Stomach volume (normal)

u(21)       = 0;     % Decrease of RYGB transit (defunct)

% REFERENCE FOR SI1 - SI10 (SC+SU)
u(22)       = 0;
u(23)       = 0;
u(24)       = 0;
u(25)       = 0;
u(26)       = 0;
u(27)       = 0;
u(28)       = 0;
u(29)       = 0;
u(30)       = 0;
u(31)       = 0;


 
