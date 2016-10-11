import os
import numpy as np
import scipy.io as sio

# parameters
nruns = 1000
nlayers = 9
nareas = 49
featureset = 'meangamma_bipolar_noscram_artif_responsive_brodmann'
suffix = '.permatrix.nothresh'

# list of subjects
subjects = os.listdir('../../Data/Intracranial/Processed/%s/' % featureset)

def collect_rhos(subjects, featureset, suffix, actual, prun):
    """a
    Compute mapping matrix areas-to-layer with the values showing variance explained
    """

    # compute mapping for the origianl data
    alldata = {}
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

        alldata[sname] = {'rhos': rhos, 'areas': areas}

    return alldata

# compute mapping matrix on the actual data
true = collect_rhos(subjects, featureset, suffix, actual=True, prun=None)

# compute mapping matrix for each permutation run
perm = {}
for r in range(1, nruns + 1):
    print 'Collecting data of the permutation run %d' % r
    perm[r] = collect_rhos(subjects, featureset, suffix, actual=False, prun=r)

# compute p-values
pvals = {}
for sname in true.keys():
    
    # get number of probes
    nprobes = len(true[sname]['areas'])
    if nprobes == 0:
        pvals[sname] = None
        continue
    
    # aggregate rho scores
    scores = np.zeros((nruns, nprobes, nlayers))
    for r in range(nruns):
        scores[r] = perm[r + 1][sname]['rhos']

    # count how many values or rho in permuted data is larger than the true rho value
    is_greater = (scores > true[sname]['rhos'])
    pvals[sname] = np.sum(is_greater, axis=0) / float(nruns)

# count total number of significant electrodes
#totsig = 0
#for sname in true.keys():
#    skip = '\t\t' if len(sname) < 15 else '\t'
#    nsig = np.sum(pvals[sname] < 0.001)
#    print '%s%s%d' % (sname, skip, nsig)
#    totsig += nsig

nsubjects = len(pvals)
for aid in range(nareas):
    for lid in range(nlayers):
        pvalsum = 0
        pvalcount = 0
        for sname in true.keys():
            areapvals = pvals[sname][true[sname]['areas'] == aid, lid]
            pvalsum += np.sum(areapvals)
            pvalcount += len(areapvals)
            
        pvals[aid, lid] = pvalsum / float(pvalcount)

# store the mapping of p-values
np.savetxt('../../Data/Intracranial/Probe_to_Layer_Maps/Permutation/rsa_euclidean_%s%s_pvalues.txt' % (featureset, suffix), pvals, fmt='%.6f')
