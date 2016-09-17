import os
import numpy as np
import scipy.io as sio

# parameters
nruns = 1000
nlayers = 9
nareas = 49
featureset = 'meangamma_bipolar_noscram_artif_responsive_brodmann'
suffix = '.nothresh'

# list of subjects
subjects = os.listdir('../../Data/Intracranial/Processed/%s/' % featureset)

def compute_varexp(nareas, nlayers, subjects, featureset, suffix, actual, prun=None):
    """
    Compute mapping matrix areas-to-layer with the values showing variance explained
    """

    # compute mapping for the origianl data
    rhosum = np.zeros((nareas, nlayers))
    counts = np.zeros(nareas)
    for sfile in subjects:
    
        # load probe-to-area mapping for a given subject
        s = sio.loadmat('../../Data/Intracranial/Processed/%s/%s' % (featureset, sfile))
        sname = s['s']['name'][0][0][0]
        areas = np.ravel(s['s']['probes'][0][0][0][0][3])
        nprobes = len(areas)

        # load rho scores for a given subject
        if actual:
            rhos = np.loadtxt('../../Data/Intracranial/Probe_to_Layer_Maps/rsa_euclidean_%s%s/%s.txt' % (featureset, suffix, sname))
        else:
            rhos = np.loadtxt('../../Data/Intracranial/Probe_to_Layer_Maps/Permutation/rsa_euclidean_%s%s/%d/%s.txt' % (featureset, suffix, prun, sname))

        # compute sums of squared rhos inside each area
        for p in range(nprobes):
            rhosum[areas[p], :] += rhos[p, :] ** 2
            counts[areas[p]] += 1

    # compute variance explained of each area-layer pair
    return np.nan_to_num(rhosum / np.tile(counts, (rhosum.shape[1], 1)).T) * 100

# compute mapping matrix on the actual data
true_varexp = compute_varexp(nareas, nlayers, subjects, featureset, actual=True)

# compute mapping matrix for each permutation run
dist_perm_varexp = np.zeros((nruns, true_varexp.shape[0], true_varexp.shape[1]))
for r in range(1, nruns + 1):
    print 'Building mapping for run %d' % r
    dist_perm_varexp[r - 1] = compute_varexp(nareas, nlayers, subjects, featureset, actual=False, prun=r)

# compute p-values
pvals = np.ones(true_varexp.shape) * np.inf
for aid in range(nareas):
    for lid in range(nlayers):
        pvals[aid, lid] = np.sum(dist_perm_varexp[:, aid, lid] >= true_varexp[aid, lid]) / float(nruns)

# store the mapping of p-values
np.savetxt('../../Data/Intracranial/Probe_to_Layer_Maps/Permutation/rsa_euclidean_%s%s/pvalues.txt' % (featureset, suffix), pvals, fmt='%.6f')
