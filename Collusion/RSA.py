from abc import ABCMeta, abstractmethod, abstractproperty
import os
import numpy as np
from scipy.ndimage import imread
from scipy.spatial import distance as scipydist
import argparse


class RSA:
    __metaclass__ = ABCMeta

    #: Paths
    DATADIR = '../../Data'
    CODEDIR = '../../Repository'

    #: The distance metric
    distance = None

    #: Matrix where data samples are stored
    representation = abstractproperty()

    #: Resulting dissimilarity matrix
    dsm = abstractproperty()

    #: Reordering of the images from the order of DNN into ordering by categories
    reorder_dnn_to_categories = []

    #: Reordering of the images from the order of stimulation into ordering by categories
    reorder_stimulation_to_categories = []

    def __init__(self, distance):
        self.distance = distance

        # list of stimuli used for human stimulation
        stimulation_stimuli = np.loadtxt('../Intracranial/stimsequence.txt', dtype='string')

        # create the reordering from stimulation order to order by category
        for s in sorted(set(stimulation_stimuli)):
            for i in np.where(stimulation_stimuli == s)[0]:
                self.reorder_stimulation_to_categories.append(i)

        # list of stimuli used to extract DNN activations
        dnn_stimuli = np.loadtxt('%s/DNN/imagesdone.txt' % self.DATADIR, dtype={'names': ('stimulus', 'class'), 'formats': ('S10', 'i1')})
        dnn_stimuli = np.array([x[0].split('.')[0] for x in dnn_stimuli])

        # create the reordering from dnn order to order by category
        for s in sorted(stimulation_stimuli):
            for i in np.where(dnn_stimuli == s)[0]:
                self.reorder_dnn_to_categories.append(i)

    @abstractmethod
    def compute_dsm(self):
        pass

    @abstractmethod
    def save_dsm(self):
        pass

    @abstractmethod
    def load_dsm(self):
        pass

    @abstractmethod
    def plot_dsm(self):
        pass

class RSAPixel(RSA):
    representation = None
    dsm = None

    def __init__(self, distance):
        RSA.__init__(self, distance)
        self.representation = np.zeros((419, 51529))
        for i, fname in enumerate(os.listdir('%s/DNN/imagesdone/' % self.DATADIR)):
            self.representation[i] = np.ravel(imread('%s/DNN/imagesdone/%s' % (self.DATADIR, fname)))
        self.representation = self.representation[self.reorder_dnn_to_categories]

    def compute_dsm(self):
        self.dsm = scipydist.squareform(scipydist.pdist(self.representation, self.distance))

    def save_dsm(self):
        np.savetxt('%s/RSA/%s/numbers/dnn-pixels.txt' % (self.DATADIR, self.distance), self.dsm, fmt='%.6f')

    def load_dsm(self):
        self.dsm = np.loadtxt('%s/RSA/%s/numbers/dnn-pixels.txt' % (self.DATADIR, self.distance))

    def plot_dsm(self):
        #plt.figure();
        #plt.imshow(self.dsm);
        #plt.colorbar();
        #plt.savefig('%s/RSA/%s/plots/dnn-pixels.png' % (self.DATADIR, self.distance));
        #plt.clf();


class RSADNN(RSA):
    representation = None
    dsm = {}
    layers = None

    def __init__(self, distance, np_activation_data):
        RSA.__init__(self, distance)

        self.layers = os.listdir('%s/DNN/activations/%s' % (self.CODEDIR, np_activation_data))
        self.representation = {}
        for layer in self.layers:
            self.representation[layer] = np.load('%s/DNN/activations/%s/%s/activations.npy' % (self.CODEDIR, np_activation_data, layer))
            self.representation[layer] = self.representation[layer][self.reorder_dnn_to_categories]

    def compute_dsm(self):
        for layer in self.layers:
            print 'Computing the matrix for layer %s...' % layer
            self.dsm[layer] = scipydist.squareform(scipydist.pdist(self.representation[layer], self.distance))

    def save_dsm(self):
        for layer in self.layers:
            np.savetxt('%s/RSA/%s/numbers/dnn-%s.txt' % (self.DATADIR, self.distance, layer), self.dsm[layer], fmt='%.6f')

    def load_dsm(self):
        for layer in self.layers:
            self.dsm[layer] = np.loadtxt('%s/RSA/%s/numbers/dnn-%s.txt' % (self.DATADIR, self.distance, layer))

    def plot_dsm(self):
        for layer in self.layers:
            #plt.figure();
            #plt.imshow(self.dsm);
            #plt.colorbar();
            #plt.savefig('%s/RSA/%s/plots/dnn-%s.png' % (self.DATADIR, dist, layer));
            #plt.clf();
            pass


class RSABrain(RSA):
    pass


if __name__ == '__main__':

    parser = argparse.ArgumentParser(description='Compute RDM matrices')
    parser.add_argument('-s', '--source', dest='source', type=str, required=True, help='The data source: pixels, dnn or brain')
    parser.add_argument('-d', '--distance', dest='distance', type=str, required=True, help='The distance metric to use')
    parser.add_argument('-a', '--activations', dest='np_activation_data', type=str, required=False, help='DNN activations for DNN RDMs')
    args = parser.parse_args()
    source = str(args.source)
    distance = str(args.distance)
    np_activation_data = str(args.np_activation_data)

    if source == 'pixels':
        rsa = RSAPixel(distance)
        rsa.compute_dsm()
        rsa.save_dsm()
    elif source == 'dnn':
        np_activation_data
        pass
    elif source == 'brain':
        pass
    else:
        print 'ERROR: Unknown data source %s' % source

