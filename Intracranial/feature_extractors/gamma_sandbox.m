%
% Take all subjects from the Processed/LFP direectory and extract average
% over high gamma (70-150 Hz) band for each (subject, stimulus, probe)
% triple
%

%% Prepare the data

% load third party code
addpath('../lib/spectra')

% load subject list
listing = dir('../../../Data/Intracranial/Processed/LFP/*.mat');
sfile = listing(7);
disp(['Processing ' sfile.name])
    
% load the data
load(['../../../Data/Intracranial/Processed/LFP/' sfile.name]);
    
% for each stimulus
stimulus = 112;

% for each probe
probe = 95;
    
% take the signal
signal = detrend(squeeze(s.data(stimulus, probe, :)));
plot(signal)

%% FFT

% compute power specturum (Multitaper FFT)
[power, faxis, times] = spectrogramfn(signal', 200, 0.99, 2, 512);
imagesc(times, faxis, log10(power))
set(gca,'YDir','normal')

% split into baseline and the main signal
baseline_at = max(find(times < 400));
baseline = power(:, 1:baseline_at);
normalized = power(:, baseline_at:end);

imagesc(times(baseline_at:end), faxis, log10(normalized))
set(gca,'YDir','normal')

% normalize by baseline
means = mean(baseline, 2);
stds = std(baseline, 0, 2);
for f = 1:size(power, 1)
    normalized(f, :) = (normalized(f, :) - means(f)) / stds(f);
end

imagesc(times(baseline_at:end), faxis, normalized)
set(gca,'YDir','normal')


%% Wavelets
[power, faxis, times, period] = waveletspectrogram(signal', 512, 'freqlimits', [0 250]);
imagesc(times, faxis, log10(power))
set(gca,'YDir','normal')

baseline_at = 400;
baseline = power(:, 1:baseline_at);
normalized = power(:, baseline_at:end);

means = mean(baseline, 2);
stds = std(baseline, 0, 2);
for f = 1:size(power, 1)
    normalized(f, :) = (normalized(f, :) - means(f)) / stds(f);
end

imagesc(times(baseline_at:end), faxis, normalized)
set(gca,'YDir','normal')
