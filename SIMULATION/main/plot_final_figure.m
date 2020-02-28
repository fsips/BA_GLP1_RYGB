%% FILE FOR THE SOFTWARE ACCOMPANYING:
%
%  Title:   "Altered bile acid kinetics contribute to postprandial 
%           hypoglycaemia after Roux-en-Y gastric bypass surgery "

%% ------------------------------------------------------------------------
%  Preparations: admin
%  ------------------------------------------------------------------------

% Remember, in base:
% base(1,1) - non-hypoglycemia, rygb only
% base(1,2) - non-hypoglycemia, rygb+CC
% base(2,1) - hypoglycemia, rygb only
% base(2,2) - hypoglycemia, rygb+CC

demonstration.study{1}{1}.meal = base{1,1};
demonstration.study{1}{2}.meal = base{1,2};
demonstration.study{2}{1}.meal = base{2,1};
demonstration.study{2}{2}.meal = base{2,2};


%% ------------------------------------------------------------------------
%  Create figure
%  ------------------------------------------------------------------------

figure(); ys = 2; xs = 3;
cs = {[0.6 0.6 0.6]  [0 0 0] };
style = {'-' ':'};

%  ------------------------------------------------------------------------
% B: Plasma BA for non-hypo and hypo groups (RYGB only)
for it_study = 1:2
    it = 1; % Do not plot CC (it = 2), in B
    subplot(ys,xs,1); plot(demonstration.study{it_study}{it}.meal.t, sum(demonstration.study{it_study}{it}.meal.x(:,[69:72])'), style{it}, 'Color', cs{it_study}, 'LineWidth', 1.5); hold on
    ylabel('Plasma BA concentration (\mumol/L)'); xlabel('Time (min)')
    xlim([0 210])
end
legend({'median non-hypoglycemia (no CC)' 'median hypoglycemia (no CC)' })

%  ------------------------------------------------------------------------
% -: Distal BA for non-hypo and hypo groups (RYGB only)
for it_study = 1:2
    for it = 1:1
        subplot(ys,xs,2); plot(demonstration.study{it_study}{it}.meal.t, sum(demonstration.study{it_study}{it}.meal.x(:,[51:54 21:24])'), style{it}, 'Color', cs{it_study}, 'LineWidth', 1.5); hold on
        ylabel('Distal SI bile acid content (\mumol)'); xlabel('Time (min)')
        xlim([0 210])
    end
end
legend({'median non-hypoglycemia (no CC)' 'median hypoglycemia (no CC)'})

%  ------------------------------------------------------------------------
% C: GLP-1 for non-hypo and hypo groups (RYGB only)
for it_study = 1:2
    for it = 1:1
        subplot(ys,xs,3); plot(demonstration.study{it_study}{it}.meal.t, demonstration.study{it_study}{it}.meal.x(:,[114]), style{it}, 'Color', cs{it_study}, 'LineWidth', 1.5); hold on
        ylabel('Active GLP-1 (pmol/L)')
        xlim([0 210])
    end
end
legend({'median non-hypoglycemia (no CC)' 'median hypoglycemia (no CC)'})

%  ------------------------------------------------------------------------
% D: Plasma BA for non-hypo and hypo groups (RYGB + CC)
for it_study = 1:2
    for it = 1:2
        subplot(ys,xs,4); plot(demonstration.study{it_study}{it}.meal.t, sum(demonstration.study{it_study}{it}.meal.x(:,[69:72])'), style{it}, 'Color', cs{it_study}, 'LineWidth', 1.5); hold on
        ylabel('Plasma BA concentration (\mumol/L)'); xlabel('Time (min)')
        xlim([0 210])
    end
end
legend({'median non-hypoglycemia (no CC)' 'median non-hypoglycemia (+ CC)' 'median hypoglycemia (no CC)' 'median hypoglycemia (+ CC)'})

%  ------------------------------------------------------------------------
% E: Distal BA for non-hypo and hypo groups (RYGB + CC)
for it_study = 1:2
    for it = 1:2
        subplot(ys,xs,5); plot(demonstration.study{it_study}{it}.meal.t, sum(demonstration.study{it_study}{it}.meal.x(:,[51:54 21:24])'), style{it}, 'Color', cs{it_study}, 'LineWidth', 1.5); hold on
        ylabel('Distal SI bile acid content (\mumol)'); xlabel('Time (min)')
        xlim([0 210])
    end
end
legend({'median non-hypoglycemia (no CC)' 'median non-hypoglycemia (+ CC)' 'median hypoglycemia (no CC)' 'median hypoglycemia (+ CC)'})

%  ------------------------------------------------------------------------
% F: GLP-1 for non-hypo and hypo groups (RYGB + CC)
subplot(ys,xs,6)
plot(p_range, peak_CC, ':', 'Color', [0 0 0], 'LineWidth', 1.5); hold on
plot(p_range, peak_no, '-', 'Color', [0 0 0], 'LineWidth', 1.5); hold on
xlim([0 11])
xlabel('L-cell sensitivity to BA (fold change)')
ylabel('Peak GLP-1 concentration (pmol/L)')
axis([0 11 0 200])
legend('cholecystectomy', 'no cholecystectomy')


%% ------------------------------------------------------------------------
% Calculate AUC and plot
%  ------------------------------------------------------------------------
it_study = 1; % Mild
it       = 1; % No cc
find_period = demonstration.study{it_study}{it}.meal.t<=210;
 
AUC_mild    = trapz(demonstration.study{it_study}{it}.meal.t(find_period), demonstration.study{it_study}{it}.meal.x(find_period,114));
 
it_study = 2;
AUC_extreme = trapz(demonstration.study{it_study}{it}.meal.t(find_period), demonstration.study{it_study}{it}.meal.x(find_period,114));

figure()
bar([2], [AUC_extreme], 'FaceColor', [0 0 0]); hold on
bar([1], [AUC_mild],    'FaceColor', [0.5 0.5 0.5])
set(gca, 'XTick', [1 2])
ylabel('GLP-1 AUC (pmol/L .min)')
