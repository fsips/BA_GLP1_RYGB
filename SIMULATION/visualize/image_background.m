function [] = image_background(fn, lim1, lim2)

I = imread(fn);
h = image(lim1{1},lim1{2},I);
uistack(h,'bottom')


% RESET LIMITS
xlim(lim2{1}) 
ylim(lim2{2})