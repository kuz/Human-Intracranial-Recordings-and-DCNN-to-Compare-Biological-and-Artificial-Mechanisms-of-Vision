% paramters
indata = 'LFP_bipolar_noscram_ventral';
outdata = 'LFP_bipolar_noscram_ventral_artif';
threshold = 10.0;

% load subject list
listing = dir(['../../Data/Intracranial/Processed/' indata '/*.mat']);
affected_trials = 0;
total_trials = 0;
drop_probes = 0;
total_probes = 0;

% process file-by-file
for sfile = listing'
    disp(['Processing ' sfile.name ' '])
    
    % load the data
    load(['../../Data/Intracranial/Processed/' indata '/' sfile.name]);

    % detrend
    for si = 1:size(s.data, 1)
        for pi = 1:size(s.data, 2)
            s.data(si, pi, :) = detrend(squeeze(s.data(si, pi, :)));
        end
    end
    
    %mus = mean(s.data, 3);
    stds = std(s.data, 0, 3);
    maxs = max(s.data, [], 3);
    avg_stds = mean(stds, 1);
    
    %
    % This chunk of code detects and drops individual "trials", this will
    % result in different number of trials per probe, but that is probably
    % ok
    %
    for i = 1:size(stds, 2)
        bad_trials = maxs(:, i) > avg_stds(i) * threshold;
        s.data(bad_trials, i, :) = repmat(0, size(s.data(bad_trials, i, :)));
    end
    
    %
    % The following chunk of code covers the case when we drop the whole
    % probes if som % of its recordings have artifacts
    %
    
    %total_trials = total_trials + size(stds, 1);
    %total_probes = total_probes + size(stds, 2);
    %
    %for i = 1:size(stds, 2)
    %    bad_trials = sum(maxs(:, i) > avg_stds(i) * threshold);
    %    affected_trials = affected_trials + bad_trials;
    %    if bad_trials > 0
    %        percent_bad = bad_trials / size(stds, 1) * 100;
    %        %disp(['Probe ' num2str(i) ': ' num2str(percent_bad)])
    %        if percent_bad > 20.0
    %            drop_probes = drop_probes + 1;
    %        end
    %    end
    %end
    
    % store the data
    save(['../../Data/Intracranial/Processed/' outdata '/' sfile.name], 's');
    
    % drop all variables which are relevant to this subject
    clearvars -except listing indata outdata affected_trials total_trials drop_probes total_probes threshold
    
end
