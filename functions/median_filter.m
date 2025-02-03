function Mr = median_filter(signal)
%   MEDIAN FILTER
%   Application of 3 point median filter function (medfilt1) to the signal.
    Mr = medfilt1(signal);
end