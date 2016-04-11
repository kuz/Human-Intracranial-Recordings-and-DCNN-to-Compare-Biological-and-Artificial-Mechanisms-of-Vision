%
% Take all subjects from the Processed/LFP direectory and extract features
% over high gamma (70-150 Hz) band for each (subject, stimulus, probe) triple
%

% parameters
indata = 'LFP_ventral_noscram'
outdata = 'gamma_ventral_noscram'

% load third party code
addpath('../lib/spectra')

% load subject list
listing = dir(['../../../Data/Intracranial/Processed/' indata '/*.mat']);
listing = listing(range)

% for each subject
for sfile = listing'

    disp(['Processing ' sfile.name ' '])
    
    % load the data
    load(['../../../Data/Intracranial/Processed/' indata '/' sfile.name]);
    
    % output data structure
    gamma = single(zeros(length(s.stimseq), length(s.probes.probe_ids), 81, 768));
    
    % for each stimulus
    nstim = length(s.stimseq);
    for stimulus = 1:length(s.stimseq)
    
        % display progress
        fprintf('\r%d / %d', stimulus, nstim);
        
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
            gamma(stimulus, probe, :, :) = power;
            
        end
    end
    
    % store extracted features
    s.data = gamma;
    save(['../../../Data/Intracranial/Processed/' outdata '/' sfile.name], 's', '-v7.3');
    
    % clear all subject-specific variables
    clearvars -except listing indata outdata
    fprintf('\n')

end


