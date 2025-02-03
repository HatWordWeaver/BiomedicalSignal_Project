% Path of WFDB Toolbox
% located inside the main folder 'WFDB'
% Change the path in case
addpath(fullfile(pwd, 'WFDB'));

% Path of functions used
addpath(fullfile(pwd, 'functions'));
savepath;

% Variables used  
% They can be customized  
% alpha     -> Used for exponential averaging.
% gamma     -> Used for interval irregularity.  
% N         -> Size of the sliding window for interval irregularity.  
% delta     -> Used in the merge phase for comparison.  
% threshold -> Used to compute the predictions.  
alpha = 0.02;                 % 0.02 suggested by the paper
gamma = 0.03;                 % 0.03 suggested by the paper
N = 8;                        % 8 suggested by the paper
delta = 2e-4;                 % 2e-4 suggest by the paper
threshold = 0.725;            % 0.725 suggested by the paper

% plot for singular execution
% = 1 plot | = 0 don't plot
plot_results = plot_methods();
plot_final_merge = 1;
plot_comp_irr_bigeminy = 1;
plot_groundtruth = 1;

% Path for signals and annotations  
% If this is your first installation, make sure to follow the path written in  
% the string; otherwise, change it to your dataset path.  
path_to_record = 'database\mcode\dataSet01\files\';

% Array containing the names of files sorted in increasing order.  
files = extract_file_name(path_to_record);

% execute_all is a variable used to iterate the algorithm on all signals  
% or just one of them.  
% execute_all == 1 -> Execute the algorithm on all records.  
% execute_all == 0 -> Apply the algorithm only to a specific signal (it must be  
%                     specified manually in the 'record_name' variable).  
execute_all = 1;

% Insert the name of the record here for a single execution.  
% Make sure that the file actually exists.  
record_name = '19';

% creation of a table if execution is iterated for all the signals
if execute_all == 1
    result_table = table('Size', [length(files), 8], ...
                     'VariableTypes', {'string', 'double', 'double', 'double', ...
                                       'double', 'double', 'string', 'string'}, ...
                     'VariableNames', {'Signal', 'Accuracy', 'Precision', 'Sensibility', ...
                                       'Specificity', 'Percentual_of_AF_in_the_signal', ...
                                       'Time_AF_events', 'Time_signal'});
end

% Iteration of the algorithm for all files in the path. 
for i = 1:length(files)
    
    if execute_all == 1
       record_name = char(files(i));
    end

    % Extraction of data from the signal  
    % signal     -> The signal itself.  
    % fs         -> Sampling frequency used.  
    % indices    -> Contains time values for rhythms.
    % annots_aux -> Contains annotations for each rhytms.  
    % r          -> RR-interval series of the signal.  
    % intervals  -> Number of intervals in the RR series.  
    [signal, fs, indices, annots_aux, r, intervals] = data_extraction(strcat('\', ...
        path_to_record, record_name));

    % -------------------  execution of the algorithm  ------------------ %

    % Application of 3-point median filter to the RR-interval series,
    % It removes ectopic beats and outlier intervals.
    rm = median_filter(r);
    % Application of exponential averaging to the RR-interval series.  
    % It is also possible to use the forward_backward method, which can achieve  
    % a linear (null) phase, while exponential has a nonlinear phase.  
    % exp_average -> Method for classic exponential averaging, as described in the  
    % paper.  
    % forward_backward -> Method for exponential averaging implemented using the  
    % forward-backward technique.  
    %rt = exp_average(r, alpha);
    rt = forward_backward(r, alpha);
    % Detection of interval irregularity using the filtered series rt.  
    % This series contains the interval irregularity detected by the  
    % algorithm, using a sliding window of size N.  
    It = rr_interval_irregularity(rm, alpha, gamma, rt, intervals, N);
    % Suppression of bigeminy events using filtered series rm.
    Bt = bigeminy_suppression(alpha, r, rm, N, intervals);
    % Merge of It and Bt.
    % O is the final series that will be used for predictions.
    O = merge(It, Bt, delta);
    % Computation of predictions.
    prediction = O > threshold;

    % Build arrays to measure the performance of the algorithm.  
    % RR_groundtruth -> Array where AF heartbeats from annotations are  
    % stored.  
    % signal_groundtruth -> Ground truth of the original signal, used to  
    % compute the effective time of AF.  
    % AF_found -> Number of AF events found.  
    % AF_events -> Number of heartbeats in AF.  
    [RR_groundtruth, signal_groundtruth, AF_events] = annotations_events( ...
        annots_aux, indices, signal, intervals);
    
    % Computation of confusion matrix.
    [TP, FP, FN, TN] = confusion_matrix(RR_groundtruth, prediction);

    % Evalutations of accuracy, precision, sensibility, specificity.
    [accuracy, precision, sensibility, specificity] = performance_evaluation(TP, ...
                                                       FP, FN, TN);
    % Percentual of AF events in comparison to the duration of the signal.
    percentual_of_AF = ((nnz(signal_groundtruth(:)==1)/fs)/(length(signal)/fs))*100;
    % Duration time of recording and atrial fibrillation events.
    [time_recording, time_AF_events] = time_calculator(signal, fs, signal_groundtruth);

    % Print results
    fprintf('============================================================\n');
    fprintf('Signal: %s\n', record_name);
    fprintf('Accuracy: %.2f\n', round(accuracy*100, 2));
    fprintf('Precision: %.2f\n', round(precision*100, 2));
    fprintf('Sensibility: %.2f\n', round(sensibility*100, 2));
    fprintf('Specificity: %.2f\n', round(specificity*100, 2));
    fprintf('Time recording: %s\n', time_recording);
    fprintf('Time AF events: %s\n', time_AF_events);
    fprintf('Percentual of AF in the signal: %.2f\n', round(percentual_of_AF, 2));

    if execute_all == 0
        if plot_final_merge == 1
            plot_results.final_merge_threshold(O, threshold);
        end
        
        if plot_comp_irr_bigeminy == 1
            plot_results.comp_series_bigeminy(Bt, It, r);
        end

        if plot_groundtruth == 1
            plot_results.comp_found_groundtruth(RR_groundtruth, prediction);
        end
    end
    
    % if execute_all == 0, exit the cycle.
    if execute_all == 0
        break;
    % else, write results on result_table.
    else
        result_table.Signal(i) = files(i);
        result_table.Accuracy(i) = round(accuracy*100, 2);
        result_table.Precision(i) = round(precision*100, 2);
        result_table.Sensibility(i) = round(sensibility*100, 2);
        result_table.Specificity(i) = round(specificity*100, 2);
        result_table.Percentual_of_AF_in_the_signal(i) = round(percentual_of_AF, 2);
        result_table.Time_AF_events(i) = time_AF_events;
        result_table.Time_signal(i) = time_recording;
    end
end

% write all results on "results.xlsx' file.
if execute_all == 1
    writetable(result_table, 'results.xlsx');
end