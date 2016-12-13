%
% Take only electrodes along ventral stream
%

% imports
addpath('lib/mni2name');
addpath('lib/nifti');

% parameters
indata = 'LFP_bipolar_noscram_artif_brodmann_alpha_resppositive';

% load atlas
db = load_nii('lib/mni2name/brodmann.nii');

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
    [~, areas] = mni2name_brodmann(s.probes.mni, db);
    nareas = length(areas);

    % count number of times each area appears
    for i = 1:nareas
        
        key = num2str(areas{i});

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
total = 0;
for k = counts.keys()
    fprintf('%s\t%d\n', k{1}, counts(k{1}))
    total = total + counts(k{1});
end
fprintf('Total\t%d\n', total)