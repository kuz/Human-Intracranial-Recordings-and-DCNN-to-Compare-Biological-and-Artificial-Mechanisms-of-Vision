import numpy as np
import matplotlib
matplotlib.use('Agg')
from matplotlib import pylab as plt
import matplotlib.cm as cm

# parameters
network = 'alexnet'
STATDIR = '../../../Outcome/Statistics/'
pthreshold = 0.005 / 15.0

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
diagonality = []
significance = []
for win in [50, 150, 250]:
    for band in ['theta', 'alpha', 'beta', 'lowgamma', 'highgamma']:
        stats = np.load('%s/rsa_mean%s_LFP_5c_artif_bipolar_BA_w%d_%s_resppositive.euclidean.%s.matrixpermfiltered.npy' % (STATDIR, band, win, band, network)).item()
        diagonality.append(stats['alignment']['rho'])
        significance.append(stats['alignment']['pval'])
        print '%s\t%d\t%.4f\t%.10f' % (band[:5], win, stats['alignment']['rho'], stats['alignment']['pval'])

# transform data
diagonality = np.array(diagonality)
significance = np.array(significance)
diagonality[np.isnan(diagonality)] = 0.0
significance[np.isnan(significance)] = 0.0

size = 1.0 / significance
size[np.isinf(size)] = np.ma.masked_invalid(size).max()
size = np.log(size)
normalizer = (max(size) - min(size))
size = (size - min(size)) / normalizer
size005 = np.array(np.log(1.0 / pthreshold))
size005 /= normalizer

# plot
plt.figure(figsize=(13.0, 7.35), dpi=300);
plt.scatter(x, y, s=size * 17000, c=diagonality, cmap=cm.bwr, vmin=-0.6, vmax=0.6);

# p-value threshold circle
plt.scatter(x, y, s=np.tile(size005, 15) * 17000, facecolors='none', edgecolors='black', alpha=0.9, linestyle='dashed', linewidth=2);
plt.xlim(0.4, 5.5);
plt.ylim(0.5, 3.5);

plt.axis('off');
plt.savefig('dots_diagonality_and_significance.png', bbox_inches='tight');
