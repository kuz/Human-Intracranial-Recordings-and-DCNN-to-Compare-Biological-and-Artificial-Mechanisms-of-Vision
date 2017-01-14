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
volume = np.array([20.3323, 11.5194, 2.9658, 5.1633, 26.0197, 17.8143, 3.7027, 0.7739, 10.7975, 34.1563, 7.6122, 1.4636, 0.1520, 11.1669, 22.2823])
size = volume / 30.0
size[size > 1.0] = 1.0
intensity = np.array([0.0317, 0.0029, 0.0765, 0.0065, 0.0729, 0.0621, 0.0469, 0.0018, 0.0052, 0.0051, 0.2499, 0.1896, 1.0312, 0.0158, 0.0009])
maxthreshold = 0.1
intensity[intensity > maxthreshold] = maxthreshold
intensity = (maxthreshold - intensity)
intensity = (intensity - min(intensity)) / (max(intensity) - min(intensity))

# plot
plt.figure(figsize=(13.0, 6.25), dpi=600);
plt.scatter(x, y, s=size * 10000, c=intensity, cmap=cm.Blues);
plt.axis('off');
plt.savefig('dots_diagonality_and_volume.png', bbox_inches='tight');