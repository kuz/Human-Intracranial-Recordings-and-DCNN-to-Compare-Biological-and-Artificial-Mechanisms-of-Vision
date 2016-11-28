% variables
er = exist('range') == 1;
en = exist('bandname') == 1;
ef = exist('freqlimits') == 1;
eb = exist('bins') == 1;
ec = exist('ncycles') == 1;
if er + en + ef + eb + ec ~= 5
    disp('Required varibles are not set! Please check that you have specified range, bandname, freqlimits, ncycles and bins. Terminating')
    exit
end

% parameters
indata = 'LFP_bipolar_noscram_artif_responsive';
outdata = ['mean' bandname '_bipolar_noscram_artif_responsive'];
if exist(['../../../Data/Intracranial/Processed/' outdata], 'dir') == 7
    disp(['Directory exists: ' outdata ', exiting...'])
    exit()
end
mkdir(['../../../Data/Intracranial/Processed/' outdata])

% load third party code
addpath('../lib/spectra')

% load subject list
listing = dir(['../../../Data/Intracranial/Processed/' indata '/*.mat']);
listing = listing(range);

% for each subject
for sfile = listing'

    disp(['Processing ' sfile.name ' '])
    
    % load the data
    load(['../../../Data/Intracranial/Processed/' indata '/' sfile.name]);
    
    % output data structure
    meanband = zeros(length(s.stimseq), length(s.probes.probe_ids));
    
    % for each stimulus
    nstim = length(s.stimseq);
    for stimulus = 1:length(s.stimseq)
    
        % display progress
        fprintf('\r%d / %d', stimulus, nstim);
        
        % for each probe
        for probe = 1:length(s.probes.probe_ids)
    
            % take the signal
            signal = detrend(squeeze(s.data(stimulus, probe, :)));
            
            % to do artifact rejection we have dropped some number of
            % images from each of the probes, now each proble has varying
            % number of "trials" (images), to keep the data in matrix
            % format we inroduce a "poison pill" value of -123456 -- the
            % images with this values as a response should be excluded
            % from further analysis
            if sum(signal) == 0.0
                meanband(stimulus, probe) = -123456;
                continue
            end
            
            % filter the signal
            for f = [50, 100, 150, 200, 250]
                Wo = f / (512 / 2);
                BW = Wo / 50;
                [b,a] = iirnotch(Wo, BW); 
                signal = filter(b, a, signal);
            end
            
            % wavelet transform
            [power, faxis, times, period] = waveletspectrogram(signal', 512, 'freqlimits', freqlimits, 'ncycles', ncycles);

            % take baseline for later normalization
            baseline_at = 205; % baseline from -500 to -100
            baseline = power(:, 1:baseline_at);

            % take only part of the signal
            stimulus_at = 256;
            from = stimulus_at + 26;   % 50 ms
            till = stimulus_at + 128;  % 250 ms
            %from = stimulus_at + 79; % 150ms
            %till = stimulus_at + 205; % 400ms 
            fqsignal = power(:, from:till);

            % normalization A: whole band average / whole band baseline average
            %meanband(stimulus, probe) = mean2(fqsignal) / mean2(baseline);

            % normalization B: 10 hz bins, divide, average
            ratios = [];
            binshift = bins(1, 1) - 1;
            for bid = 1:size(bins, 1)
                lhz = bins(bid, 1) - binshift;
                hhz = bins(bid, 2) - binshift;
                binbaseline = baseline(lhz:hhz, :);
                binsignal = fqsignal(lhz:hhz, :);
                ratios = [ratios, mean2(binsignal) / mean2(binbaseline)];
            end
            meanband(stimulus, probe) = max(ratios);
            
        end
    end
    
    % store extracted features
    s.data = meanband;
    save(['../../../Data/Intracranial/Processed/' outdata '/' sfile.name], 's');
    
    % clear all subject-specific variables
    clearvars -except listing indata outdata freqlimits bins
    fprintf('\n')

end


