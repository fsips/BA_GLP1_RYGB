function [] = plot_feature(study, feature_type)

switch feature_type
    case 1 % Stomach kinetics
        figure();
        
        ys = 1;
        xs = length(study);
        
        for it = 1:length(study)
            u = study{it}.meal.input;
            p = study{it}.meal.param;
            
            subplot(ys,xs,it)
            
            % Calculate
            GLP1_act        = study{it}.meal.x(:,114);
            st3_vol         = study{it}.meal.x(:,79);
            k_st_1          = p(32);
            k_st_2          = p(33);
            glp1_st         = p(34);
            EXEN            = u(17);
            RYGB            = u(6);
            STOM_VOLUME     = u(20);
            if RYGB
                STOM_VOLUME     = STOM_VOLUME/p(48);
            end
            
            effect_GLP1_ST   = glp1_st./(((1-EXEN)*GLP1_act + EXEN*2) + glp1_st);
            empt_rate_3      = (k_st_1 + k_st_2 .* st3_vol)/STOM_VOLUME .* effect_GLP1_ST;
            
            empt_rate_3a     = ones(size(study{it}.meal.t))*(k_st_1)/STOM_VOLUME .* effect_GLP1_ST(1);
            empt_rate_3b     = (k_st_2 .* st3_vol)/STOM_VOLUME .* effect_GLP1_ST(1);
            empt_rate_3c     = (k_st_1 + k_st_2 .* st3_vol(1))/STOM_VOLUME .* effect_GLP1_ST;
            
            plot(study{it}.meal.t, empt_rate_3, 'k-'); hold on
            plot(study{it}.meal.t, empt_rate_3a, 'r-')
            plot(study{it}.meal.t, empt_rate_3b, 'b-')
            plot(study{it}.meal.t, empt_rate_3c, 'g-')
            legend({'TOTAL' 'k_st_1' 'k_st_2' 'GLP1'})
        end
end
        