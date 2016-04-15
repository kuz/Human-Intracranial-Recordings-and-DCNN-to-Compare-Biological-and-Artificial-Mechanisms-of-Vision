% paramters
indata = 'LFP_bipolar_noscram_ventral';
outdata = '';

% load subject list
listing = dir(['../../Data/Intracranial/Processed/' indata '/*.mat']);
total_recs = 0;
buggy_recs = 0;

% process file-by-file
for sfile = listing'
    disp(['Processing ' sfile.name ' '])
    
    % load the data
    load(['../../Data/Intracranial/Processed/' indata '/' sfile.name]);
    s.probes.mni(isnan(s.probes.mni)) = 0;

    % store the data
    %save(['../../../Data/Intracranial/Processed/biploar_ventral/' sfile.name], 's');

    % for each electrode and stimulus take mean and std of the signal and then take
    % mean over stimuli, by doing that we obtain mean mean and mean std for each probe
    mus = mean(s.data, 3);
    stds = std(s.data, 0, 3);
    avg_mus = mean(mus, 1);
    avg_stds = mean(stds, 1);

    % for each probe count number of abnormal recordings
    %drop_probes = [];
    for i = 1:size(mus, 2)
        bad_trials = sum(abs(mus(:, i) - avg_mus(i)) / avg_stds(i) > 3);
        if bad_trials > 0
            disp(bad_trials)
        end
        %total_recs = total_recs + size(mus, 1);
        %buggy_recs = buggy_recs + sum(abs(mus(:, i) - avg_mus(i)) / avg_stds(i) > 3);
        %if abs(mus(:, i) - avg_mus(i)) / avg_stds(i) > 5
        %    %drop_probes = [drop_probes, i]
        %    buggy_recs = buggy_recs + 1;
        %end 
    end
    %disp(length(drop_probes))
    %disp(total_recs)
    %disp(buggy_recs)

    % drop all variables which are relevant to this subject
    clearvars -except listing indata outdata total_recs buggy_recs
    
end
