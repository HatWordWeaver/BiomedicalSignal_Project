function [files] = extract_file_name(dataset_path)
% EXTRACT_FILE_NAME  
% Function used to extract a list of file names, then sort them.  
%  
% The list of .atr files is extracted from the specified dataset path.  

files_list = dir(fullfile(dataset_path, '*.atr'));
fileNames = {files_list.name};
numbers = cellfun(@(x) str2double(x(1:end-4)), fileNames);
[~, idx] = sort(numbers);
files = fileNames(idx);
files = erase(files, '.atr');

end

