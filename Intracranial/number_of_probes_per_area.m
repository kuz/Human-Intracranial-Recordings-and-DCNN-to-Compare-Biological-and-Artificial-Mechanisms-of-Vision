%
% Take only electrodes along ventral stream
%

% imports
addpath('lib/mni2name');
addpath('lib/nifti');

% parameters
indata = 'LFP_bipolar_noscram';
%talareich_level = 5;
%db = load_nii('lib/mni2name/brodmann.nii');
db = load_nii('lib/mni2name/aicha.nii');
labels = load('lib/mni2name/aicha.labels.mat');

% load subject list
listing = dir(['../../Data/Intracranial/Processed/' indata '/*.mat']);
counts = containers.Map();

% process file-by-file
for sfile = listing'
    disp(['Processing ' sfile.name ' '])
    
    % load the data
    load(['../../Data/Intracranial/Processed/' indata '/' sfile.name]);
    
    s.probes.mni(isnan(s.probes.mni)) = 0;
    %[~, areas] = mni2name(s.probes.mni);
    %[~, areas] = mni2name_brodmann(s.probes.mni, db);
    [~, areas] = mni2name_aicha(s.probes.mni, db);
    
    % count number of times each area appears
    %for i = 1:size(areas, 1)
    for i = 1:length(areas)
        %key = areas{i, talareich_level};
        %key = num2str(areas{i});
        
        if areas{i} == 0
            key = '0';
        else
            key = labels.aicha{areas{i}, 2};
        end
        
        if ~isKey(counts, key)
            counts(key) = 1;
        else
            counts(key) = counts(key) + 1;
        end  
    end
    
    % drop all variables which are relevant to this subject
    clearvars -except listing talareich_level counts indata db labels
    
end

fprintf('Area\tCount\n')
fprintf('----\t-----\n')
for k = counts.keys()
    fprintf('%d\t%s\n', counts(k{1}), k{1})
end