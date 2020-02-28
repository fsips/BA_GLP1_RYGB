
GLP1_act = 2:1:100;
EXEN = 0;

glp1_st  = 2;
val_norm = glp1_st./(((1-EXEN)*GLP1_act + EXEN*2) + glp1_st); 

glp1_st  = 5;
val_high = glp1_st./(((1-EXEN)*GLP1_act + EXEN*2) + glp1_st); 

glp1_st  = 0.5;
val_low = glp1_st./(((1-EXEN)*GLP1_act + EXEN*2) + glp1_st); 

figure()
plot(GLP1_act, val_norm, 'k'); hold on
plot(GLP1_act, val_high, 'r'); hold on
plot(GLP1_act, val_low, 'g'); hold on
legend('2', '5', '0.5')
ylabel('factor (x stomach emptying)')
xlabel('GLP1 (pM)')