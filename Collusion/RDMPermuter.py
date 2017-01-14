import os
import argparse
import numpy as np
from RDM import RDMPixel, RDMDNN, RDMBrain
from RSAScorer import RSAScorer
import traceback

class RDMPermuter:

    #: Number of runs per iteration
    nruns = 10000

    #: Paths
    DATADIR = '../../Data'
    PERMDIR = None

    #: Current p-values
    pvalues = None

    #: Dataset paramteters
    backbone = None
    featureset = None
    distance = None
    suffix = None
    scope = None
    threshold = None

    #: Current subject
    sid = None
    sname = None
    pid = None
    

    def __init__(self, sid, pid, backbone, featureset, distance, suffix, scope, threshold):
        self.sid = sid
        self.pid = pid
        self.backbone = backbone
        self.featureset = featureset
        self.distance = distance
        self.suffix = suffix
        self.scope = scope
        self.threshold = threshold

        self.PERMDIR = '%s/Intracranial/Probe_to_Layer_Maps/Permutation/%s_%s.%s%s.%s%s' % (self.DATADIR, self.backbone, self.featureset, self.distance, self.suffix, self.scope, ('%.10f' % self.threshold)[2:].rstrip('0'))

        # load list of subjects
        subjects = os.listdir('%s/Intracranial/Processed/%s/' % (self.DATADIR, self.featureset))
        self.sname = os.path.splitext(subjects[self.sid])[0]

        # create output directory if does not exist
        try:
            os.mkdir(self.PERMDIR)
        except:
            pass

    def run(self):

        # load true score
        true_score = np.loadtxt('%s/Intracranial/Probe_to_Layer_Maps/%s_%s.%s%s.%s%s/%s.txt' %
                                (self.DATADIR, self.backbone, self.featureset, self.distance, self.suffix,
                                 self.scope, ('%.10f' % self.threshold)[2:].rstrip('0'), self.sname))
        true_score = true_score[self.pid]

        # load DNN RDMs
        pixel_rdm = RDMPixel(self.distance, self.featureset, shuffle=False)
        pixel_rdm.load_dsm()
        layer_rdm = RDMDNN(self.distance, 'numpy.reference', self.featureset, shuffle=False)
        layer_rdm.load_dsm()
        
        # compute more scores
        layers = ['pixels', 'conv1', 'conv2', 'conv3', 'conv4', 'conv5', 'fc6', 'fc7', 'fc8']
        scores = np.zeros((self.nruns, len(layers)))
        for lid, layer in enumerate(layers):
            
            # load unshuffled DNN layer DSM
            if layer == 'pixels':
                dnn_dsm = pixel_rdm.dsm
            else:
                dnn_dsm = layer_rdm.dsm[layer]
            
            rdm_brain = RDMBrain(self.distance, self.featureset, self.sid, True)
            for run in range(self.nruns):
                brain_dsm = rdm_brain.compute_dsm(pid)
                scores[run, lid] = RSAScorer.compute_one_correlation_score(dnn_dsm, brain_dsm, self.scope, self.threshold)

        # save all scores
        np.savetxt('%s/Intracranial/Probe_to_Layer_Maps/Permutation/%s_%s.%s%s.%s%s/%s-%d.txt' % (self.DATADIR, self.backbone, self.featureset,
                   self.distance, self.suffix, self.scope, ('%.10f' % self.threshold)[2:].rstrip('0'), self.sname, pid),
                   scores, fmt='%.6f')

        print 'Done with %s (%d)' % (self.sname, self.sid)


if __name__ == '__main__':
    
    parser = argparse.ArgumentParser(description='Compute RDM matrices')
    parser.add_argument('-i', '--sid', dest='sid', type=int, required=True, help='Subject ID')
    parser.add_argument('-p', '--pid', dest='pid', type=int, required=True, help='Probe ID')
    parser.add_argument('-b', '--backbone', dest='backbone', type=str, required=True, help='RSA or Linear')
    parser.add_argument('-f', '--featureset', dest='featureset', type=str, required=True, help='Directory with brain features (Processed/?)')
    parser.add_argument('-d', '--distance', dest='distance', type=str, required=True, help='The distance metric to use')
    parser.add_argument('-o', '--onwhat', dest='onwhat', type=str, required=True, help='image or matrix depending on which you to compute the correlation on')
    parser.add_argument('-t', '--threshold', dest='threshold', type=float, required=True, help='Significance level a score must have to be counter (1.0 to store all)')
        
    args = parser.parse_args()
    sid = int(args.sid)
    pid = int(args.pid)
    backbone = str(args.backbone)
    featureset = str(args.featureset)
    distance = str(args.distance)
    suffix = ''
    scope = str(args.onwhat)
    threshold = float(args.threshold)

    permuter = RDMPermuter(sid, pid, backbone, featureset, distance, suffix, scope, threshold)
    permuter.run()




