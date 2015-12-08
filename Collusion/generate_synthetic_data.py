"""

Sanity-check synthetic data generator
-------------------------------------

Each probe has one feature which is taken as linear combination of DNN layer
activations plus some noise. One probe has fixed set of weights across all stimuli.
This set of weights is what a linear model should capture.

The layer which should be mapped to the probe will have its activity multiplied by 
the same set of weights for each of the stimuli. Other layers' activity will be
multiplied by a random set of weights generater anew for each of the stimuli.

The way to check if linear models did indeed capture the weights we have generated
we will need to check probe-to-layer assignment files generated by the
`map_layers_to_probes.py` script. For every subject it should look like
000000111111222223333333....777777 with minor mistakes.

"""

import os
import numpy as np
import scipy.io as sio
from sklearn.preprocessing import scale

# parameters
np_activation_data = 'numpy.reference'
featureset = 'synthetic.reference'

print 'Producing %s from %s' % (featureset, np_activation_data)

print 'Loading list of layers...'
layers = os.listdir('../../Repository/DNN/activations/%s' % np_activation_data)

# load list of stimuli in the order they were presented to DNN
print 'Loading DNN stimuli...'
dnn_stimuli = np.loadtxt('../../Data/DNN/imagesdone.txt', dtype={'names': ('stimulus', 'class'), 'formats': ('S10', 'i1')})
dnn_stimuli = [x[0].split('.')[0] for x in dnn_stimuli]

# load subject data
s = sio.loadmat('../../Data/Intracranial/Processed/maxamp/AL_25FEV13N.mat')
subject = {}
subject['stimseq'] = [x[0][0] for x in s['s']['stimseq'][0][0]]
subject['stimgroups'] = [x[0] for x in s['s']['stimgroups'][0][0]]
subject['probes'] = {}
subject['probes']['rod_names'] = list(s['s']['probes'][0][0][0][0][0])
subject['probes']['probe_ids'] = [x[0] for x in list(s['s']['probes'][0][0][0][0][1])]
subject['probes']['mni'] = s['s']['probes'][0][0][0][0][2]
subject['data'] = s['s']['data'][0][0]
subject['name'] = s['s']['name'][0][0][0]

# keep activations only for the relevant stimuli
keep_dnn_stimuli = []
for stimulus in subject['stimseq']:
    sid_dnn = dnn_stimuli.index(stimulus)
    keep_dnn_stimuli.append(sid_dnn)

print 'Loading DNN activations...'
activations = {}
for layer in layers:
    activations[layer] = np.load('../../Repository/DNN/activations/%s/%s/activations.npy' % (np_activation_data, layer))
    activations[layer] = np.matrix(activations[layer][keep_dnn_stimuli, :])

# split probes into hypothetical "brain" layers
nprobes = s['s']['data'][0][0].shape[1]
brain_layers = np.array_split(range(nprobes), len(layers))

for lid, brain_layer in enumerate(brain_layers):

    # first layer is generated as linear combination of DNN conv1 activations
    """
    if lid == 0:
        d = activations[layers[lid]].shape[1]
        weights = np.matrix(np.random.exponential(1.0, d)).T
        one_probe_activity = scale(activations[layers[lid]] * weights)
        all_probe_activity = np.tile(one_probe_activity, len(brain_layer))
    
    # other layers are generated as: next = non-linearity(previous), as if we emulate
    # the brain by progressing some visual features forward in the brain
    else:
        previous_layer_activity = s['s']['data'][0][0][:, brain_layers[lid - 1]]
        weights = np.matrix(np.random.exponential(1.0, previous_layer_activity.shape[1])).T
        one_probe_activity = np.tanh(scale(previous_layer_activity * weights))
        all_probe_activity = np.tile(one_probe_activity, len(brain_layer))
    """
    
    if lid == 5 or lid == 6:
        d = activations[layers[lid]].shape[1]
        weights = np.matrix(np.random.exponential(1.0, d)).T
        
        #weights[weights < 5.0] = 0.0
        #weights[::(lid + 1)] = 0.0

        one_probe_activity = np.tanh(scale(activations[layers[lid]] * weights))
        all_probe_activity = np.tile(one_probe_activity, len(brain_layer))

        #one_probe_activity = scale(np.random.normal(-1.0, 1.0, 319))
        #one_probe_activity[::(lid + 1)] = np.array(activations[layers[lid]][::(lid + 1)] * weights).squeeze()
        #all_probe_activity = np.tile(np.matrix(one_probe_activity).T, len(brain_layer))
    
    else:
        all_probe_activity = scale(np.random.normal(-1.0, 1.0, (319, len(brain_layer))))
    

    # add some noise
    noise = np.random.uniform(-0.1, 0.1, all_probe_activity.shape)
    all_probe_activity += noise

    # put the generated activity into the data matrix
    s['s']['data'][0][0][:, brain_layer] = all_probe_activity

sio.savemat('../../Data/Intracranial/Processed/%s/AL_25FEV13N.mat' % featureset, s)
