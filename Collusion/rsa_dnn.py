import os
import time
import numpy as np
from scipy.spatial import distance
from matplotlib import pylab as plt
import argparse

# read in command line arguments
parser = argparse.ArgumentParser(description='Compute RSA matrix for DNN representations')
parser.add_argument('-a', '--activations', dest='np_activation_data', type=str, required=True, help='Directory with DNN activations (DNN/activations/?)')
parser.add_argument('-d', '--distance', dest='dist', type=str, required=True, help='The distance metric to use')
args = parser.parse_args()
np_activation_data = str(args.np_activation_data)
dist = str(args.dist)

# load DNN activations
print 'Loading DNN activations...'
layers = os.listdir('../../Repository/DNN/activations/%s' % np_activation_data)
activations = {}
for layer in layers:
    activations[layer] = np.load('../../Repository/DNN/activations/%s/%s/activations.npy' % (np_activation_data, layer))

#load the list of stimuli in the order they were presented to DNN
print 'Loading DNN stimuli...'
dnn_stimuli = np.loadtxt('../../Data/DNN/imagesdone.txt', dtype={'names': ('stimulus', 'class'), 'formats': ('S10', 'i1')})
dnn_stimuli = [x[0].split('.')[0] for x in dnn_stimuli]

# load the list of stimuli of interest and filter the data
stimuli_of_interest = np.loadtxt('../Intracranial/stimsequence.txt', dtype='string')
keepidx = sorted([dnn_stimuli.index(s) for s in stimuli_of_interest])
for layer in layers:
    activations[layer] = activations[layer][keepidx]

# compute similarity matrices
for layer in layers:
    print 'Computing the matrix for layer %s...' % layer
    sm = distance.squareform(distance.pdist(activations[layer], dist))

    # store the data
    np.savetxt('../../Data/RSA/%s/numbers/dnn-%s.txt' % (dist, layer), sm, fmt='%.6f')

    # store the plot
    plt.figure();
    plt.imshow(sm);
    #plt.clim(-1.0, 1.0);
    plt.colorbar();
    plt.savefig('../../Data/RSA/%s/plots/dnn-%s.png' % (dist, layer));
    plt.clf();

print 'Done.'
