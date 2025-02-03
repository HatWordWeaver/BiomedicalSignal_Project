function [RR_groundtruth, signal_groundtruth, AF_events] = annotations_events(annots_aux, indices, signal, intervals)
% ANNOTATIONS_EVENTS  
% Function used to extract the ground truth array based on annotations provided  
% with the dataset for each signal.  
%   
% - RR_event_start is an array where indices with '(' from annots_aux are  
%   stored.  
% - RR_event_end is an array where indices indicating the end of an atrial fibrillation  
%   event are stored.  
% - signal_event_start and signal_event_end perform the same function as above,  
%   but for the entire signal.  
% - names_episodes stores annotations.  
% - RR_groundtruth is the final table that will be used as a comparator  
%   for the predictions made by the algorithm.  
% - signal_groundtruth is an array for the original signal with  
%   the correct indices where atrial fibrillation occurs.
% - AF_events counts all the AF_events

RR_event_start = find(cellfun(@(x) ischar(x) && startsWith(x, '('), annots_aux));
RR_event_end = [RR_event_start(2:end)-1; intervals];

signal_event_start = indices(RR_event_start);
signal_event_end = [signal_event_start(2:end)-1; length(signal)];
signal_groundtruth = zeros(length(signal), 1);
names_episodes = annots_aux(RR_event_start);
RR_groundtruth = zeros(intervals, 1);

% loop to find '(AFIB' labels as they mean Atrial Fibrillation
for i=1:length(names_episodes)
    % comparing string found
    if strcmp(names_episodes{i}, "(AFIB")
        signal_groundtruth(signal_event_start(i):signal_event_end(i)) = 1;
        RR_groundtruth(RR_event_start(i):RR_event_end(i)) = 1;
    end
end

% counting AF_events
AF_events = nnz(RR_groundtruth(:)==1);

