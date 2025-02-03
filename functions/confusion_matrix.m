function [TP, FP, FN, TN] = confusion_matrix(RR_GroundTruth, Predict)

% CONFUSION_MATRIX  
% Function used to compute the confusion matrix.

    TP = sum((RR_GroundTruth == 1) & (Predict == 1));
    FP = sum((RR_GroundTruth == 0) & (Predict == 1));
    FN = sum((RR_GroundTruth == 1) & (Predict == 0));
    TN = sum((RR_GroundTruth == 0) & (Predict == 0));

end

