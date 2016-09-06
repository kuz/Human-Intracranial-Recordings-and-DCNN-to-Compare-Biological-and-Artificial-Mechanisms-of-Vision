import os
import numpy as np
from scipy.spatial import distance
from scipy.ndimage import imread
from matplotlib import pylab as plt
import argparse

# read in command line arguments
parser = argparse.ArgumentParser(description='Compute RSA matrix for pixel representations')
parser.add_argument('-d', '--distance', dest='dist', type=str, required=True, help='The distance metric to use')
args = parser.parse_args()
dist = str(args.dist)

# load representations 
print 'Loading pixel space representations...'
representation = np.zeros((419, 51529))
for i, fname in enumerate(os.listdir('../../Data/DNN/imagesdone/')):
    representation[i] = np.ravel(imread('../../Data/DNN/imagesdone/%s' % fname))

# load list of stimuli in the order they were presented to DNN
print 'Loading DNN stimuli...'
dnn_stimuli = np.loadtxt('../../Data/DNN/imagesdone.txt', dtype={'names': ('stimulus', 'class'), 'formats': ('S10', 'i1')})
dnn_stimuli = [x[0].split('.')[0] for x in dnn_stimuli]

# load the list of stimuli of interest and filter the data
stimuli_of_interest = np.loadtxt('../Intracranial/stimsequence.txt', dtype='string')
keepidx = [dnn_stimuli.index(s) for s in stimuli_of_interest]
representation = representation[sorted(keepidx)]

# compute similarity matrix
print 'Computing the matrix...'
sm = distance.squareform(distance.pdist(representation, dist))

# store similarity matrix
print 'Storing the data...'
np.savetxt('../../Data/RSA/%s/numbers/dnn-pixels.txt' % dist, sm, fmt='%.6f')

# plot similarity matrix
plt.figure();
plt.imshow(sm);
#plt.clim(-1.0, 1.0);
plt.colorbar();
plt.savefig('../../Data/RSA/%s/plots/dnn-pixels.png' % dist);
plt.clf();

print 'Done.'
