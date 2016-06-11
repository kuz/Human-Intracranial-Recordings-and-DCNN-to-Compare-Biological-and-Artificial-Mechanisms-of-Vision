%
% Take only electrodes along ventral stream
%

% imports
addpath('../lib/mni2name')

% parameters
indata = 'LFP_bipolar_noscram_artif';
atlas = 'initial';
outdata = ['LFP_bipolar_noscram_artif_ventral_' atlas];
if exist(['../../../Data/Intracranial/Processed/' outdata], 'dir') == 7
    disp(['Directory exists: ' outdata ', exiting...'])
    exit()
end
mkdir(['../../../Data/Intracranial/Processed/' outdata])

% load atlas
if atlas == 'initial'
    talareich_level = 5;
    areas_of_interest = {'brodmann area 17', 'brodmann area 18', 'brodmann area 19', ...
                         'brodmann area 37', 'brodmann area 20', 'brodmann area 38', ...
                         'brodmann area 28', 'brodmann area 27', 'brodmann area 35'};
elseif atlas == 'brodmann'
    db = load_nii('lib/mni2name/brodmann.nii');
    areas_of_interest = {'17', '18', '19', '37', '20', '38', '28', '27', '35'};
elseif atlas == 'aicha'
    db = load_nii('lib/mni2name/aicha.nii');
    labels = load('lib/mni2name/aicha.labels.mat');
    areas_of_interest = {}; % TODO
end

% load subject list
listing = dir(['../../../Data/Intracranial/Processed/' indata '/*.mat']);

% process file-by-file
for sfile = listing'
    disp(['Processing ' sfile.name ' '])
    
    % load the data
    load(['../../../Data/Intracranial/Processed/' indata '/' sfile.name]);
    
    % use atlas to map probes to areas
    s.probes.mni(isnan(s.probes.mni)) = 0;
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
    
    % find probes to keep
    keepidx = [];
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
        
        % keep only Brodmann areas 17, 18, 19, 37, 20, 38, 28, 27, 35
        if ~isempty(find(strcmp(areas_of_interest, key)))
            keepidx = [keepidx, i];
        end  
    end
    
    % drop discarded probes
    s.probes.rod_names = s.probes.rod_names(keepidx);
    s.probes.probe_ids = s.probes.probe_ids(keepidx);
    s.probes.mni = s.probes.mni(keepidx, :);
    s.data = s.data(:, keepidx, :);
    
    % store the data
    save(['../../../Data/Intracranial/Processed/' outdata '/' sfile.name], 's');
    
    % drop all variables which are relevant to this subject
    clearvars -except listing talareich_level areas_of_interest indata outdata
    
end
