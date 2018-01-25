import os
import numpy as np
import matplotlib
matplotlib.use('Agg')
from matplotlib import pylab as plt
import matplotlib.cm as cm


# paths
DATAPATH = '../../Data'
OUTPATH = '../../Outcome'

def mkdir(path):
    try:
        os.mkdir(path)
    except:
        pass

# parameters
image_id = 0
conv_size = [96, 256, 384, 384, 256]
conv_side = [55, 27, 13, 13, 13]

# prepare directory structure


# load activations
for conv_id in range(len(conv_size)):
    mkdir('%s/Figures/Layer reconstruction/conv%d' % (OUTPATH, conv_id + 1))
    mkdir('%s/Figures/Layer reconstruction/conv%d/image%d/' % (OUTPATH, conv_id + 1, image_id))
    
    flat_activations = np.load('%s/DNN/activations/alexnet/conv%d/activations.npy' % (DATAPATH, conv_id + 1))
    all_filters = flat_activations[image_id, :].reshape((conv_size[conv_id], conv_side[conv_id], conv_side[conv_id]))

    for fid in range(conv_size[conv_id]):
        plt.figure();
        plt.imshow(all_filters[fid, :, :], interpolation='none', cmap=cm.Blues);
        plt.savefig('%s/Figures/Layer reconstruction/conv%d/image%d/filter%d.png' % (OUTPATH, conv_id + 1, image_id, fid), bbox_inches='tight');
        plt.clf();
        plt.close();
