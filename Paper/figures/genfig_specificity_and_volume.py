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
#volume = np.array([20.3323, 11.5194, 2.9658, 5.1633, 26.0197, 17.8143, 3.7027, 0.7739, 10.7975, 34.1563, 7.6122, 1.4636, 0.1520, 11.1669, 22.2823])
volume = np.array([26.0539, 14.2873, 5.3565, 5.5404, 26.0197, 21.9288, 4.7998, 1.5631, 11.0692, 34.8804, 3.4778, 0.2509, 0.1520, 8.6375, 22.7928])
size = volume / 30.0
size[size > 1.0] = 1.0
#intensity = np.array([0.6772, 0.7119, 0.4161, 0.7922, 0.9695, 0.5642, 0.4978, 0.3926, 0.8167, 0.8798, 0.5197, 0.5544, 0.1379, 0.7232, 0.7907])
intensity = np.array([0.8678, 0.8829, 0.7515, 0.8501, 0.9695, 0.7122, 0.7626, 0.7930, 0.8535, 0.8984, 0.3636, 0.1758, 0.1379, 0.6898, 0.8088])
intensity = (intensity - min(intensity)) / (max(intensity) - min(intensity))

# plot
plt.figure(figsize=(14.0, 6.25), dpi=600);
plt.scatter(x, y, s=size * 10000, c=intensity, cmap=cm.Reds);
#cb = plt.colorbar();
#cb.set_ticks([0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0])
#cb.set_ticklabels([0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0])
plt.axis('off');
plt.savefig('dots_specificity_and_volume.png', bbox_inches='tight');