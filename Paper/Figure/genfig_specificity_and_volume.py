import numpy as np
import matplotlib
matplotlib.use('Agg')
from matplotlib import pylab as plt
import matplotlib.cm as cm

# parameters
network = 'alexnet'
STATDIR = '../../../Outcome/Statistics/'

# prepare grid
nareas = 1
nfreqs = 5
ntimes = 3
x = []
n = 0.0
for a in range(nareas):
    for f in range(nfreqs):
        n += 1.0
        x.append(n)
    n += float(1.3)
x = np.tile(x, ntimes)
y = np.ravel([[t] * nareas * nfreqs for t in np.arange(ntimes, 0, -1)])
d = np.ones(ntimes * nareas * nfreqs)

# read data
specificity = []
volume = []
for win in [50, 150, 250]:
    for band in ['theta', 'alpha', 'beta', 'lowgamma', 'highgamma']:
        stats = np.load('%s/rsa_mean%s_LFP_5c_artif_bipolar_BA_w%d_%s_resppositive.euclidean.%s.matrixpermfiltered.npy' % (STATDIR, band, win, band, network)).item()
        specificity.append(stats['visual_specifity'])
        volume.append(np.sum(stats['volume']['visual']['absolute']))
        print '%s\t%d\t%.4f\t%.4f' % (band[:5], win, stats['visual_specifity'], np.sum(stats['volume']['visual']['absolute']))

# transform data
size = np.array(volume) / np.max(volume)
specificity = np.array(specificity)

# plot
plt.figure(figsize=(13.0, 7.35), dpi=300);
plt.scatter(x, y, s=size * 17000, c=specificity, cmap=cm.Reds);
plt.xlim(0.4, 5.5);
plt.ylim(0.5, 3.5);
plt.axis('off');
plt.savefig('dots_specificity_and_volume.png', bbox_inches='tight');
