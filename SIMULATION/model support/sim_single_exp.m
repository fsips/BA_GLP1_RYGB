function [sim] = sim_single_exp(type, base)

if type{1}{1} == 1 % van Nierop / Meessen
    for it = [type{2}{:}]
        
        curr_base = base;
        
        switch it 
            case 1 % 14 hour fast
                curr_base.rythm = [14 6];
                curr_base.days  = 1;
                
            case 2 % 40 hour fast
                curr_base.rythm = [40 6];
                curr_base.days  = 1;
                
            case 3 % Normal meal
                
            case 4 % Ingest gDCA
                
        end
        sim{it} = run_condition(curr_base, 1);
    end
end

