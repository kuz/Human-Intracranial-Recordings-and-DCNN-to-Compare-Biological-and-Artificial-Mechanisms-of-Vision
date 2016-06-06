%
% Take only electrodes along ventral stream
%

% imports
addpath('lib/mni2name')

% parameters
indata = 'LFP_bipolar_noscram_ventral';
talareich_level = 5;

% load subject list
listing = dir(['../../Data/Intracranial/Processed/' indata '/*.mat']);
counts = containers.Map();

% process file-by-file
for sfile = listing'
    disp(['Processing ' sfile.name ' '])
    
    % load the data
    load(['../../Data/Intracranial/Processed/' indata '/' sfile.name]);
    
    s.probes.mni(isnan(s.probes.mni)) = 0;
    [~, areas] = mni2name(s.probes.mni);
    
    % count number of times each area appears
    for i = 1:size(areas, 1)
        if ~isKey(counts, areas{i, talareich_level})
            counts(areas{i, talareich_level}) = 1;
        else
            counts(areas{i, talareich_level}) = counts(areas{i, talareich_level}) + 1;
        end  
    end
    
    % drop all variables which are relevant to this subject
    clearvars -except listing talareich_level counts indata
    
end
