function [time_recording, time_AF_events] = time_calculator(signal, fs, signal_groundtruth)
% TIME_CALCULATOR  
% Function used to calculate the duration of both the signal and total  
% atrial fibrillation events.  
AF_detection = nnz(signal_groundtruth(:)==1);
[rec_h, rec_m, rec_s] = calculate_time_string(length(signal), fs);
[af_h, af_m, af_s] = calculate_time_string(AF_detection, fs);
time_recording = sprintf('%02d:%02d:%02d', rec_h, rec_m, rec_s);
time_AF_events = sprintf('%02d:%02d:%02d', af_h, af_m, af_s);

    function [hours, minutes, seconds] = calculate_time_string(length, fs)
        seconds = length/fs;
        hours = floor(seconds/3600);
        minutes = floor(mod(seconds, 3600)/60);
        seconds = floor(mod(seconds, 60));
    end

end

