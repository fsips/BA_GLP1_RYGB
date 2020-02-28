%% FILE FOR THE SOFTWARE ACCOMPANYING:
%
%  Title:   "Altered bile acid kinetics contribute to postprandial 
%           hypoglycaemia after Roux-en-Y gastric bypass surgery "

%% ------------------------------------------------------------------------
%  Preparations: run basic (normal) simulation
%  ------------------------------------------------------------------------

study_base          = retrieve_RYGB_study();
param_values        = [];
param_locations     = [];

%% ------------------------------------------------------------------------
%  RUN the current study setup for all pre-run parametersets
%  ------------------------------------------------------------------------

for it1 = 1:size(situations,2)
    for it2 = 1:size(situations,3)
        
        %% RYGB
        curr_base = situations{2,it1,it2}.surgery_sim{end};
        
        curr_base.param(param_locations) = param_values;
        
        % Setup and run preparation phase
        curr_base.days  = 0;
        curr_base.rythm = [6 6 12];
        curr_base.input = adapt_input(curr_base.input, study_base{1}.prep.u);
        
        curr_base = run_condition(curr_base, M);
        
        % Setup and run meal test
        curr_base.days  = 1;
        curr_base.rythm = 5;
        curr_base.input = adapt_input(curr_base.input, study_base{1}.meal.u);
        
        grid{1,it1,it2} = run_condition(curr_base, M);
        
        %% RYGB + CC
        curr_base = situations{4,it1,it2}.surgery_sim{end};
        
        curr_base.param(param_locations) = param_values;
        
        % Setup and run preparation phase
        curr_base.days  = 0;
        curr_base.rythm = [6 6 12];
        curr_base.input = adapt_input(curr_base.input, study_base{2}.prep.u);
        
        curr_base = run_condition(curr_base, M);
        
        % Setup and run meal test
        curr_base.days  = 1;
        curr_base.rythm = 5;
        curr_base.input = adapt_input(curr_base.input, study_base{2}.meal.u);
        
        
        grid{2,it1,it2} = run_condition(curr_base, M);
        
    end
end
