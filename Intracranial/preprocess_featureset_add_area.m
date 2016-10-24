% paramters
indata = 'meangamma_bipolar_noscram_artif';
outdata = 'meangamma_bipolar_noscram_artif_brodmann';

% load libraries
addpath('lib/mni2name')
addpath('lib/nifti')
db = load_nii('lib/mni2name/brodmann.nii');

% load subject list
listing = dir(['../../Data/Intracranial/Processed/' indata '/*.mat']);

% for each subject
for si = 1:length(listing)
    sfile = listing(si);
    disp(['Processing ' sfile.name])
    
    % load the data
    load(['../../Data/Intracranial/Processed/' indata '/' sfile.name]);
    
    % assign areas
    [~, areas] = mni2name_brodmann(s.probes.mni, db);
    areas = cell2mat(areas)';
    s.probes.areas = areas;
    
    % store the data
    save(['../../Data/Intracranial/Processed/' outdata '/' sfile.name], 's');
    clearvars -except indata outdata db listing
end
