function It = rr_interval_irregularity(rm, alpha, gamma, rt, intervals, N)
% RR_INTERVAL_IRREGULARITY  
% Function used to find interval irregularity in the RR signal.  
%  
% First, the Heaviside step function is defined, as it will be used in  
% the process.  
% For each interval, a summation is computed using the signal and  
% the Heaviside step function. It is then normalized by the width  
% of the window.  
% M, the result of the for-each operation, is then filtered using the  
% exponential averager, resulting in Mt.  
% Finally, the final result, It, is obtained by dividing Mt by rt,  
% which is used to emphasize irregularity at higher heart rates.  


    Heaviside = @(r1, r2) double(abs(r1 - r2) >= gamma);
  
    % initialization of the series
    M = zeros(size(rm));

    for n=1:intervals
        sum = 0;
        for j=0:N-2
            for k=j+1:N-1
                if (n-j)>0 && (n-k)>0
                    sum = sum + Heaviside(rm(n-j), rm(n-k));
                end
            end
        end
        M(n) = sum * 2/(N*(N-1));
    end

    % application of exponential average filter
    Mt = forward_backward(M, alpha);
    % resulting series It
    It = Mt ./ rt;

end