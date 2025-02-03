function [plotMethods] = plot_methods()
% PLOT_METHODS  
% Collection of methods to plot results obtained from the execution of the  
% algorithm.  
%  
% final_merge_threshold  
% Plots the resulting series O and the threshold value, visualizing  
% heartbeats that will be classified as part of AF.  
% 
% signal  
% Plots the original signal.  
%  
% comp_series_filt_median  
% Plots the resulting series with a 3-point median filter applied and the  
% original RR-series.  
%  
% comp_series_filt_averg  
% Plots the resulting series with an exponential average filter applied and  
% the original RR-series.  
%  
% comp_series_irreg_detect  
% Plots the series with RR irregularity detected and the original  
% RR-series.  
%  
% comp_found_groundtruth  
% Plots the ground truth table and the prediction made by the algorithm.  
%  
% comp_series_bigeminy  
% Plots the resulting series of bigeminy suppression, the series of  
% RR irregularity detection, and the original RR-series.  
%  
% heatmap  
% Plots the heatmap with four metrics used.  
%  
% mean_values  
% Plots the mean values obtained from the metrics.  

    plotMethods = struct();
    plotMethods.final_merge_threshold = @pfr;
    plotMethods.signal = @ps;
    plotMethods.comp_series_filt_median = @pcsfm;
    plotMethods.comp_series_filt_averg = @pcsfa;
    plotMethods.comp_series_irreg_detect = @pcsir;
    plotMethods.comp_found_groundtruth = @pcfg;
    plotMethods.comp_series_bigeminy = @pcsb;
    plotMethods.heatmap = @pheat;
    plotMethods.mean_values = @pmv;

    function pfr(O, threshold)
        figure;
        plot(O)
        hold on
        yline(threshold,'--', 'Threshold');
        title('Resulting series and threshold');
        ylabel('O(n)');
        set(gcf, 'Position', [100, 100, 1000, 500]);
        hold off
    end

    function pcsfm(r, rm)
        figure;
        plot(r)
        hold on
        plot(rm)
        legend('Original RR series', 'RR filtered');
        title('Original RR and RR filtered with 3-median point');
        set(gcf, 'Position', [100, 100, 1000, 500]);
        hold off
    end

    function pcsfa(r, rt)
        figure;
        plot(r)
        hold on
        plot(rt)
        legend('Original RR series', 'RR filtered');
        title('Original RR and RR filtered with forward-backward');
        set(gcf, 'Position', [100, 100, 1000, 500]);
        hold off
    end
   
    function pcsir(r, It)
        figure;
        plot(r)
        hold on
        plot(It)
        legend('Original RR series', 'RR irregularity detection');
        title('Detection of RR irregularity');
        set(gcf, 'Position', [100, 100, 1000, 500]);
        hold off
    end

    function pcfg(RR_groundtruth, prediction)
        figure;
        subplot(2, 1, 1);
        plot(RR_groundtruth);
        title('AF events in RR interval series');
        subplot(2, 1, 2);
        plot(prediction);
        title('AF events detected by the algorithm');
        set(gcf, 'Position', [100, 100, 1000, 500]);
    end

    function pcsb(Bt, It, r)
        figure;
        subplot(3, 1, 1);
        plot(Bt);
        title('Bigeminy Suppression');
        ylabel('Bt(n)');
        subplot(3, 1, 2);
        plot(r);
        title('Original RR-series');
        ylabel('r(n)');
        subplot(3, 1, 3);
        plot(It);
        title('RR-Irregularity detection');
        ylabel('It(n)');
        set(gcf, 'Position', [100, 100, 1000, 500]);
    end

    function ps(signal)
        plot(signal(:, 2));
    end

    function pheat(result_table)
        fileNames = result_table.Signal;
        metricNames = {'Precision', 'Accuracy', 'Sensibility', 'Specificity'}; 
        metrics = result_table{:, metricNames}; 
        figure;
        heatmap(metricNames, fileNames, metrics, ...
        'Colormap', jet, ...            
        'ColorbarVisible', 'on');       
        title('Heatmap of results');
        xlabel('Metrics');
        ylabel('File');
        set(gcf, 'Position', [50, 0, 1000, 900]);
    end

    function pmv(result_table)
        metrics = ["Accuracy" "Specificity" "Precision" "Sensitivity"];
        mean_metrics = [mean(result_table.Accuracy, 'omitnan'); mean(result_table.Specificity, 'omitnan'); mean(result_table.Precision, 'omitnan'); mean(result_table.Sensibility, 'omitnan')];
        figure;
        b = bar(metrics, mean_metrics, 'FaceColor', 'red');
        b.FaceColor = '#0072BD';
        ylabel('Performance');
        title('Mean of metrics');
        grid on;
        set(gcf, 'Position', [100, 100, 500, 500]);
    end
end

