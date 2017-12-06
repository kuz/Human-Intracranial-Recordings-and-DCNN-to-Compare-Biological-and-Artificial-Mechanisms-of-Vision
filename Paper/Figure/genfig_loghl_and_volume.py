import numpy as np
import matplotlib
matplotlib.use('Agg')
from matplotlib import pylab as plt
import matplotlib.cm as cm
import pdb

# parameters
network = 'alexnet'
STATDIR = '../../../Outcome/Statistics/'

# prepare grid
nareas = 5
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
highlow = []
volume = []
for win in [50, 150, 250]:
    for area in [17, 18, 19, 37, 20]:
        for band in ['theta', 'alpha', 'beta', 'lowgamma', 'highgamma']:
            stats = np.load('%s/rsa_mean%s_LFP_5c_artif_bipolar_BA_w%d_%s_resppositive.euclidean.%s.matrixpermfiltered.npy' % (STATDIR, band, win, band, network)).item()
            highlow.append(stats['per_area']['hhl_ratio'][area])
            volume.append(stats['per_area']['volume'][area])

# transform data
size = np.array(volume) / np.max(volume)
highlow = np.array(highlow)

# plot
plt.figure(figsize=(10.0, 0.9), dpi=300);
plt.scatter(x, y, s=size * 200, c=highlow, cmap=cm.bwr);
plt.ylim(0.5, 3.5);
plt.axis('off');
plt.savefig('dots_loghl_and_volume.png', bbox_inches='tight');