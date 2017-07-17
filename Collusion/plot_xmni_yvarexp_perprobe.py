import os
import numpy as np
import scipy.io as sio
from matplotlib import pylab as plt

# parameters
nlayers = 9
nruns = 1000
featureset = 'meangamma_bipolar_noscram_artif_responsive_brodmann'
suffix = '.permatrix.nothresh'

# list of subjects
subjects = sorted(os.listdir('../../Data/Intracranial/Processed/%s/' % featureset))

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
        mni = s['s']['probes'][0][0][0][0][2]
        areas = np.ravel(s['s']['probes'][0][0][0][0][3])
        nprobes = len(areas)

        # load rho scores for a given subject
        if actual:
            rhos = np.loadtxt('../../Data/Intracranial/Probe_to_Layer_Maps/rsa_euclidean_%s%s/%s.txt' % (featureset, suffix, sname))
        else:
            rhos = np.loadtxt('../../Data/Intracranial/Probe_to_Layer_Maps/Permutation/rsa_euclidean_%s%s/%d/%s.txt' % (featureset, suffix, prun, sname))

        alldata[sname] = {'rhos': rhos, 'areas': areas, 'mni': mni}

    return alldata

# compute mapping matrix on the actual data
true = collect_rhos(subjects, featureset, suffix, actual=True, prun=None)

# load p-values from the permutation test
pvals = {}
for sname in true.keys():
    try:
        pvals[sname] = np.loadtxt('../../Data/Intracranial/Probe_to_Layer_Maps/Permutation/rsa_euclidean_%s%s_pvalues/%s.txt' % (featureset, suffix, sname))
    except:
        print '%s.txt not found' % sname

# collect all probes into a matrix with each row having [2nd MNI, layer, rho]
allprobes = np.zeros((0, 3))
for sname in true:
    for pid in range(len(true[sname]['areas'])):
        if true[sname]['areas'][pid] in [17, 18, 19, 37, 20]:
            for lid in range(nlayers):
                if pvals[sname][pid, lid] <= 0.001:
                    record = np.array([true[sname]['mni'][pid, 1], lid, true[sname]['rhos'][pid, lid]**2]).reshape((1, 3))
                    allprobes = np.concatenate((allprobes, record))

# drop record with static being 0
allprobes = allprobes[allprobes[:, 2] != 0]

# sort probes by sagittalcoordinate
allprobes = allprobes[allprobes[:,0].argsort()]

# plot
"""
plt.figure(figsize=(10, 10), dpi=300);
for lid in range(nlayers):
    x = allprobes[allprobes[:, 1] == lid, 0]
    y = allprobes[allprobes[:, 1] == lid, 2]
    plt.plot(x, y, 'o');
plt.legend(['Layer %d' % x for x in range(nlayers)]);
plt.savefig('../../Outcome/Figures/xmni_yvarexp_perprobe_%s%s.png' % (featureset, suffix), bbox_inches='tight');
plt.clf();
"""

for lid in range(nlayers):
    plt.figure(figsize=(10, 10), dpi=300);
    x = allprobes[allprobes[:, 1] == lid, 0]
    y = allprobes[allprobes[:, 1] == lid, 2]
    plt.plot(x, y, 'o');
    plt.legend(['Layer %d' % lid]);
    plt.savefig('../../Outcome/Figures/xmni_yvarexp_perprobe_%s%s_layer%d.png' % (featureset, suffix, lid), bbox_inches='tight');
    plt.clf();

for lid in range(nlayers):
    plt.figure(figsize=(10, 10), dpi=300);
    x = allprobes[allprobes[:, 1] == lid, 0]
    plt.hist(x, 50, normed=1)
    plt.xlim(-100, 20);
    plt.legend(['Layer %d' % lid]);
    plt.savefig('../../Outcome/Figures/hist_xmni_yvarexp_perprobe_%s%s_layer%d.png' % (featureset, suffix, lid), bbox_inches='tight');
    plt.clf();
