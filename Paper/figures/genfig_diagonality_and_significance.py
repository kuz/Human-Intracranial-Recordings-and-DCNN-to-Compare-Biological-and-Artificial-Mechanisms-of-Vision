import numpy as np
from matplotlib import pylab as plt
import matplotlib.cm as cm

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
size = d * 400

# set data
#signigicance = np.array([0.2701, 0.1503, 0.2119, 0.0016, 0.0284, 0.3711, 0.2806, 0.1961, 0.0004, 0.0000, 0.2808, 0.2893, 1.0000, 0.0007, 0.0187])
#signigicance = np.array([0.6967, 0.1729, 0.1883, 0.0011, 0.0142, 0.8721, 0.4686, 0.5393, 0.0000, 0.0000,  0.2549, 0.4009, 1.0000, 0.0000, 0.0083])
signigicance = np.array([0.0739, 0.0007, 0.1369, 0.0002, 0.0142, 0.1017, 0.0560, 0.2222, 0.0000, 0.0000, 0.5412, 1.0000, 1.0000, 0.0000, 0.0025])

size = 1.0 / signigicance
size[np.isinf(size)] = np.ma.masked_invalid(size).max()
size = np.log(size)
size005 = np.array(np.log(1.0 / 0.05))
size005 /= (max(size) - min(size))
size = (size - min(size)) / (max(size) - min(size))

#diagonality = np.array([0.0897, 0.1801, -0.2727, 0.5189, 0.1987, 0.0375, -0.1710, 0.4852, 0.4374, 0.3498, -0.1308, -0.2524, 0.0000, 0.4359, 0.2347])
#diagonality = np.array([0.0337, 0.1529, -0.3068, 0.5017, 0.1805, -0.0145, -0.1375, 0.3178, 0.4420, 0.3189, -0.1641, -0.2673, 0.0000, 0.4422, 0.1996])
diagonality = np.array([0.1359, 0.3378, 0.2565, 0.5497, 0.1805, 0.1333, 0.3213, 0.4006, 0.5215, 0.3301, -0.1283, 0.0000, 0.0000, 0.5340, 0.2250])

# plot
plt.figure(figsize=(14.0, 6.25), dpi=600);
plt.scatter(x, y, s=size * 10000, c=diagonality, cmap=cm.bwr, vmin=-0.6, vmax=0.6);
#plt.clim(0, 0.22);
#cb = plt.colorbar();
#cb.set_ticks([-0.6, -0.48, -0.36, -0.24, -0.12, 0.0, 0.12, 0.24, 0.36, 0.48, 0.6])
#cb.set_ticklabels([-0.5, -0.4, -0.3, -0.2, -0.1, 0.0, 0.1, 0.2, 0.3, 0.4, 0.5])

# 0.05 circle
plt.scatter(x, y, s=np.tile(size005, 15) * 10000, facecolors='none', edgecolors='black', alpha=0.9, linestyle='dotted');

plt.axis('off');
plt.savefig('dots_diagonality_and_significance.png', bbox_inches='tight');