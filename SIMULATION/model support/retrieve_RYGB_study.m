function [study_sim] = retrieve_RYGB_study()
% Note: do not define colors yet; van Nierop / Meessen uses to different
% colors for what is represented by the same simulation (14 hour fast and
% -gDCA)


delta_u_template= ones(31,1)*NaN;

% PHARMACEUTICALS
loc.EXEN        = 17; % LOGICAL
loc.SITA        = 19; % FACTOR TO DECRESE DPP4 ACTIVITY

% SURGERY
loc.RYGB        = 6;  % LOGICAL (usually, we use the long-term RYGB base)
loc.CC          = 18; % LOGICAL (usually, we use the long-term CC base)

% MEAL
loc.volume      = 10; % mL
loc.length      = 13; % min

loc.quick       = 11; % kcal
loc.slow        = 12; % kcal

loc.su          = 15; % micromol
loc.sc          = 16; % micromol

%% Van den Broek dataset

% MEAL
meal_u                  = delta_u_template;
meal_u(loc.volume)      = 200;
meal_u(loc.quick)       = 160;
meal_u(loc.slow)        = 140;
meal_u(loc.length)      = 10;

% EXPERIMENT 1:
% start from "RYGB" base
% No preparation
study_sim{1}.base       = 1;

study_sim{1}.prep.days  = 0;
study_sim{1}.prep.rythm = [NaN];
study_sim{1}.prep.u     = delta_u_template;

study_sim{1}.meal.u         = meal_u;

% EXPERIMENT 2:
% start from "RYGB+CC" base
% No preparation
study_sim{2}.base       = 2;

study_sim{2}.prep.days  = 0;
study_sim{2}.prep.rythm = [NaN];
study_sim{2}.prep.u     = delta_u_template;

study_sim{2}.meal.u     = meal_u;
        