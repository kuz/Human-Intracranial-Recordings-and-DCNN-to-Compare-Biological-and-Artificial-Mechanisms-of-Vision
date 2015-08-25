import numpy as np

# load class labels
with open('../../Data/ILSVRC2012_synset_words.txt', 'r') as f:
    buffer = f.read()
    labels = buffer.split('\n')

# load last layer activations
with open('activations/numpy/fc8/activations.npy') as f:
    activations = np.load(f)

# for each image find neuron number with highest acitvation
predictions = np.argmax(activations, 1)

# for each file print out the label for the corresponding class
for predicted_class in predictions:
    print labels[int(predicted_class)]
