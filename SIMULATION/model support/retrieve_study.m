function [study_sim] = retrieve_study(study)
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

% Sitagliptin factor (of DPP4 inhibition)
sitagliptin     = 2;

switch study
    case 1
        %% 1. Sonne (2012)
        
        % MEAL
        meal_u                  = delta_u_template;
        meal_u(loc.volume)      = 2/3*524;      % (ESTIMATE)
        meal_u(loc.quick)       = 232;
        meal_u(loc.slow)        = 292;
        meal_u(loc.length)      = 10;
        
        % EXPERIMENT 1: 
        % start from "normal" base 
        % no preparation time
        % normal meal
        
        study_sim{1}.base       = 1;
        
        study_sim{1}.prep.days  = 0;
        study_sim{1}.prep.rythm = [NaN];
        study_sim{1}.prep.u     = delta_u_template;
                
        study_sim{1}.meal.u     = meal_u;
        
        % EXPERIMENT 2: 
        % start from "normal" base 
        % no preparation time
        % normal meal
        study_sim{2}.base       = 2;
        
        study_sim{2}.prep.days  = 0;
        study_sim{2}.prep.rythm = [NaN];
        study_sim{2}.prep.u     = delta_u_template;
        
        study_sim{2}.meal.u     = meal_u;
        
    case 2
        %% 2. van Nierop (2019)
        
        % MEAL
        meal_u                  = delta_u_template;
        meal_u(loc.volume)      = 2/3*625;      % (ESTIMATE)
        meal_u(loc.quick)       = 0.4*625;
        meal_u(loc.slow)        = 0.6*625;
        meal_u(loc.length)      = 15;
                
        % EXPERIMENT 1: 
        % start from "normal" base 
        % preparation: 14 hours fasting
        % normal meal
                
        study_sim{1}.base       = 1;
        
        study_sim{1}.prep.days  = 1;
        study_sim{1}.prep.rythm = [6 6 14];
        study_sim{1}.prep.u     = delta_u_template;
                
        study_sim{1}.meal.u     = meal_u;
        
        % EXPERIMENT 2: 
        % start from "normal" base 
        % preparation: 40 hours fasting
        % normal meal
        
        study_sim{2}.base       = 1;
        
        study_sim{2}.prep.days  = 1;
        study_sim{2}.prep.rythm = [6 6 40];
        study_sim{2}.prep.u     = delta_u_template;
                
        study_sim{2}.meal.u     = meal_u;
        
        % EXPERIMENT 3: 
        % start from "normal" base 
        % preparation: 14 hours fasting
        % normal meal + DCA

        study_sim{3}.base       = 1;
        
        study_sim{3}.prep.days  = 1;
        study_sim{3}.prep.rythm = [6 6 14];
        study_sim{3}.prep.u     = delta_u_template;
        
        study_sim{3}.meal.u         = meal_u;
        study_sim{3}.meal.u(loc.sc) = 750/400*1e3;
        % 750 mg
        % = 750 / 400 [g/mol] = 1.87 mmol
        % = 1875 micromol
        
    case 3
        %% 3. Shah (2014)
        
        % MEAL
        meal_u                  = delta_u_template;
        meal_u(loc.volume)      = 150;      % (ESTIMATE)
        meal_u(loc.quick)       = 123.2;
        meal_u(loc.slow)        = 96.8;
        meal_u(loc.length)      = 7.5;     
        
        % EXPERIMENT 1: 
        % start from "normal" base 
        % No preparation
        % normal meal        
        study_sim{1}.base       = 1;
        
        study_sim{1}.prep.days  = 0;
        study_sim{1}.prep.rythm = [NaN];
        study_sim{1}.prep.u     = delta_u_template;
                
        study_sim{1}.meal.u     = meal_u;
        
        % EXPERIMENT 2: 
        % start from "normal" base 
        % No preparation
        % meal under influence of EXENDIN [9-39] infusion        
        study_sim{2}.base       = 1;
        
        study_sim{2}.prep.days  = 0;
        study_sim{2}.prep.rythm = [NaN];
        study_sim{2}.prep.u     = delta_u_template;
                
        study_sim{2}.meal.u          = meal_u;
        study_sim{2}.meal.u(loc.EXEN)= 1;
        
        % EXPERIMENT 3: 
        % start from "RYGB" base 
        % No preparation
        % normal meal        
        study_sim{3}.base       = 3;
        
        study_sim{3}.prep.days  = 0;
        study_sim{3}.prep.rythm = [NaN];
        study_sim{3}.prep.u     = delta_u_template;
                
        study_sim{3}.meal.u     = meal_u;
        
        % EXPERIMENT 4: 
        % start from "RYGB" base 
        % No preparation
        % meal under influence of EXENDIN [9-39] infusion        
        study_sim{4}.base       = 3;
       
        study_sim{4}.prep.days  = 0;
        study_sim{4}.prep.rythm = [NaN];
        study_sim{4}.prep.u     = delta_u_template;
                
        study_sim{4}.meal.u          = meal_u;
        study_sim{4}.meal.u(loc.EXEN)= 1;
        
    case 4
        %% Bagger (2011)
        
        % MEAL
        meal_u                  = delta_u_template;
        meal_u(loc.volume)      = 300; 
        meal_u(loc.quick)       = 25*4;
        meal_u(loc.slow)        = 0;
        meal_u(loc.length)      = 5;   
        
      	% EXPERIMENT 1:
        % start from "normal" base 
        % No preparation
        % 25 gram OGTT       
        study_sim{1}.base       = 1;
        
        study_sim{1}.prep.days  = 0;
        study_sim{1}.prep.rythm = [NaN];
        study_sim{1}.prep.u     = delta_u_template;
                
        study_sim{1}.meal.u         = meal_u;
        
     	% EXPERIMENT 2:
        % start from "normal" base 
        % No preparation
        % 75 gram OGTT       
        study_sim{2}.base       = 1;
        
        study_sim{2}.prep.days  = 0;
        study_sim{2}.prep.rythm = [NaN];
        study_sim{2}.prep.u     = delta_u_template;
                
        study_sim{2}.meal.u         = meal_u;
        study_sim{2}.meal.u(loc.quick)   = 75*4;
        
       	% EXPERIMENT 3:
        % start from "normal" base 
        % No preparation
        % 125 gram OGTT       
        study_sim{3}.base       = 1;
       
        study_sim{3}.prep.days  = 0;
        study_sim{3}.prep.rythm = [NaN];
        study_sim{3}.prep.u     = delta_u_template;
                
        study_sim{3}.meal.u         = meal_u;
        study_sim{3}.meal.u(loc.quick)   = 125*4;   
        
 	case 6
        %% Van den Broek (DEMONSTRATION)
        
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
        
end