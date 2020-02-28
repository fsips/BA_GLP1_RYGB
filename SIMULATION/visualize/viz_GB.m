viz.basis   = situations{1}{1}.base_sim;        % Normal
k_gb        = viz.basis.param(3);
study_base  = retrieve_study(6);
delta       = [1:15];

for it = 1:length(delta)
    viz.demo{it} = viz.basis;
    viz.demo{it}.param(3) = k_gb / delta(it);
    
    % Setup demonstration run basis
    viz.demo{it}.instructions = study_base{it_type};
    viz.demo{it}.days  = 1;
    viz.demo{it}.rythm = [6];
    viz.demo{it}.input = adapt_input(viz.demo{it}.input, study_base{1}.meal.u);
    viz.demo{it}.meal = run_condition(viz.demo{it}, M);
end

%%
figure()
for it = 1:length(delta)
    plot(viz.demo{it}.meal.t, sum(viz.demo{it}.meal.x(:,[3:4])')/sum(viz.demo{it}.meal.x(1,[3:4])'), 'Color', [0 0 1-it*0.05]); hold on
end
