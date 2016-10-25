import os
import numpy as np
import scipy.io as sio
from plotter import Plotter

class Mapper:

    #: Paths
    DATADIR = '../../Data'
    SCOREDIR = None

    #: List of subjects
    subjects = None

    #: Data paramters
    backbone = None
    featureset = None
    distance = None
    suffix = None
    scope = None
    threshold = None

    #: Mapper parameters
    nareas = 49
    nlayers = 9

    def __init__(self, backbone, featureset, distance, suffix, scope, threshold):
        self.backbone = backbone
        self.featureset = featureset
        self.distance = distance
        self.suffix = suffix
        self.scope = scope
        self.threshold threshold
        self.SCOREDIR = '%s/Intracranial/Probe_to_Layer_Maps/%s_%s.%s%s.%s%s' % (self.DATADIR, self.backbone, self.featureset, self.distance, self.suffix, self.scope, ('%.10f' % self.threshold)[2:].rstrip('0'))
        self.subjects = os.listdir('%s/Intracranial/Processed/%s/' % (self.DATADIR, self.featureset))

    def _collect_scores(self):
        allscores = {}
        for sfile in self.subjects:
            s = sio.loadmat('%s/Intracranial/Processed/%s/%s' % (self.DATADIR, featureset, sfile))
            sname = s['s']['name'][0][0][0]
            areas = np.ravel(s['s']['probes'][0][0][0][0][3])
            scores = np.loadtxt('%s/%s.txt' % (self.SCOREDIR, sname))
            allscores[sname] = {'scores': scores, 'areas': areas}
        return allscores

    def compute_and_plot_area_mapping(self):

        # load the correlation scores
        scores = self._collect_scores()

        # prepare matices to store resutls
        score_per_arealayer = np.zeros((self.nareas, self.nlayers))
        n_sig_per_arealayer = np.zeros((self.nareas, self.nlayers))
        n_tot_per_arealayer = np.zeros((self.nareas, self.nlayers))

        # aggregate scores over all subjects
        for sname in scores.keys():
            for aid in range(self.nareas):
                
                if len(scores[sname][scores[sname]['areas'] == aid]) == 0:
                    continue

                for lid in range(nlayers):
                    sig_score = np.sum(scores[sname][scores[sname]['areas'] == aid, lid])
                    sig_count = np.sum(scores[sname][scores[sname]['areas'] == aid, lid] > 0.0)
                    tot_count = len(scores[sname][scores[sname]['areas'] == aid, lid])
                    score_per_arealayer[aid, lid] += sig_score
                    n_sig_per_arealayer[aid, lid] += sig_count
                    n_tot_per_arealayer[aid, lid] += tot_count

        # normalize by the number of significant probes in an area
        score_per_arealayer_normalized = score_per_arealayer / n_sig_per_arealayer
        score_per_arealayer_normalized = np.nan_to_num(score_per_arealayer_normalized)

        # plot
        plotter = ()
        filename = '../../Outcome/Mapper/%s_%s.%s%s.%s%s.png' % (self.backbone, self.featureset, self.distance, self.suffix, self.scope, ('%.10f' % self.threshold)[2:].rstrip('0'))
        plotter.xlayer_yarea_zscore(filename, self.nareas, self.nlayers, n_sig_per_arealayer, n_tot_per_arealayer, score_per_arealayer_normalized)


if __name__ == '__main__':

def __init__(self, backbone, featureset, distance, suffix, scope, threshold):

    parser = argparse.ArgumentParser(description='Map areas to layers and plot aggregated scoring heatmap')
    parser.add_argument('-b', '--backbone', dest='backbone', type=str, required=True, help='rsa or linear')
    parser.add_argument('-f', '--featureset', dest='featureset', type=str, required=True, help='Directory with brain features (Processed/?)')
    parser.add_argument('-d', '--distance', dest='distance', type=str, required=True, help='The distance metric to use')
    parser.add_argument('-o', '--onwhat', dest='onwhat', type=str, required=True, help='image or matrix depending on which you to compute the correlation on')
    parser.add_argument('-t', '--threshold', dest='threshold', type=float, required=True, help='Significance level a score must have to be counter (1.0 to store all)')
    
    args = parser.parse_args()
    backbone = bool(args.backbone)
    featureset = str(args.featureset)
    distance = str(args.distance)
    onwhat = str(args.onwhat)
    threshold = float(args.threshold)

    mapper = Mapper(featureset, distance, sid, onwhat, threshold)
    mapper.compute_and_plot_area_mapping()
