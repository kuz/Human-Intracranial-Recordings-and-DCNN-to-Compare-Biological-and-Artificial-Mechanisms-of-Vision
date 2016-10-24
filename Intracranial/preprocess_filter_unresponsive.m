% includes
addpath('lib')

% parameters
indata  = 'meangamma_bipolar_noscram_artif_brodmann';
outdata = 'meangamma_bipolar_noscram_artif_brodmann_resppositive';

% load data
results = load('../../Outcome/Probe responsiveness/LFP_bipolar_noscram_artif_responsive0001.mat');
results = results.results;
listing = dir(['../../Data/Intracranial/Processed/' indata '/*.mat']);

% drop the probe with not-higher-than-baseline response and the probe with unsignificant response
pID = fdr(results(:, 3), 0.05);
disp(['pID = ' num2str(pID)])
results(:, 4) = results(:, 5) >= results(:, 6) | results(:, 3) >= pID;

% drop all of the probes marked for dropping
for si = 1:length(listing)
    sfile = listing(si);
    disp(['Cleaning ' sfile.name ': dropping ' ...
          num2str(length(results(results(:, 1) == si & results(:, 4) == 1, 2))) ...
          ' (out of ' num2str(length(results(results(:, 1) == si))) ') probes'])
    
    % load the data
    load(['../../Data/Intracranial/Processed/' indata '/' sfile.name]);
    
    % drop discarded probes
    keepidx = results(results(:, 1) == si & results(:, 4) == 0, 2);
    s.probes.rod_names = s.probes.rod_names(keepidx);
    s.probes.probe_ids = s.probes.probe_ids(keepidx);
    s.probes.mni = s.probes.mni(keepidx, :);
    s.data = s.data(:, keepidx, :);
    
    % store the data
    save(['../../Data/Intracranial/Processed/' outdata '/' sfile.name], 's');
    clearvars -except range freqlimits indata outdata listing results
    
end


    
    
