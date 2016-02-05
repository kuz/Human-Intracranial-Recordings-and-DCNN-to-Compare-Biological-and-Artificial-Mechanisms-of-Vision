%
% Plot probes with colors based on the assigned layer
%


%% Imports
addpath('lib/mni2name')


%% Parameters
featureset = 'meangamma_ventral_w250_10hz';
talareich_level = 5;


%% List of subject for whom we have the mapping
listing = dir(['../../Data/Intracranial/Processed/' featureset '/*.mat']);


%% 

% for each subject
stim_x_el = [];
labels = {};
for fid = 1:length(listing)
    [pathstr, subject, ext] = fileparts(listing(fid).name);
    
    % display progress
    disp(['Processing ' num2str(fid) '/' num2str(length(listing)) ': ' subject '...'])
    
    % load the data
    load(['../../Data/Intracranial/Processed/' featureset '/' subject '.mat'])
    
    % append data to result matrix
    stim_x_el = [stim_x_el s.data];
    
    % labels A: subject names
    %labels = [labels repmat({subject}, 1, size(s.data, 2))];
    
    % labels B: area name
    s.probes.mni(isnan(s.probes.mni)) = 0;
    [~, areas] = mni2name(s.probes.mni);
    labels = [labels areas(:, talareich_level)'];
    
    
    % clear workspace
    clearvars -except listing featureset stim_x_el labels talareich_level
    
end


%% Store the data
filename = ['../../Outcome/Biclustering matrix/' featureset '.csv'];
fid = fopen(filename, 'w');
fprintf(fid, [strjoin(labels, ',') '\n']);
fclose(fid);
dlmwrite(filename, stim_x_el, '-append', 'precision', '%.6f', 'delimiter', ',');