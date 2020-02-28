function [basis] = prep_for_exp(k_sp, M)

%% Initialization
if M
    pre.param       = parameters_M(k_sp);
    pre.input       = inputs_M();
    pre.rythm       = [6,6,12];
    pre.days        = 50;
    pre.x0          = zeros(76,1);
else
    BW = 93.15;
    pre.param       = parameters_G(k_sp, BW);
    pre.input       = inputs_G(BW);
    pre.rythm       = [6,6,12];
    pre.days        = 50;
    pre.x0          = zeros(115,1);
    pre.x0(114)     = 2;
    pre.x0(115)     = 18;
end
basis           = pre;

%% Pre-surgery: Run model to for a 50 normal days 
pre             = run_condition(pre, M);

figure()
plot(pre.t, pre.x(:, 80:82));

%% Determine 24h-mean of 
figure();
loc = find(pre.t == pre.t(end)-24*60);

% (a) liver concentration
L0 = trapz(pre.t(loc:end)-pre.t(loc), ([pre.v(loc:end).LIp].*[pre.v(loc:end).k_sp]+[pre.v(loc:end).LIs]))/(24*60); 
subplot(2,2,1); plot((pre.t(loc:end)-pre.t(loc))/60, ([pre.v(loc:end).LIp].*[pre.v(loc:end).k_sp]+[pre.v(loc:end).LIs])); hold on
plot([0 24], [L0 L0], 'r:')
xlim([0 24]); xlabel('Time (hrs)'); ylabel('Liver BA')

basis.input(7) = L0;

% (b) ASBT flux
ASBT0 = trapz(pre.t(loc:end)-pre.t(loc), ([pre.v(loc:end).ASBTp].*[pre.v(loc:end).k_sp]+[pre.v(loc:end).ASBTs]))/(24*60); 
subplot(2,2,2); plot((pre.t(loc:end)-pre.t(loc))/60,([pre.v(loc:end).ASBTp].*[pre.v(loc:end).k_sp]+[pre.v(loc:end).ASBTs])); hold on
plot([0 24], [ASBT0 ASBT0], 'r:')
xlim([0 24]); xlabel('Time (hrs)'); ylabel('ASBT flux')

basis.input(8) = ASBT0;

%% Also do u corrections
if ~M
    basis.input = reset_refs(basis.input, pre.x(end, :));
end

%% Check corrections
pre             = run_condition(basis, M);

% 
subplot(2,2,3)
plot((pre.t(loc:end)-pre.t(loc))/60,([pre.v(loc:end).D1]), 'b'); hold on
plot((pre.t(loc:end)-pre.t(loc))/60,([pre.v(loc:end).D3]), 'g'); hold on

subplot(2,2,4)
plot((pre.t(loc:end)-pre.t(loc))/60,([pre.v(loc:end).D1])./basis.input(7), 'b'); hold on
plot((pre.t(loc:end)-pre.t(loc))/60,([pre.v(loc:end).D3])./basis.input(7), 'g'); hold on

%% Use end of pre to kick-start changes
basis.x0        = pre.x(end,:)';

