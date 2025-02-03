function Bt = bigeminy_suppression(alpha, signal, rm, N, intervals)
% BIGEMINY_SUPPRESSION  
% Function used to remove bigeminy events that may be wrongly classified  
% as atrial fibrillation events by the algorithm.  
%  
% For each interval in the RR series, the numerator and denominator are  
% computed based on the 'rm' signal (the signal where a 3 point median filter is  
% applied) and the original signal.  
%  
% B is then filtered using the exponential averaging method (or fowrdwar_backward), 
% obtaining Bt as the final result.  
    B = zeros(size(signal));
    for n=1:intervals
        numerator = 0;
        denominator = 0;
        for j=0:N-1
            if (n-j) > 0
                numerator = numerator + rm(n-j);
                denominator = denominator + signal(n-j);
            end
        end
        B(n) = (numerator/denominator -1)^2;
    end
    Bt = forward_backward(B, alpha);
end

