
%% Parameters
featureset = 'meangamma';


%% List of subject for whom we have the mapping
listing = dir(['../../Data/Intracranial/Probe_to_Layer_Maps/' featureset '/*.txt'])


%% Collect distance and layer mapping data
mni_distances = [];
layer_distances = [];

% for each subject
for fid = 1:length(listing)
    [pathstr, name, ext] = fileparts(listing(fid).name);
    subject = name;
    
    % display progress
    disp(['Processing ' num2str(fid) '/' num2str(length(listing)) ': ' subject '...'])
    
    % load the data
    load(['../../Data/Intracranial/Processed/' featureset '/' subject '.mat'])
    
    % load the mapping
    probe_to_layer_map = load(['../../Data/Intracranial/Probe_to_Layer_Maps/' ...
                               featureset '/' subject '.txt']);
    mapped_idx = find(probe_to_layer_map > 0);
    
    % extract MNI distance and absolute layer distance for each pair of
    % mapped probes
    for i = 1:length(mapped_idx)
        for j = (i + 1):length(mapped_idx)
            
            probe_i = mapped_idx(i);
            probe_j = mapped_idx(j);
            
            mni_d = sqrt(sum((s.probes.mni(probe_j, :) - s.probes.mni(probe_i, :)).^2));
            lay_d = abs(probe_to_layer_map(probe_i) - probe_to_layer_map(probe_j));
            
            mni_distances = [mni_distances mni_d];
            layer_distances = [layer_distances lay_d];
            
        end
    end
    
    % clear workspace
    clearvars -except featureset listing mni_distances layer_distances
    
end

%% Plot
scatter(mni_distances, layer_distances)
