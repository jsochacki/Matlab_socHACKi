function [h0,h1,g0,g1] = Johnston_QMF_FG(TRANSITION_BAND,TAPS)
h0 =johnston_filters(TRANSITION_BAND,TAPS);

% Use the filter length to compute the other filters
L = length(h0);
n = 0:L-1;
h1 = fliplr(((-1).^n).*h0);
g0 = 2*fliplr(h0);
g1 = 2*fliplr(h1);

end