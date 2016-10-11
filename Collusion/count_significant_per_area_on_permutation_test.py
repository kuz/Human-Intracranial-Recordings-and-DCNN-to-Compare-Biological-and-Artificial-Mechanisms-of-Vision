import os
import numpy as np
import scipy.io as sio
from matplotlib import pylab as plt

# parameters
nruns = 1000
nlayers = 9
nareas = 49
featureset = 'meangamma_bipolar_noscram_artif_responsive_brodmann'
suffix = '.permatrix.nothresh'

# list of subjects
subjects = os.listdir('../../Data/Intracranial/Processed/%s/' % featureset)

def collect_rhos(subjects, featureset, suffix, actual, prun):
    """
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

sig_al = np.zeros((nareas, nlayers))
sig_a = np.zeros(nareas)
tot_a = np.zeros(nareas)
for aid in range(nareas):
    for sname in true.keys():

        # skip if subject is empty
        if len(true[sname]['areas']) == 0:
            continue

        # count total number of probes per area
        tot_a[aid] += np.sum(true[sname]['areas'] == aid)

        # count number of significant probes in area per layer and in total
        for lid in range(nlayers):
            sig_count = np.sum(pvals[sname][true[sname]['areas'] == aid, lid] <= 0.001)
            sig_al[aid, lid] += sig_count
            sig_a[aid] += sig_count

norm_counts = sig_al / np.tile(sig_a, (nlayers, 1)).T
norm_counts = np.nan_to_num(norm_counts)

ylabels = []
for aid in range(nareas):    
    prefix = '0' if aid < 10 else ''
    label = '(%d/%d) %s%d' % (int(sig_a[aid]), int(tot_a[aid]), prefix, aid)
    ylabels.append(label)

# store the plot
plt.figure(figsize=(10, 10), dpi=300);
plt.imshow(norm_counts, interpolation='none');
plt.xticks(range(nlayers));
plt.yticks(range(nareas), ylabels);
plt.colorbar();
plt.savefig('../../Outcome/Count significant probes/%s%s.png' % (featureset, suffix), bbox_inches='tight');
plt.clf();

