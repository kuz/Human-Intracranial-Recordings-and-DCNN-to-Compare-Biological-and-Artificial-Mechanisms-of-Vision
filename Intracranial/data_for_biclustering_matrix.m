%
% Plot probes with colors based on the assigned layer
%


%% Imports
addpath('lib/mni2name')
addpath('lib/nifti')

%% Parameters
featureset = 'meangamma_400ms';
atlas = 'brodmann';

% load atlas
if strcmp(atlas, 'initial')
    talareich_level = 5;
elseif strcmp(atlas, 'brodmann')
    db = load_nii('lib/mni2name/brodmann.nii');
elseif strcmp(atlas, 'aicha')
    db = load_nii('lib/mni2name/aicha.nii');
    labels = load('lib/mni2name/aicha.labels.mat');
end


%% List of subject for whom we have the mapping
listing = dir(['../../Data/Intracranial/Processed/' featureset '/*.mat']);


%% 

% for each subject
stim_x_el = [];
labels = {};
subjects = {};
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
    if strcmp(atlas, 'initial')
        [~, areas] = mni2name(s.probes.mni);
        anames = areas(:, talareich_level);
    elseif strcmp(atlas, 'brodmann')
        [~, areas] = mni2name_brodmann(s.probes.mni, db);
        anames = areas;
    elseif strcmp(atlas, 'aicha')
        [~, areas] = mni2name_aicha(s.probes.mni, db);
        %anames = %TODO;
    end
    labels = [labels; anames'];
    subjects = [subjects; repmat({subject}, 1, size(areas, 2))'];
    
    % clear workspace
    clearvars -except listing featureset stim_x_el labels talareich_level subjects atlas db
    
end


%% Store the data
% first line  -- names of the subjects
% second line -- names of the areas
% the rest    -- data
%   columns   -- images
filename = ['../../Outcome/Biclustering matrix/' featureset '_' atlas '.csv'];
fid = fopen(filename, 'w');
fprintf(fid, [strjoin(subjects', ',') '\n']);
fprintf(fid, [strjoin(arrayfun(@(x) num2str(x{1}), labels, 'UniformOutput', false)', ',') '\n']);
fclose(fid);
dlmwrite(filename, stim_x_el, '-append', 'precision', '%.6f', 'delimiter', ',');
