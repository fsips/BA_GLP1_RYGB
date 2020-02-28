function [] = plot_type(sim, type, samples, markercolor)

final_meal  = sim.t > (sim.t(end)-6*60);
sim_samples = ismember(sim.t-sim.t(end)+6*60, samples);

switch type
    case 1 % TBA
        plot(sim.t(final_meal)-sim.t(end)+6*60,sum(sim.x(final_meal,69:72)')','k-', 'linewidth', 1.5); hold on
        plot(sim.t(sim_samples)-sim.t(end)+6*60,sum(sim.x(sim_samples,69:72)')','ks', 'MarkerFaceColor', markercolor, 'linewidth', 1.5)
        
    case 3 % FGF19
        plot(sim.t(final_meal)-sim.t(end)+6*60,1/50*(40+[sim.v(final_meal).D2]'),'k-', 'linewidth', 1.5); hold on
        plot(sim.t(sim_samples)-sim.t(end)+6*60,1/50*(40+[sim.v(sim_samples).D2]'),'ks', 'MarkerFaceColor', markercolor, 'linewidth', 1.5)

    case 4 % C4
        plot(sim.t(final_meal)-sim.t(end)+6*60,1/50*(40+[sim.v(final_meal).li_x_pc]'),'k-', 'linewidth', 1.5); hold on
        plot(sim.t(sim_samples)-sim.t(end)+6*60,1/50*(40+[sim.v(sim_samples).li_x_pc]'),'ks', 'MarkerFaceColor', markercolor, 'linewidth', 1.5)
    
    case 5 % GLP-1
end