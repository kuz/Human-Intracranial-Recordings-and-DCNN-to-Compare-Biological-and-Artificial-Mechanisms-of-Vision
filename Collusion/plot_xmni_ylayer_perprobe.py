import os
import numpy as np
import scipy.io as sio
from matplotlib import pylab as plt

# parameters
nlayers = 9
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
allprobes = np.zeros((0, 2))
for sname in true:
    for pid in range(len(true[sname]['areas'])):
        if true[sname]['areas'][pid] in [17, 18, 19, 37, 20]:
            if np.max(true[sname]['rhos'][pid, :]) > 0.0:
                ties = np.where(true[sname]['rhos'][pid, :] == np.max(true[sname]['rhos'][pid, :]))[0]
                for lid in ties:
                    if pvals[sname][pid, lid] <= 0.001:
                        record = np.array([true[sname]['mni'][pid, 1], lid]).reshape((1, 2))
                        allprobes = np.concatenate((allprobes, record))

# sort probes by sagittalcoordinate
allprobes = allprobes[allprobes[:,0].argsort()]

# plot
plt.figure(figsize=(10, 10), dpi=300);
for lid in range(nlayers):
    x = allprobes[allprobes[:, 1] == lid, 0]
    y = allprobes[allprobes[:, 1] == lid, 1]
    plt.plot(x, y, 'o');
plt.legend(['Layer %d' % x for x in range(nlayers)]);
plt.savefig('../../Outcome/Figures/Single probe/xmni_ylayer_perprobe_%s%s.png' % (featureset, suffix), bbox_inches='tight');
plt.clf();

# boxplot
plt.figure(figsize=(10, 10), dpi=300);
data = []
for lid in range(nlayers):
    data.append(allprobes[allprobes[:, 1] == lid, 0])
plt.boxplot(data, 0, 'rs', 0);
plt.savefig('../../Outcome/Figures/Single probe/xmni_ylayer_perprobe_%s%s_boxplot.png' % (featureset, suffix), bbox_inches='tight');
plt.clf();

