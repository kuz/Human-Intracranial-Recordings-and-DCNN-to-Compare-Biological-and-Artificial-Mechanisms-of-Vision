% includes
addpath('lib')

% parameters
e1 = exist('indata') == 1;
e2 = exist('bandname') == 1;
if e1 + e2 ~= 2
    disp('Required varibles are not set! Terminating.')
    exit
end

% output directory
outdata = [indata '_' bandname '_resppositive'];
if exist(['../../Data/Intracranial/Processed/' outdata], 'dir') == 7
    disp(['Directory exists: ' outdata ', exiting...']);
    exit()
end
mkdir(['../../Data/Intracranial/Processed/' outdata]);


% load data
results = zeros(0, 6);
results_listing = dir(['../../Outcome/Probe responsiveness/' indata '_' bandname '_responsive_*.mat']);
for rli = 1:length(results_listing)
    responses = load(['../../Outcome/Probe responsiveness/' results_listing(rli).name]);
    results = [results; responses.results];
end

listing = dir(['../../Data/Intracranial/Processed/' indata '/*.mat']);

% drop the probe with not-higher-than-baseline response and the probe with unsignificant response
pID = fdr(results(:, 3), 0.05);
disp(['pID = ' num2str(pID)])
results(:, 4) = results(:, 5) >= results(:, 6) | results(:, 3) >= pID;

% drop all of the probes marked for dropping
nsurvivors = 0;
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
    s.probes.areas = s.probes.areas(keepidx);
    s.data = s.data(:, keepidx, :);
    nsurvivors = nsurvivors + length(keepidx);

    % store the data
    save(['../../Data/Intracranial/Processed/' outdata '/' sfile.name], 's');
    clearvars -except range freqlimits indata outdata listing results nsurvivors
    
end

disp(['In total survived ' num2str(nsurvivors) ' probes'])
