'''

Run RDM correlation analysis between the layers of DCNN to see if distant ones are,
indeed, apart and close one are correlated

'''

import os
import sys
import numpy as np
from scipy.stats import spearmanr
from sklearn.preprocessing import MinMaxScaler

# parameters
featureset = 'meantheta_LFP_5c_artif_bipolar_BA_w50_theta_resppositive' # does not matter which one
layers = ['pixels', 'conv1', 'conv2', 'conv3', 'conv4', 'conv5', 'fc6', 'fc7', 'fc8']
nlayers = len(layers)
distance = 'euclidean'
suffix = ''
network = 'alexnet'

# load layer RDMs
dnn_dsm = {}
for layer in layers:
    if layer == 'pixels':
        dnn_dsm[layer] = np.loadtxt('../../Data/RSA/%s.%s%s/numbers/dnn-%s.txt' % (featureset, distance, suffix, layer))
    else:
        dnn_dsm[layer] = np.loadtxt('../../Data/RSA/%s.%s%s/numbers/dnn-%s-%s.txt' % (featureset, distance, suffix, layer, network))

# compure correaltions
corrs = np.zeros((nlayers ,nlayers))
pvals = np.zeros((nlayers, nlayers))
for i in range(nlayers):
    for j in range(nlayers):
        mms = MinMaxScaler()
        layer_i = mms.fit_transform(dnn_dsm[layers[i]])
        layer_j = mms.fit_transform(dnn_dsm[layers[j]])
        r, p = spearmanr(np.ravel(layer_i), np.ravel(layer_j))
        corrs[i, j] = r
        pvals[i, j] = p

#np.set_printoptions(precision=10)
#np.set_printoptions(suppress=True)
print
for row in corrs:
    print 'TAB'.join([str(x) for x in row])
print
for row in pvals:
    print 'TAB'.join([str(x) for x in row])
print