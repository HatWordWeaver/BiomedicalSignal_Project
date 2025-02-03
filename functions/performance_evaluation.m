function [accuracy, precision, sensibility, specificity] = performance_evaluation(TP, FP, FN, TN)

%   PERFORMANCE_EVALUATION
%   Function used to compute metrics about performances of the algorithm, 
%   in particular: accuracy, precision, sensibility and specificity
%   

accuracy = (TP + TN) / (TP + TN + FP + FN);
precision = TP / (TP + FP);
sensibility = TP / (TP + FN);
specificity = TN / (TN + FP);

end

