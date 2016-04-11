%
% Take only electrodes along ventral stream
%

% parameters
indata = 'meangamma_ventral_w250_10hz';
outdata = 'meangamma_ventral_noscram';

% load subject list
listing = dir(['../../../Data/Intracranial/Processed/' indata '/*.mat']);

% process file-by-file
for sfile = listing'
    disp(['Processing ' sfile.name ' '])
    
    % load the data
    load(['../../../Data/Intracranial/Processed/' indata '/' sfile.name]);
    
    % find stimuli to drop
    dropidx = find(s.stimgroups == 90);
    
    % drop discarded stimuli
    s.stimseq(dropidx) = [];
    s.stimgroups(dropidx) = [];
    s.data(dropidx, :, :) = [];
    
    % store the data
    save(['../../../Data/Intracranial/Processed/' outdata '/' sfile.name], 's');
    
    % drop all variables which are relevant to this subject
    clearvars -except indata outdata listing
    
end
