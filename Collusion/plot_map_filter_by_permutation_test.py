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

# store the p-values
#for sname in true.keys():
#    if pvals[sname] is not None:
#        np.savetxt('../../Data/Intracranial/Probe_to_Layer_Maps/Permutation/rsa_euclidean_%s%s_pvalues/%s.txt' % (featureset, suffix, sname), pvals[sname], fmt='%.4f')

rho_al = np.zeros((nareas, nlayers))
cnt_sig_al = np.zeros((nareas, nlayers))
cnt_tot_al = np.zeros((nareas, nlayers))

for sname in true.keys():
    
    # keep only the rhos of the probes that are significant according to p-values from
    # the permutation test
    filtered = true[sname]['rhos'] * (pvals[sname] <= 0.001)
    if filtered.shape[0] == 0:
        continue

    for aid in range(nareas):

        if len(filtered[true[sname]['areas'] == aid]) == 0:
            continue

        # count number of significant probes in area per layer and in total
        for lid in range(nlayers):
            sig_score = np.sum(filtered[true[sname]['areas'] == aid, lid])
            sig_count = np.sum(filtered[true[sname]['areas'] == aid, lid] > 0.0)
            tot_count = len(filtered[true[sname]['areas'] == aid, lid])
            rho_al[aid, lid] += sig_score
            cnt_sig_al[aid, lid] += sig_count
            cnt_tot_al[aid, lid] += tot_count

norm = rho_al / cnt_sig_al
norm = np.nan_to_num(norm)

ylabels = []
for aid in range(nareas):    
    prefix = '0' if aid < 10 else ''
    label = '(%d/%d) %s%d' % (int(sig_a[aid]), int(tot_a[aid]), prefix, aid)
    ylabels.append(label)

# store the plot
plt.figure(figsize=(15, 15), dpi=600);
plt.imshow(norm, interpolation='none');
plt.xticks(range(nlayers));
plt.yticks(range(nareas), ylabels);
plt.colorbar();
for aid in range(nareas):
    for lid in range(nlayers):
        plt.text(lid, aid, ('%.3f' % norm[aid, lid])[1:], va='center', ha='center', size=6)
plt.savefig('../../Outcome/Count significant probes/%s%s.png' % (featureset, suffix), bbox_inches='tight');
plt.clf();

