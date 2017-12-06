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
nareas = 9
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

# read data
specificity = []
volume = []
for win in [50, 150, 250]:
    gamma_conv_volume = 0
    allband_conv_volume = 0
    gamma_fc_volume = 0
    allband_fc_volume = 0
    for layer in range(9):
        for band in ['theta', 'alpha', 'beta', 'lowgamma', 'highgamma']:
            stats = np.load('%s/rsa_mean%s_LFP_5c_artif_bipolar_BA_w%d_%s_resppositive.euclidean.%s.matrixpermfiltered.npy' % (STATDIR, band, win, band, network)).item()
            specificity.append(stats['per_layer']['specificity'][layer])
            volume.append(stats['per_layer']['volume'][layer])
            
            if band not in ['lowgamma', 'highgamma'] and layer in [1, 2, 3, 4, 5]:
                gamma_conv_volume += stats['per_layer']['volume'][layer]
            if layer in [1, 2, 3, 4, 5]:
                allband_conv_volume += stats['per_layer']['volume'][layer]

            if band not in ['lowgamma', 'highgamma'] and layer in [6, 7]:
                gamma_fc_volume += stats['per_layer']['volume'][layer]
            if layer in [6, 7]:
                allband_fc_volume += stats['per_layer']['volume'][layer]
    
    print 'win', win 
    print '3band conv', gamma_conv_volume
    print 'allba conv', allband_conv_volume
    print '3band fc  ', gamma_fc_volume
    print 'allba fc  ', allband_fc_volume
    print ''

# transform data
size = np.array(volume) / np.max(volume)
specificity = np.array(specificity)

# plot
plt.figure(figsize=(14.0, 0.625), dpi=300);
plt.scatter(x, y, s=size * 100, c=specificity, cmap=cm.Reds);
plt.ylim(0.5, 3.5);
plt.axis('off');
plt.savefig('dots_layer_specificty_and_volume.png', bbox_inches='tight');