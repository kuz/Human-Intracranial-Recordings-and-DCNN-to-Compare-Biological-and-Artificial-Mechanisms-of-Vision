import numpy as np
from scipy.stats import mannwhitneyu

OUTDIR = '../../Outcome'

bands = ['theta', 'alpha', 'beta', 'lowgamma', 'highgamma']
windows = [50, 150, 250]


regions_of_interest = []
for band in bands:
    for window in windows:
        regions_of_interest.append((band, window))


#
# Descriptive statistics on alignment
#
print '--- Alignments ---'
for region in regions_of_interest:
    alignments = np.loadtxt('%s/Noisy estimates/mean%s_LFP_5c_artif_bipolar_BA_w%s_%s_resppositive_alignments_with_alexnet.txt' % (OUTDIR, region[0], region[1], region[0]))
    print '%s %s: %.4f +/-%.4f' % (region[0], region[1], np.mean(alignments), np.std(alignments))


#
# Pairwise alignment between bands
#
print '\n--- Pairwise p-value ---'
pvals = np.zeros((15, 15))
for aid, region_a in enumerate(regions_of_interest):
    for bid, region_b in enumerate(regions_of_interest):
        alignments_a = np.loadtxt('%s/Noisy estimates/mean%s_LFP_5c_artif_bipolar_BA_w%s_%s_resppositive_alignments_with_alexnet.txt' % (OUTDIR, region_a[0], region_a[1], region_a[0]))
        alignments_b = np.loadtxt('%s/Noisy estimates/mean%s_LFP_5c_artif_bipolar_BA_w%s_%s_resppositive_alignments_with_alexnet.txt' % (OUTDIR, region_b[0], region_b[1], region_b[0]))
        if np.sum(alignments_a) == 0.0 or np.sum(alignments_b) == 0.0 or aid == bid:
            pvals[bid, aid] = np.nan
        else:    
            test_results = mannwhitneyu(alignments_a, alignments_b, alternative='greater')
            pvals[bid, aid] = min(1.0, test_results.pvalue * (len(regions_of_interest)*len(regions_of_interest))) # Bonferroni-corrected p-value, 1.

np.set_printoptions(precision=20)
np.set_printoptions(suppress=True)
for row in pvals:
    print 'TAB'.join([str(x) for x in row])


#
# Alignment compared to control (random network)
#
print '\n--- Greater than control p-value ---'
for region in regions_of_interest:
    alignments_alexnet = np.loadtxt('%s/Noisy estimates/mean%s_LFP_5c_artif_bipolar_BA_w%s_%s_resppositive_alignments_with_alexnet.txt' % (OUTDIR, region[0], region[1], region[0]))
    alignments_alexnetrandom = np.loadtxt('%s/Noisy estimates/mean%s_LFP_5c_artif_bipolar_BA_w%s_%s_resppositive_alignments_with_alexnetrandom.txt' % (OUTDIR, region[0], region[1], region[0]))
    if np.sum(alignments_alexnet) == 0.0 or np.sum(alignments_alexnetrandom) == 0.0:
        print '%s %s: NaN' % (region[0], region[1])
    else:
        test_results = mannwhitneyu(alignments_alexnet, alignments_alexnetrandom, alternative='greater')
        print '%s %s: %.20f' % (region[0], region[1], test_results.pvalue)