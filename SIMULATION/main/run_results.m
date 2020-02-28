%% FILE FOR THE SOFTWARE ACCOMPANYING:
%
%  Title:   "Altered bile acid kinetics contribute to postprandial 
%           hypoglycaemia after Roux-en-Y gastric bypass surgery "

%% ------------------------------------------------------------------------
%  Preparations: run basic (normal) simulation
%  ------------------------------------------------------------------------

[basis]                         = prep_for_exp(10, 0);
basis.days                      = 500;

basis_nofxr                     = basis;
base_sim                        = run_condition(basis_nofxr, 0);

%% ------------------------------------------------------------------------
%  Run surgery simulation
%  ------------------------------------------------------------------------

% Parameter perturbations
change_of_transit_RYGB = [0.2:0.1:1        ];
change_of_reflex_RYGB  = [15  10  5  2.5  1];

% Run simulations for 
% it_surg == 1: RYGB
% it_surg == 2: CC
% it_surg == 3: RYGB followed by CC (order is not important)

for it_surg =1:3
    
    switch it_surg
        case 1
            surgery_schedule = [1]; % RYGB
            cot              = change_of_transit_RYGB;
            cor              = change_of_reflex_RYGB;
        case 2
            surgery_schedule = [2]; % Cholecystectomy
            % DO NOT DO FULL PARAMETER PERTUBATIONS HERE
            cot              = [1]; 
            cor              = [1];
        case 3
            surgery_schedule = [1 2]; % RYGB + CC
            cot              = change_of_transit_RYGB;
            cor              = change_of_reflex_RYGB;
    end
    
    % RUN full grid of parameter values
    for it_t = 1:length(cot)
        for it_r = 1:length(cor)
            
            curr_base = basis_nofxr;
            
            % Display progress
            disp('Now doing:');
            disp(['Surgery: ', num2str(it_surg)]);
            disp(['COT:     ', num2str(it_t)]);
            disp(['COR:     ', num2str(it_r)]);
            disp(['']);
            
            % Implement parameter changes: transit
            curr_base.param(18:20) = basis.param(18:20) * cot(it_t);
            curr_base.param(4)     = basis.param(4) * cor(it_r);
            curr_base.days         = 500;
            
            % Do surgeries
            for it_phase = 1:length(surgery_schedule)
                
                if surgery_schedule(it_phase) == 1          % RYGB
                    curr_base.input(6)      = 1;
                elseif surgery_schedule(it_phase) == 2      % Cholecystectomy
                    curr_base.input(18)     = 1;
                end
                
                % Do the simulation to SS (500 days) 
                situations{it_surg+1, it_t, it_r}.surgery_sim{it_phase}         = run_condition(curr_base, 0);
                situations{it_surg+1, it_t, it_r}.surgery_sim{it_phase}.input   = reset_refs(situations{it_surg+1, it_t, it_r}.surgery_sim{it_phase}.input, situations{it_surg+1, it_t, it_r}.surgery_sim{it_phase}.x(end,:));
                
                % If it is the last one, follow up with one more 5 day run
                if it_phase == length(surgery_schedule) 
                    situations{it_surg+1, it_t, it_r}.surgery_sim{it_phase+1}       = situations{it_surg+1, it_t, it_r}.surgery_sim{it_phase};
                    situations{it_surg+1, it_t, it_r}.surgery_sim{it_phase+1}.days  = 5;
                    situations{it_surg+1, it_t, it_r}.surgery_sim{it_phase+1}       = run_condition(situations{it_surg+1, it_t, it_r}.surgery_sim{it_phase}, 0);
                
                % Else, set the basis for the new surgery phase to the end
                % of the current one.
                else
                    curr_base = situations{it_surg+1, it_t, it_r}.surgery_sim{it_phase};
                end
            end
        end
    end
end

disp('DONE :)')

