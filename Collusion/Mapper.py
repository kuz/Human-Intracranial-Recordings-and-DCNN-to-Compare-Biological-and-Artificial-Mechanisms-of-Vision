import os
import argparse
import numpy as np
import scipy.io as sio
from Plotter import Plotter

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
    statistic = None

    #: Mapper parameters
    nareas = 49
    nlayers = 9

    def __init__(self, backbone, featureset, distance, suffix, scope, threshold, statistic):
        self.backbone = backbone
        self.featureset = featureset
        self.distance = distance
        self.suffix = suffix
        self.scope = scope
        self.threshold = threshold
        self.statistic = statistic

        self.SCOREDIR = '%s/Intracranial/Probe_to_Layer_Maps/%s_%s.%s%s.%s%s' % (self.DATADIR, self.backbone, self.featureset, self.distance, self.suffix, self.scope, ('%.10f' % self.threshold)[2:].rstrip('0'))
        self.subjects = os.listdir('%s/Intracranial/Processed/%s/' % (self.DATADIR, self.featureset))
    
    def _collect_scores(self):
        allscores = {}
        for sfile in self.subjects:
            s = sio.loadmat('%s/Intracranial/Processed/%s/%s' % (self.DATADIR, featureset, sfile))
            sname = s['s']['name'][0][0][0]
            areas = np.ravel(s['s']['probes'][0][0][0][0][3])
            if len(areas) == 0:
                scores = None
            else:
                scores = np.loadtxt('%s/%s.txt' % (self.SCOREDIR, sname))
                scores = scores.reshape((len(areas), self.nlayers))
            allscores[sname] = {'scores': scores, 'areas': areas}
        return allscores

    def compute_and_plot_area_mapping(self):

        # load the correlation scores
        scores = self._collect_scores()

        # prepare matices to store resutls
        score_per_arealayer = np.zeros((self.nareas, self.nlayers))
        n_sig_per_area = np.zeros(self.nareas)
        n_tot_per_area = np.zeros(self.nareas)

        # aggregate scores over all subjects
        for sname in scores.keys():

            # skip subjects with no probes
            if scores[sname]['scores'] is None:
                continue

            for aid in range(self.nareas):
                
                # skip an area if there were no probes in it
                if len(scores[sname]['scores'][scores[sname]['areas'] == aid]) == 0:
                    continue

                # count total number of probes in the area
                n_tot_per_area[aid] += len(scores[sname]['scores'][scores[sname]['areas'] == aid])

                # count number of significant probes in the area
                n_sig_per_area[aid] += np.sum(np.sum(scores[sname]['scores'][scores[sname]['areas'] == aid], axis=1) > 0.0)

                for lid in range(self.nlayers):
                    if self.statistic == 'corr':
                        sig_score = np.sum(scores[sname]['scores'][scores[sname]['areas'] == aid, lid])
                    elif self.statistic == 'varexp':
                        sig_score = np.sum(scores[sname]['scores'][scores[sname]['areas'] == aid, lid] ** 2)
                    else:
                        raise Exception('Unknown statistic %s' % self.statistic)
                    score_per_arealayer[aid, lid] += sig_score

        if self.statistic == 'corr':
            pass
        elif self.statistic == 'varexp':
            score_per_arealayer *= 100
        else:
            raise Exception('Unknown statistic %s' % self.statistic)

        # normalize by the number of significant probes in an area
        score_per_arealayer_normalized = score_per_arealayer / np.tile(n_sig_per_area, (self.nlayers, 1)).T
        score_per_arealayer_normalized[np.isinf(score_per_arealayer_normalized)] = 0.0
        score_per_arealayer_normalized = np.nan_to_num(score_per_arealayer_normalized)

        # plot
        filename = '../../Outcome/Mapper/%s_%s.%s%s.%s%s.png' % (self.backbone, self.featureset, self.distance, self.suffix, self.scope, ('%.10f' % self.threshold)[2:].rstrip('0'))
        Plotter.xlayer_yarea_zscore(filename, self.nareas, self.nlayers, n_sig_per_area, n_tot_per_area, score_per_arealayer_normalized)


if __name__ == '__main__':

    parser = argparse.ArgumentParser(description='Map areas to layers and plot aggregated scoring heatmap')
    parser.add_argument('-b', '--backbone', dest='backbone', type=str, required=True, help='rsa or linear')
    parser.add_argument('-f', '--featureset', dest='featureset', type=str, required=True, help='Directory with brain features (Processed/?)')
    parser.add_argument('-d', '--distance', dest='distance', type=str, required=True, help='The distance metric to use')
    parser.add_argument('-o', '--onwhat', dest='onwhat', type=str, required=True, help='image or matrix depending on which you to compute the correlation on')
    parser.add_argument('-t', '--threshold', dest='threshold', type=float, required=True, help='Significance level a score must have to be counter (1.0 to store all)')
    parser.add_argument('-s', '--statistic', dest='statistic', type=str, required=True, help='Type of score to compute when aggregating: varexp, corr')
    
    args = parser.parse_args()
    backbone = str(args.backbone)
    featureset = str(args.featureset)
    distance = str(args.distance)
    onwhat = str(args.onwhat)
    threshold = float(args.threshold)
    statistic = str(args.statistic)
    suffix = ''

    mapper = Mapper(backbone, featureset, distance, suffix, onwhat, threshold, statistic)
    mapper.compute_and_plot_area_mapping()
