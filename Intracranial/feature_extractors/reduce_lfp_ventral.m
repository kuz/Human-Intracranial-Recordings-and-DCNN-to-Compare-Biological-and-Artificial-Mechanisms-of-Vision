%
% Take only electrodes along ventral stream
%

% imports
addpath('../lib/mni2name')

% parameters
talareich_level = 5;
areas_of_interest = {'brodmann area 17', 'brodmann area 18', 'brodmann area 19', ...
                     'brodmann area 37', 'brodmann area 20', 'brodmann area 38', ...
                     'brodmann area 28', 'brodmann area 27', 'brodmann area 35'};

% load subject list
listing = dir('../../../Data/Intracranial/Processed/LFP/*.mat');

% process file-by-file
for sfile = listing'
    disp(['Processing ' sfile.name ' '])
    
    % load the data
    load(['../../../Data/Intracranial/Processed/LFP/' sfile.name]);
    
    s.probes.mni(isnan(s.probes.mni)) = 0;
    [~, areas] = mni2name(s.probes.mni);
    
    % find probes to keep
    keepidx = [];
    for i = 1:size(areas, 1)
        
        % keep only Brodmann areas 17, 18, 19, 37, 20, 38, 28, 27, 35
        if ~isempty(find(strcmp(areas_of_interest, areas{i, talareich_level})))
            keepidx = [keepidx, i];
        end  
    end
    
    % drop discarded probes
    s.probes.rod_names = s.probes.rod_names(keepidx);
    s.probes.probe_ids = s.probes.probe_ids(keepidx);
    s.probes.mni = s.probes.mni(keepidx, :);
    s.data = s.data(:, keepidx, :);
    
    % store the data
    save(['../../../Data/Intracranial/Processed/LFP_ventral/' sfile.name], 's');
    
    % drop all variables which are relevant to this subject
    clearvars -except listing talareich_level areas_of_interest
    
end
