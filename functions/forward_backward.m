function Rt = forward_backward(signal, alpha)
% FORWARD_BACKWARD  
% Exponential average filter applied using the forward-backward technique. 
b = alpha;
a = [1, alpha-1];
Rt = filtfilt(b, a, signal);
end

