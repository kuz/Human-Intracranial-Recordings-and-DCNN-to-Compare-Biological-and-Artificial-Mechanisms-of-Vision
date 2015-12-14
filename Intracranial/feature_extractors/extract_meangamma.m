%
% Take all subjects from the Processed/LFP direectory and extract average
% over high gamma (70-150 Hz) band for each (subject, stimulus, probe)
% triple
%

% load third party code
addpath('../lib/spectra')

% load subject list
listing = dir('../../../Data/Intracranial/Processed/LFP/*.mat');
listing = listing(range)

% for each subject
for sfile = listing'

    disp(['Processing ' sfile.name ' '])
    
    % load the data
    load(['../../../Data/Intracranial/Processed/LFP/' sfile.name]);
    
    % output data structure
    meangamma = zeros(length(s.stimseq), length(s.probes.probe_ids));
    
    % for each stimulus
    for stimulus = 1:length(s.stimseq)
    
        % display progress
        fprintf('\r%d / 319', stimulus);
        
        % for each probe
        for probe = 1:length(s.probes.probe_ids)
    
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
            [power, faxis, times, period] = waveletspectrogram(signal', 512, 'freqlimits', [70 150]);

            % take baseline for later normalization
            baseline_at = 256;
            baseline = power(:, 1:baseline_at);
            
            % take only part of the signal
            from = baseline_at + 51;  % 100 ms
            till = from + 205;  % 500 ms
            normalized = power(:, from:till);

            % perform normalization
            means = mean(baseline, 2);
            stds = std(baseline, 0, 2);
            for f = 1:size(power, 1)
                normalized(f, :) = (normalized(f, :) - means(f)) / stds(f);
            end
            
            % store result
            meangamma(stimulus, probe) = mean2(normalized);
            
        end
    end
    
    % store extracted features
    s.data = meangamma;
    save(['../../../Data/Intracranial/Processed/meangamma/' sfile.name], 's');
    
    % clear all subject-specific variables
    clearvars -except listing
    fprintf('\n')

end


