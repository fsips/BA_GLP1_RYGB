function u_out = adapt_input(u_in, u_delta)

for it = 1:length(u_in)
    if ~isnan(u_delta(it))
        u_out(it) = u_delta(it);
    else
        u_out(it) = u_in(it);
    end
end