import cPickle
import numpy as np
import scipy.io as sio

featureset = 'meanlowgamma_LFP_bipolar_noscram_artif_brodmann_w50_lowgamma_resppositive'
PERMDIR = '../../Data/Intracranial/Probe_to_Layer_Maps/Permutation'
DATADIR = '../../Data/'
OUTDIR = '../../Outcome/Ratios of significant/%s' % featureset

with open('%s/rsa_%s.euclidean.matrix_pvals.pkl' % (PERMDIR, featureset), 'rb') as infile:
    pvals = cPickle.load(infile)

sig_subjects = []
sig_areas = []
sig_responses = np.zeros((0, 269))
sig_stimgroups = []

for sname in pvals.keys():
    if pvals[sname] is not None:
        significant_probe_idx = np.where(np.sum(pvals[sname] < 0.001, axis = 1))[0]
        if len(significant_probe_idx) > 0:
            s = sio.loadmat('%s/Intracranial/Processed/%s/%s.mat' % (DATADIR, featureset, sname))
            areas = np.ravel(s['s']['probes'][0][0][0][0][3])
            sig_subjects += [sname] * len(significant_probe_idx)
            sig_areas += list(np.ravel(areas[significant_probe_idx]))
            sig_responses = np.concatenate((sig_responses, s['s']['data'][0][0][:, significant_probe_idx].T), axis=0)
            sig_stimgroups = list(np.ravel(s['s']['stimgroups'][0][0]))


np.savetxt('%s/subjects.csv' % OUTDIR, sig_subjects, fmt='%s', delimiter=',')
np.savetxt('%s/areas.csv' % OUTDIR, sig_areas, fmt='%d', delimiter=',')
np.savetxt('%s/responses.csv' % OUTDIR, sig_responses, fmt='%.6f' delimiter=',')
np.savetxt('%s/stimgroups.csv' % OUTDIR, sig_stimgroups, fmt='%d', delimiter=',')