% Supporting Python code
%
% import cPickle
% import numpy as np 
% with open('rsa_meanalpha_LFP_bipolar_noscram_artif_brodmann_w50_alpha_resppositive.euclidean.matrix_pvals.pkl', 'rb') as infile:
%    pvals = cPickle.load(infile)
% np.where(np.sum(pvals['LYONNEURO_2014_BLAP'] < 0.001, axis = 1))[0] + 1
%

% parameters
%sname = 'RG_13AVR10G';         sig_pids = [5, 8];
%sname = 'EG_16AVR12G';         sig_pids = [4, 5, 9];
sname = 'LYONNEURO_2014_BLAP'; sig_pids = [ 5, 14, 18, 20];
%sname = 'NR_21JUN11G';         sig_pids = [ 9, 12, 24, 27, 28];
%sname = 'LYONNEURO_2014_TAMN'; sig_pids = [1, 4];

% load data
s_sig = load(['meanalpha_LFP_bipolar_noscram_artif_brodmann_w50_alpha_resppositive/' sname '.mat']);
s_lfp = load(['LFP_bipolar_noscram_artif_brodmann_81/' sname '.mat']);

if sname == 'LYONNEURO_2014_BLAP'
    s_lfp.s.probes.areas(39) = 20;
end

% identify significant probes in LFP data 
lfp_pids = [];
for sig_pid = sig_pids
    lfp_pids = [lfp_pids find(ismember(s_lfp.s.probes.mni, s_sig.s.probes.mni(sig_pid, :), 'rows'))];
end

% get list of significanly correlating probes by running the Python code
figure
plot_counter = 1;
for pid = lfp_pids
    subplot(length(sig_pids), 1, plot_counter);
    for cid = unique(s_sig.s.stimgroups)'
        signal = squeeze(mean(s_lfp.s.data(s_sig.s.stimgroups == cid, pid, :), 1));
        baseline = signal(205:256);
        corrected = signal - mean(baseline);
        plot(corrected(205:512));
        legend({'House', 'Face', 'Animal', 'Scene', 'Tool', 'Fruit'});
        hold all;
    end
    title(['probe ' num2str(pid) ' area ' num2str(s_lfp.s.probes.areas(pid))]);
    plot_counter = plot_counter + 1;
end

% save figure
drawnow;
r = 80;
set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0 0 500 length(sig_pids) * 300]/r);
print(gcf, '-dpng', ['/Users/kuz/Research/Intracranial and DNN/Outcome/Significant LFP per Category/' sname '.png']);
