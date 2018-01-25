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
intensity = np.array([0.6772, 0.7119, 0.4161, 0.7922, 0.9695, 0.5642, 0.4978, 0.3926, 0.8167, 0.8798, 0.5197, 0.5544, 0.1379, 0.7232, 0.7907])

# plot
plt.figure(figsize=(13.0, 6.25), dpi=600);
plt.scatter(x, y, s=size * 10000, c=intensity, cmap=cm.Reds);
plt.axis('off');
plt.savefig('dots_specificity_and_volume.png', bbox_inches='tight');