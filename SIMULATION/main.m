%% MAIN FILE FOR THE SOFTWARE ACCOMPANYING:
%
%  Title:   "Altered bile acid kinetics contribute to postprandial 
%           hypoglycaemia after Roux-en-Y gastric bypass surgery "
%
%  Authors: M. van den Broek, L.J.M. de Heide, F.L.P. Sips, M. Koehorst, 
%           T. van Zutphen, M. Emous, M. van Faassen, A.K. Groen, 
%           N.A.W. van Riel, J.F.de Boer,  A.P. van Beek, F.Kuipers
%
%  Contact: Eindhoven University of Technology, F.L.P. Sips (f.l.p.sips@tue.nl)

%% ------------------------------------------------------------------------
%  Preparations: add all local folders to the path
%  ------------------------------------------------------------------------

% Note: run this file from the "Simulation_files" folder
addpath(genpath(pwd)) 


%% ------------------------------------------------------------------------
%  Generate OR load results
%  ------------------------------------------------------------------------

% Attempt to load the pre-generated simulations. Else, re-generate
% and process results
try 
    load('20191218_results.mat');
catch
    run_results();
    process_results();
end

%% ------------------------------------------------------------------------
%  Calculate fasting and postprandial BA from results
%  ------------------------------------------------------------------------
calculate_characteristics();

%% ------------------------------------------------------------------------
%  Plot the final figure
%  ------------------------------------------------------------------------
plot_final_figure();