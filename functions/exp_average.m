function Rt = exp_average(signal, alpha)
% EXP_AVERAGE  
% Function used to apply exponential average filter to the signal.  
    Rt = zeros(size(signal));
    for n = 2:length(signal)
        Rt(n) = Rt(n-1) + alpha*(signal(n)-Rt(n-1));
    end
end