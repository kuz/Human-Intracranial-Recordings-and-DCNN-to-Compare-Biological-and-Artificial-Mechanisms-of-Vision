% WILL NOT DO FOR NOW

%
% Second tier of feature extraction: here we filter away electrodes we find
% not useful. This script is decoupled from the extraction script because
% we might want to keep original extracted data to apply different
% filterings onit.
%

% load subject list
listing = dir('../../../Data/Intracranial/Processed/meangamma/*.mat');

meangamma = csvread('../../../Outcome/Biclustering matrix/meangamma.csv', 1);

% process file-by-file
for sfile = listing'
    disp(['Processing ' sfile.name ' '])
    
    % load the data
    load(['../../../Data/Intracranial/Processed/meangamma/' sfile.name]);
    
    % drop "indifferent" electrode -- the ones which do not have any change
    % in gamma activity before and after the stimulus    
    mg = reshape(s.data, [1, numel(s.data)]);
    hist(mg)
    pause
    
end
