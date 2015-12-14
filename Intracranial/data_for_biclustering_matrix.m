%
% Plot probes with colors based on the assigned layer
%


%% Parameters
featureset = 'meangamma';


%% List of subject for whom we have the mapping
listing = dir(['../../Data/Intracranial/Processed/' featureset '/*.mat']);


%% 

% for each subject
stim_x_el = [];
subjects = {};
for fid = 1:length(listing)
    [pathstr, name, ext] = fileparts(listing(fid).name);
    subject = name;
    
    % display progress
    disp(['Processing ' num2str(fid) '/' num2str(length(listing)) ': ' subject '...'])
    
    % load the data
    load(['../../Data/Intracranial/Processed/' featureset '/' subject '.mat'])
    
    % append data to result matrix
    stim_x_el = [stim_x_el s.data];
    subjects = [subjects repmat({subject}, 1, size(s.data, 2))];
    
    % clear workspace
    clearvars -except listing featureset stim_x_el subjects
    
end


%% Store the data
filename = ['../../Outcome/Biclustering matrix/' featureset '.csv'];
fid = fopen(filename, 'w');
fprintf(fid, [strjoin(subjects, '\t') '\n']);
fclose(fid);
dlmwrite(filename, stim_x_el, '-append', 'precision', '%.6f', 'delimiter', ',');