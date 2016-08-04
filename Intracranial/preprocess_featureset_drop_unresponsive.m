% variables
er = exist('range') == 1;
ef = exist('freqlimits') == 1;
if er + ef ~= 2
    disp('Required varibles are not set! Please check that you have specified range, freqlimits. Terminating')
    exit
end

% paramters
indata = 'LFP_bipolar_noscram_artif';
outdata = 'LFP_biploar_noscram_artif_responsive';

% load third party code
addpath('lib')
addpath('lib/spectra')

% load subject list
listing = dir(['../../Data/Intracranial/Processed/' indata '/*.mat']);
listing = listing(range);

% matrix to store the final results
results = zeros(0, 4);

% for each subject
for si = 1:length(listing)
    sfile = listing(si);
    disp(['Processing ' sfile.name])
    
    % load the data
    load(['../../Data/Intracranial/Processed/' indata '/' sfile.name]);
    
    % for each probe
    nprobes = length(s.probes.probe_ids);
    for probe = 1:nprobes
        
        % display progress
        fprintf('\r%d / %d', probe, nprobes);
        
        nstim = length(s.stimseq);
        baseline_band_means = zeros(1, nstim);
        fqsignal_band_means = zeros(1, nstim);
        
        % for each stimulus
        for stimulus = 1:length(s.stimseq)
            
            % take the signal
            signal = detrend(squeeze(s.data(stimulus, probe, :)));
            
            % filter the signal
            for f = [50, 100, 150, 200, 250]
                Wo = f / (512 / 2);
                BW = Wo / 50;
                [b,a] = iirnotch(Wo, BW); 
                signal = filter(b, a, signal);
            end
            
            % wavelet transform
            [power, faxis, times, period] = waveletspectrogram(signal', 512, 'freqlimits', freqlimits);
            
            % take baseline for later normalization
            baseline_at = 205; % baseline from -500 to -100
            baseline = power(:, 1:baseline_at);

            % take only part of the signal
            stimulus_at = 256;
            from = stimulus_at + 26;   % 50 ms
            till = stimulus_at + 128;  % 250 ms
            fqsignal = power(:, from:till);
            
            % store frequency means
            baseline_band_means(stimulus) = mean2(baseline);
            fqsignal_band_means(stimulus) = mean2(fqsignal);
            
        end
        
        % test the null hypothesis that baseline = signal in band means
        p = signrank(baseline_band_means, fqsignal_band_means);
        results = [results; si, probe, p, 0];
        
    end 
    
    % clear all subject-specific variables
    clearvars -except range freqlimits indata outdata listing results
    fprintf('\n');
    
end

% decide which probes will be dropper
pID = fdr(results(:, 3), 0.05);
results(:, 4) = results(:, 3) >= pID;

% drop all of the probes marked for dropping
for si = 1:length(listing)
    sfile = listing(si);
    disp(['Cleaning ' sfile.name])
    
    % load the data
    load(['../../Data/Intracranial/Processed/' indata '/' sfile.name]);
    
    % drop discarded probes
    keepidx = results(results(:, 1) == si & results(:, 4) == 0, 2);
    s.probes.rod_names = s.probes.rod_names(keepidx);
    s.probes.probe_ids = s.probes.probe_ids(keepidx);
    s.probes.mni = s.probes.mni(keepidx, :);
    s.data = s.data(:, keepidx);
    
    % store the data
    save(['../../Data/Intracranial/Processed/' outdata '/' sfile.name], 's');
    clearvars -except range freqlimits indata outdata listing results
    
end


    
    
