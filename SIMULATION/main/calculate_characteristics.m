%% FILE FOR THE SOFTWARE ACCOMPANYING:
%
%  Title:   "Altered bile acid kinetics contribute to postprandial 
%           hypoglycaemia after Roux-en-Y gastric bypass surgery "


%% ------------------------------------------------------------------------
%  SELECT the runs that most closely mirror the experimental data fasting
%  and maximal postprandial values. 
%  ------------------------------------------------------------------------

cor = change_of_reflex_RYGB;
cot = change_of_transit_RYGB;

% Reference fasting and postprandial TBA concentrations
%       Non-hypoglycemia    Hypoglycemia
refs = [2.896               5.492; 
        6.2                 28.1  ];

% Calculate all:
%   BAf  - fasting (total) bile acid level
%   BAp  - maximal (early) postprandial BA level
%   BAr  - BAp/BAf
%   GLP1 - maximal (active) GLP1 concentration
for it0 = 1:2
    for it1 = 1:size(grid,2)
        for it2 = 1:size(grid,3)
            grid_vals.BAf(it0,it1,it2) = sum(grid{it0,it1,it2}.x(1,[69:72])');
            grid_vals.BAp(it0,it1,it2) = max(sum(grid{it0,it1,it2}.x(grid{it0,it1,it2}.t<60,[69:72])'));
            grid_vals.BAr(it0,it1,it2) = grid_vals.BAp(it0,it1,it2) / grid_vals.BAf(it0,it1,it2);
            grid_vals.GLP1(it0,it1,it2) = max(grid{it0,it1,it2}.x(grid{it0,it1,it2}.t<15,[114]));
        end
    end
end
    
for it = 1:2
    % Find closest match in the RYGB-only group (grid_vals.X(1,:,:)) 
    % for the first or second datapoint (refs(:,1) and refs(:,2),
    % respectively)
    find_match =  ((squeeze(grid_vals.BAf(1,:,:))-refs(1,it)) / refs(1,it)).^2 +  ((squeeze(grid_vals.BAp(1,:,:))-refs(2,it)) / refs(2,it)).^2;
    match{it} = find_match == (min(min(find_match)));
    base{it,1} = grid{1,sum(match{it}')==1,sum(match{it})==1};
    base{it,2} = grid{2,sum(match{it}')==1,sum(match{it})==1};
    
    try
        % Save the base simulation for changing k_BAGLP1 below
        base_for_pchange{it,1} = situations{2,sum(match{it}')==1,sum(match{it})==1}.surgery_sim{end};
        base_for_pchange{it,2} = situations{4,sum(match{it}')==1,sum(match{it})==1}.surgery_sim{end};
        
    catch
        % if very large cell "situations" is unavailable, do ti with the pre-prepared ones
        load('base_for_pchange.mat')
    end
end

% SAVE in base:
% base(1,1) - non-hypoglycemia, rygb only
% base(1,2) - non-hypoglycemia, rygb+CC
% base(2,1) - hypoglycemia, rygb only
% base(2,2) - hypoglycemia, rygb+CC


%% ------------------------------------------------------------------------
%  CHANGE VALUE OF k_BAGLP1 (normal = 0.002)
%  ------------------------------------------------------------------------

study_base          = retrieve_RYGB_study();
p_range             = [1:0.5:10];
param_values        = [0.002];
param_locations     = [47];

for it1 = 1:length(p_range)
    
    %% RYGB
    curr_base = base_for_pchange{2,1};
    
    curr_base.param(param_locations) = param_values*p_range(it1);
    
    % Setup and run preparation phase
    curr_base.days  = 0;
    curr_base.rythm = [6 6 12];
    curr_base.input = adapt_input(curr_base.input, study_base{1}.prep.u);
    
    curr_base = run_condition(curr_base, 0);
    
    % Setup and run meal test
    curr_base.days  = 1;
    curr_base.rythm = 5;
    curr_base.input = adapt_input(curr_base.input, study_base{1}.meal.u);
    
    pchange_grid{it1,1} = run_condition(curr_base, 0);
    
    %% RYGB + CC
    curr_base = base_for_pchange{2,2};
    
    curr_base.param(param_locations) = param_values*p_range(it1);
    
    % Setup and run preparation phase
    curr_base.days  = 0;
    curr_base.rythm = [6 6 12];
    curr_base.input = adapt_input(curr_base.input, study_base{2}.prep.u);
    
    curr_base = run_condition(curr_base, 0);
    
    % Setup and run meal test
    curr_base.days  = 1;
    curr_base.rythm = 5;
    curr_base.input = adapt_input(curr_base.input, study_base{2}.meal.u);
    
    
    pchange_grid{it1,2} = run_condition(curr_base, 0);
    
end

% Calculate output
for it = 1:length(p_range)
    peak_CC(it) = max(pchange_grid{it,2}.x(:,[114]));
    peak_no(it) = max(pchange_grid{it,1}.x(:,[114]));
end