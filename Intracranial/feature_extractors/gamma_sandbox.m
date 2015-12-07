%
% Take all subjects from the Processed/LFP direectory and extract average
% over high gamma (70-150 Hz) band for each (subject, stimulus, probe)
% triple
%

%% Prepare the data

% data source
source = 'LFP'

% load third party code
addpath('../lib/spectra')

% load subject list
listing = dir(['../../../Data/Intracranial/Processed/' source '/*.mat']);
sfile = listing(1);
disp(['Processing ' sfile.name])
    
% load the data
load(['../../../Data/Intracranial/Processed/' source '/' sfile.name]);

%% Take raw data

% for each stimulus
stimulus = 122;  % 122 -- Animal with good gamma

% for each probe
probe = 44;
    
% take the signal
signal = detrend(squeeze(s.data(stimulus, probe, :)));
plot(signal)

%% Filter
for f = [50, 100, 150, 200, 250]
    Wo = f / (512 / 2);
    BW = Wo / 50;
    [b,a] = iirnotch(Wo, BW); 
    signal = filter(b, a, signal);
end
plot(signal)

%% Wavelets
[power, faxis, times, period] = waveletspectrogram(signal', 512, 'freqlimits', [70 150]);

baseline_at = 256;
baseline = power(:, 1:baseline_at);
normalized = power(:, baseline_at:end);

means = mean(baseline, 2);
stds = std(baseline, 0, 2);
for f = 1:size(power, 1)
    normalized(f, :) = (normalized(f, :) - means(f)) / stds(f);
end

means = mean(baseline, 2);
stds = std(baseline, 0, 2);
for f = 1:size(power, 1)
    normalized_baseline(f, :) = (baseline(f, :) - means(f)) / stds(f);
end

% plot baseline normalized baseline
subplot(1, 2, 1)
imagesc(times(1:baseline_at), faxis, normalized_baseline(:,1:end))
set(gca,'Clim',[0 5])
colorbar
set(gca,'YDir','normal')
title('Baseline normalized baseline')

% plot baseline normalized signal
subplot(1, 2, 2)
imagesc(times(baseline_at:end), faxis, normalized(:,1:end))
set(gca,'Clim',[0 5])
colorbar
set(gca,'YDir','normal')
title('Baseline normalized signal')


%% FFT

% compute power specturum (Multitaper FFT)
[power, faxis, times] = spectrogramfn(signal', 150, 0.99, 2, 512);

% split into baseline and the main signal
baseline_at = max(find(times < 500));
baseline = power(:, 1:baseline_at);
normalized = power(:, baseline_at:end);

% normalize by baseline
means = mean(baseline, 2);
stds = std(baseline, 0, 2);
for f = 1:size(power, 1)
    normalized(f, :) = (normalized(f, :) - means(f)) / stds(f);
end

imagesc(times(baseline_at:end-50), faxis, normalized)
set(gca,'Clim',[0 10])
colorbar
set(gca,'YDir','normal')

%% Wavelets for all
stimidx = 1:size(s.stimgroups, 1);
stimidx = stimidx(s.stimgroups == 20);

%averaged = zeros(247, 801);
averaged = zeros(247, 1300);
for sid = stimidx
    disp(['Working on stimulus ' num2str(sid)])
    
    % take the signal
    signal = detrend(squeeze(s.data(sid, probe, :)));

    % perform the transofm
    [power, faxis, times, period] = waveletspectrogram(signal', 512, 'freqlimits', [0 250]);
    
    % add to the result
    averaged = averaged + log(power);
end

% take average
averaged = averaged ./ size(stimidx, 2);

% normalize by the baseline
baseline_at = 500;
baseline = averaged(:, 1:baseline_at);
normalized = averaged(:, baseline_at:end);
means = mean(baseline, 2);
stds = std(baseline, 0, 2);
for f = 1:size(averaged, 1)
    normalized(f, :) = (normalized(f, :) - means(f)) / stds(f);
end

imagesc(times(baseline_at:750), faxis, normalized(:,1:750))
colorbar
set(gca,'YDir','normal')

%% Jaan's code

% prepare data for FieldTrip
data.label = {'PROBE'};
data.fsample = 512;  % sampling frequency in Hz, single number
data.trial = {signal'};  % cell-array containing a data matrix for each trial (1 X Ntrial), each data matrix is    Nchan X Nsamples 
data.time = {0:(1/512):((size(signal, 1) - 1)/512)};  % cell-array containing a time axis for each trial (1 X Ntrial), each time axis is a 1 X Nsamples vector 

% frequncy transform configuration
cfg = [];
cfg.output     = 'pow';
cfg.foi        = 1:1:250;
cfg.method     = 'wltconvol';  
cfg.width      = 6; 
cfg.toi        = [0:0.005:1.5];
cfg.keeptrials = 'yes';

% perform the transform
freqs = ft_freqanalysis(cfg, data);

% take baseline
cfg = [];
cfg.xlim = [0.5 2.5];
cfg.baseline     = [0.0 0.4]; 
cfg.baselinetype = 'relative';
ft_singleplotTFR(cfg, freqs);


%% Sandbox
power = squeeze(freqs.powspctrm);

baseline_at = 100;
baseline = power(:, 1:baseline_at);
normalized = power(:, baseline_at:end);

means = mean(baseline, 2);
stds = std(baseline, 0, 2);
for f = 1:size(power, 1)
    normalized(f, :) = (normalized(f, :) - means(f)) / stds(f);
end

imagesc(times(baseline_at:end), faxis, normalized(:, 1:end))
set(gca,'YDir','normal')


