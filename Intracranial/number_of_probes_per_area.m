%
% Take only electrodes along ventral stream
%

% imports
addpath('lib/mni2name');
addpath('lib/nifti');

% parameters
indata = 'LFP_bipolar_noscram';
atlas = 'aicha';  % initial, brodmann, aicha

% load atlas
if atlas == 'initial'
    talareich_level = 5;
elseif atlas == 'brodmann'
    db = load_nii('lib/mni2name/brodmann.nii');
elseif atlas == 'aicha'
    db = load_nii('lib/mni2name/aicha.nii');
    labels = load('lib/mni2name/aicha.labels.mat');
end

% load subject list
listing = dir(['../../Data/Intracranial/Processed/' indata '/*.mat']);
counts = containers.Map();

% process file-by-file
for sfile = listing'
    disp(['Processing ' sfile.name ' '])
    
    % load the data
    load(['../../Data/Intracranial/Processed/' indata '/' sfile.name]);
    
    s.probes.mni(isnan(s.probes.mni)) = 0;
    
    % use atlas to map probes to areas
    if atlas == 'initial'
        [~, areas] = mni2name(s.probes.mni);
        nareas = size(areas, 1);
    elseif atlas == 'brodmann'
        [~, areas] = mni2name_brodmann(s.probes.mni, db);
        nareas = length(areas);
    elseif atlas == 'aicha'
        [~, areas] = mni2name_aicha(s.probes.mni, db);
        nareas = length(areas);
    end
    
    % count number of times each area appears
    for i = 1:nareas
        
        % pick contrainer key depending on the atlas in use
        if atlas == 'initial'
            key = areas{i, talareich_level};
        elseif atlas == 'brodmann'
            key = num2str(areas{i});
        elseif atlas == 'aicha'
            if areas{i} == 0
                key = '0';
            else
                key = labels.aicha{areas{i}, 2};
            end
        end
        
        % counting happens here
        if ~isKey(counts, key)
            counts(key) = 1;
        else
            counts(key) = counts(key) + 1;
        end  
    end
    
    % drop all variables which are relevant to this subject
    clearvars -except listing talareich_level counts indata db labels
    
end

% output results
fprintf('Area\tCount\n')
fprintf('----\t-----\n')
for k = counts.keys()
    fprintf('%d\t%s\n', counts(k{1}), k{1})
end