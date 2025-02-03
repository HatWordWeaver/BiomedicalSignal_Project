function [signal, fs, indices, annots_aux, RR_series, intervals] = data_extraction(record_name)

% DATA_EXTRACTION  
% Function used to extract data and annotations from files.   
% The following will be extracted:  
% signal -> LTAF signal.  
% fs -> Sampling frequency of the signal.  
% indices -> Indices for types of heartbeats.  
% annots_aux -> Annotations for every detected heartbeat.   
% Furthermore, the number of intervals in the signal is computed.  

% Reading signal and sampling frequency from file
[signal, fs] = rdsamp(record_name);
% Reading from file
[indices,~,~,~,~, annots_aux] = rdann(record_name, 'atr');
% Cleaning indices
indices_cleaned = indices <= length(signal) & indices > 0;
% Rewriting indices where condition is respected
indices = indices(indices_cleaned);
% Computing RR interval series
RR_series = diff(indices/fs);
% Resume original length of r by simply placing r(1) on the very top of the
% array
RR_series = [RR_series(1); RR_series];
% intervals will be given by the length of r
intervals = length(RR_series);
end