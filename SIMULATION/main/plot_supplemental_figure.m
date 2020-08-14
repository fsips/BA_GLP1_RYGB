%% FILE FOR THE SOFTWARE ACCOMPANYING:
%
%  Title:   "Altered bile acid kinetics contribute to postprandial 
%           hypoglycaemia after Roux-en-Y gastric bypass surgery "

%% ------------------------------------------------------------------------
%  Preparations: admin
%  ------------------------------------------------------------------------

BAf = sum(base_sim.x(end,[69:72])');
n = 10;


%% ------------------------------------------------------------------------
%  Create figure
%  ------------------------------------------------------------------------

figure();

% A: Contour of fasting BA
%  ------------------------------------------------------------------------

subplot(2,2,1)

% Contour
s = contour(cor, 1./cot, squeeze(grid_vals.BAf(1,:,:)),[BAf:(max(max(squeeze(grid_vals.BAf(1,:,:)))) - BAf)/n:max(max(squeeze(grid_vals.BAf(1,:,:))))], 'LineWidth', 1.5);
colorbar(); hold on

% Markers for selected simulations
for it2 = 1:2
    plot(cor(sum(match{it2})==1), 1/cot(sum(match{it2}')==1), 'ok', 'MarkerFaceColor', 1-[(it2-1)/2 (it2-1)/2 (it2-1)/2])
end

xlabel('Increase of postprandial reaction'); ylabel('Decrease of postabsorptive transit')
title('Fasting BA_{plasma} (\mumol/L)')

% B: Contour of peak BA
%  ------------------------------------------------------------------------

subplot(2,2,2)

% Contour
s = contour(cor, 1./cot, squeeze(grid_vals.BAp(1,:,:)),n, 'LineWidth', 1.5);
colorbar(); hold on

% Markers for selected simulations
for it2 = 1:2
    plot(cor(sum(match{it2})==1), 1/cot(sum(match{it2}')==1), 'ok', 'MarkerFaceColor', 1-[(it2-1)/2 (it2-1)/2 (it2-1)/2])
end

xlabel('Increase of postprandial reaction'); ylabel('Decrease of postabsorptive transit')
title('BA_{plasma} peak (\mumol/L)')


% C: Contour of relative increase
%  ------------------------------------------------------------------------

subplot(2,2,3)

% Contour
s = contour(cor, 1./cot, 100*(squeeze(grid_vals.BAr(1,:,:))-1),n, 'LineWidth', 1.5);
colorbar(); hold on

% Markers for selected simulations
for it2 = 1:2
    plot(cor(sum(match{it2})==1), 1/cot(sum(match{it2}')==1), 'ok', 'MarkerFaceColor', 1-[(it2-1)/2 (it2-1)/2 (it2-1)/2])
end
xlabel('Increase of postprandial reaction'); ylabel('Decrease of postabsorptive transit')

title('BA_{plasma} increase (%)')


% D: GLP1 peak
%  ------------------------------------------------------------------------

subplot(2,2,4)

% Contour
s = contour(cor, 1./cot, 100*(squeeze(grid_vals.GLP1(1,:,:)/2 -1)),n, 'LineWidth', 1.5);
colorbar(); hold on

% Markers for selected simulations
for it2 = 1:2
    plot(cor(sum(match{it2})==1), 1/cot(sum(match{it2}')==1), 'ok', 'MarkerFaceColor', 1-[(it2-1)/2 (it2-1)/2 (it2-1)/2])
end

xlabel('Increase of postprandial reaction'); ylabel('Decrease of postabsorptive transit')
title('GLP1_{active} increase (%)')

colormap('gray')
