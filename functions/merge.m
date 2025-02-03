function O = merge(It, Bt, delta)
% MERGE  
% Function used to produce the final series by merging  
% the RR_interval_irregularity (It) and Bigeminy Suppression (Bt) series.  
%  
% O -> The final result, with the same length as the other two arrays.  
% The decision to merge is determined by a comparison with a delta value.  
    O = zeros(size(It));
    for n=1:length(It)
        if(Bt(n) >= delta)
            O(n) = It(n);
        else
            O(n) = Bt(n);
        end
    end
end