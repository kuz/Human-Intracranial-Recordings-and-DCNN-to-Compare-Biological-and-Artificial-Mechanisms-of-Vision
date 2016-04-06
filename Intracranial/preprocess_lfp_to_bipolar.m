% parameters
indata = 'LFP_ventral';
outdata = 'bipolar_ventral';

% load subject list
listing = dir(['../../Data/Intracranial/Processed/' indata '/*.mat']);

% process file-by-file
for sfile = listing'
    disp(['Processing ' sfile.name ' '])
    
    % load the data
    load(['../../Data/Intracranial/Processed/' indata '/' sfile.name]);
    s.probes.mni(isnan(s.probes.mni)) = 0;
    if size(s.data, 2) == 0
        disp('... no probes found, saving as it is.')
        save(['../../Data/Intracranial/Processed/' outdata '/' sfile.name], 's');
        continue
    end

    % list of rodes
    rodes = unique(s.probes.rod_names);
    
    % bipolar referencing per rod
    drop_probes = [];
    for rod = rodes

        % extract probes located on this rod
        rod_probes_idx = strcmp(s.probes.rod_names, rod);
        rod_probes_idx = times(rod_probes_idx, 1:length(rod_probes_idx));
        rod_probes_idx = rod_probes_idx(rod_probes_idx > 0);

        % bipolar referencing, last probe is dropped
        for i = 1:length(rod_probes_idx)-1
            s.data(:, rod_probes_idx(i), :) = s.data(:, rod_probes_idx(i), :) - ...
                                              s.data(:, rod_probes_idx(i + 1), :);
        end
        drop_probes = [drop_probes, rod_probes_idx(end)];
    end

    
    % find probes to keep
    keepidx = setdiff(1:size(s.data, 2), drop_probes);

    % drop discarded probes
    s.probes.rod_names = s.probes.rod_names(keepidx);
    s.probes.probe_ids = s.probes.probe_ids(keepidx);
    s.probes.mni = s.probes.mni(keepidx, :);
    s.data = s.data(:, keepidx, :);

    % store the data
    save(['../../Data/Intracranial/Processed/' outdata '/' sfile.name], 's');
    
    % drop all variables which are relevant to this subject
    clearvars -except listing indata outdata
    
end
