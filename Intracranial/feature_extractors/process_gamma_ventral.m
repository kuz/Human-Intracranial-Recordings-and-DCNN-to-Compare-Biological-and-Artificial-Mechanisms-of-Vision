%
% Take all subjects from the Processed/LFP direectory and extract features
% over high gamma (70-150 Hz) band for each (subject, stimulus, probe) triple
%

% load third party code
addpath('../lib/spectra')

% load subject list
listing = dir('../../../Data/Intracranial/Processed/gamma_ventral/*.mat');

% for each subject
for sfile = listing'

    disp(['Processing ' sfile.name ' '])
    
    % load the data
    load(['../../../Data/Intracranial/Processed/gamma_ventral/' sfile.name]);

    % output data structure
    meangamma = zeros(length(s.stimseq), length(s.probes.probe_ids));
    
    % for each stimulus
    for stimulus = 1:length(s.stimseq)
    
        % display progress
        fprintf('\r%d / 319', stimulus);
        
        % for each probe
        for probe = 1:length(s.probes.probe_ids)
   
            % take the signal
            power = s.data(stimulus, probe, :, :);
            stimulus_at = 256;            

            % take baseline for later normalization
            baseline_at = 205; % baseline from -500 to -100
            baseline = power(:, 1:baseline_at);
            
            % take only part of the signal
            from = stimulus_at + 26;   % 50 ms
            till = stimulus_at + 128;  % 250 ms
            fqsignal = power(:, from:till);
            
            % normalization A: whole band average / whole band baseline average
            meangamma(stimulus, probe) = mean2(fqsignal) / mean2(baseline);
            
        end
    end
    
    % store extracted features
    s.data = meangamma;
    save(['../../../Data/Intracranial/Processed/meangamma_ventral_w500_onebin/' sfile.name], 's');
    
    % clear all subject-specific variables
    clearvars -except listing
    fprintf('\n')

end


