import os
import argparse
import numpy as np
import scipy.io as sio
from Plotter import Plotter

class Mapper:

    #: Paths
    DATADIR = '../../Data'
    SCOREDIR = None
    PERMDIR = None

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

        if self.backbone == 'rsa':
            self.SCOREDIR = '%s/Intracranial/Probe_to_Layer_Maps/%s_%s.%s%s.%s%s' % (self.DATADIR, self.backbone, self.featureset, self.distance, self.suffix, self.scope, ('%.10f' % self.threshold)[2:].rstrip('0'))
            self.PERMDIR = '%s/Intracranial/Probe_to_Layer_Maps/Permutation/%s_%s.%s%s.%s%s' % (self.DATADIR, self.backbone, self.featureset, self.distance, self.suffix, self.scope, ('%.10f' % self.threshold)[2:].rstrip('0'))
        elif self.backbone == 'lp':
            self.SCOREDIR = '%s/Intracranial/Probe_to_Layer_Maps/%s_%s' % (self.DATADIR, self.backbone, self.featureset)
            self.PERMDIR = None
        else:
            raise Exception('Unknown backbone %s' % self.backbone)
        self.subjects = os.listdir('%s/Intracranial/Processed/%s/' % (self.DATADIR, self.featureset))
    
    def _collect_scores(self):
        allscores = {}
        for sfile in self.subjects:
            s = sio.loadmat('%s/Intracranial/Processed/%s/%s' % (self.DATADIR, self.featureset, sfile))
            sname = s['s']['name'][0][0][0]
            areas = np.ravel(s['s']['probes'][0][0][0][0][3])
            scores = np.loadtxt('%s/%s.txt' % (self.SCOREDIR, sname))
            if len(areas) == 0 or len(scores) == 0:
                scores = None
            else:
                scores = scores.reshape((len(areas), self.nlayers))
            allscores[sname] = {'scores': scores, 'areas': areas}
        return allscores

    def _compute_pvals(self):

        # obtain true scores
        scores = self._collect_scores()

        # compute p-values based on permutation scores
        pvals = {}
        for sfile in self.subjects:
            
            # load the user data
            s = sio.loadmat('%s/Intracranial/Processed/%s/%s' % (self.DATADIR, self.featureset, sfile))
            sname = s['s']['name'][0][0][0]
            areas = np.ravel(s['s']['probes'][0][0][0][0][3])

            # check that this user has any probes
            if scores[sname]['scores'] is None:
                pvals[sname] = None
                continue
            
            # compute pvalues for this users's probes
            pvals[sname] = np.ones(scores[sname]['scores'].shape)
            for pid in range(len(areas)):
                print 'Processing %s probe %d' % (sname, pid)
                permutation_scores = np.loadtxt('%s/%s-%d.txt' % (self.PERMDIR, sname, pid))
                pvals[sname][pid] = np.sum(permutation_scores >= scores[sname]['scores'][pid], axis=0) / float(permutation_scores.shape[0])

        return pvals

    def compute_and_plot_area_mapping(self, filter_by_permutation=False):

        # load the correlation scores
        scores = self._collect_scores()

        # compute pvalues if filtering my permutataion test is requested
        if filter_by_permutation:
            pvals = self._compute_pvals()

        # prepare matices to store resutls
        score_per_arealayer = np.zeros((self.nareas, self.nlayers))
        n_sig_per_area = np.zeros(self.nareas)
        n_tot_per_area = np.zeros(self.nareas)

        # aggregate scores over all subjects
        for sname in scores.keys():

            # skip subjects with no probes
            if scores[sname]['scores'] is None:
                continue

            # filter scores by permutation test results
            if filter_by_permutation:
                scores[sname]['scores'] = scores[sname]['scores'] * (pvals[sname] <= 0.00001)

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

        #if self.statistic == 'corr':
        #    pass
        #elif self.statistic == 'varexp':
        #    score_per_arealayer *= 100
        #else:
        #    raise Exception('Unknown statistic %s' % self.statistic)

        # normalize by the number of significant probes in an area
        score_per_arealayer_normalized = score_per_arealayer / np.tile(n_sig_per_area, (self.nlayers, 1)).T
        score_per_arealayer_normalized[np.isinf(score_per_arealayer_normalized)] = 0.0
        score_per_arealayer_normalized = np.nan_to_num(score_per_arealayer_normalized)

        # add suffix to the file name if filtered by permutation test results
        permfiltered = 'permfiltered' if filter_by_permutation else ''

        # different filenames for different scoring backbone methods
        if self.backbone == 'rsa':
            filename = '../../Outcome/Mapper/%s_%s.%s%s.%s%s%s.png' % (self.backbone, self.featureset, self.distance, self.suffix, self.scope, ('%.10f' % self.threshold)[2:].rstrip('0'), permfiltered)
        elif self.backbone == 'lp':
            filename = '../../Outcome/Mapper/%s_%s%s.png' % (self.backbone, self.featureset, permfiltered)
        else:
            raise Exception('Unknown backbone %s' % self.backbone)

        # generate and store plot
        Plotter.xlayer_yarea_zscore(filename, self.nareas, self.nlayers, n_sig_per_area, n_tot_per_area, score_per_arealayer_normalized)


if __name__ == '__main__':

    parser = argparse.ArgumentParser(description='Map areas to layers and plot aggregated scoring heatmap')
    parser.add_argument('-b', '--backbone', dest='backbone', type=str, required=True, help='rsa or linear')
    parser.add_argument('-f', '--featureset', dest='featureset', type=str, required=True, help='Directory with brain features (Processed/?)')
    parser.add_argument('-d', '--distance', dest='distance', type=str, required=False, help='The distance metric to use')
    parser.add_argument('-o', '--onwhat', dest='onwhat', type=str, required=False, help='image or matrix depending on which you to compute the correlation on')
    parser.add_argument('-t', '--threshold', dest='threshold', type=float, required=False, help='Significance level a score must have to be counter (1.0 to store all)')
    parser.add_argument('-s', '--statistic', dest='statistic', type=str, required=True, help='Type of score to compute when aggregating: varexp, corr')
    parser.add_argument('-p', '--permfilter', dest='permfilter', type=str, required=True, help='Whether to filter the results with permutation test results')
    args = parser.parse_args()

    # check conditional requirements
    if args.backbone == 'rsa':
        if args.distance is None or args.onwhat is None or args.threshold is None:
            parser.error('arguments -d, -o and -t are required with "-b rsa"')
    
    # parse values
    backbone = str(args.backbone)
    featureset = str(args.featureset)
    distance = str(args.distance)
    onwhat = str(args.onwhat)
    threshold = float(args.threshold) if args.threshold is not None else None
    statistic = str(args.statistic)
    suffix = ''
    permfilter = bool(args.permfilter == 'True')

    # initialize and run the mapper
    mapper = Mapper(backbone, featureset, distance, suffix, onwhat, threshold, statistic)
    mapper.compute_and_plot_area_mapping(permfilter)

    print 'All done.'
