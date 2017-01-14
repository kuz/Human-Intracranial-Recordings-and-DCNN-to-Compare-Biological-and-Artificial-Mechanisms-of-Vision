import os
import argparse
import cPickle
import numpy as np
import scipy.io as sio
from Plotter import Plotter
from scipy.stats import spearmanr

class Mapper:

    #: Paths
    DATADIR = '../../Data'
    SCOREDIR = None
    PERMDIR = None
    OUTDIR = '../../Outcome'

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
        print 'Initialized Mapper with:'
        print '\tSCOREDIR %s' % self.SCOREDIR

    def _collect_scores(self):
        allscores = {}
        for sfile in self.subjects:
            s = sio.loadmat('%s/Intracranial/Processed/%s/%s' % (self.DATADIR, self.featureset, sfile))
            sname = s['s']['name'][0][0][0]
            areas = np.ravel(s['s']['probes'][0][0][0][0][3])
            mni = s['s']['probes'][0][0][0][0][2]
            scores = np.loadtxt('%s/%s.txt' % (self.SCOREDIR, sname))
            if len(areas) == 0 or len(scores) == 0:
                scores = None
            else:
                scores = scores.reshape((len(areas), self.nlayers))
            allscores[sname] = {'scores': scores, 'areas': areas, 'mni': mni}
        return allscores

    def _compute_pvals(self):

        # if p-value for this experiment were computed before -- reuse them
        try:
            with open('%s_pvals.pkl' % self.PERMDIR, 'rb') as infile:
                pvals = cPickle.load(infile)
            print 'NOTICE: Reusing previously computed p-values'
            return pvals
        except:
            pass

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
                print 'Computing p-value for subject %s probe %d' % (sname, pid)
                #permutation_scores = np.loadtxt('%s/%s-%d.txt' % (self.PERMDIR, sname, pid))
                permutation_scores = np.genfromtxt('%s/%s-%d.txt' % (self.PERMDIR, sname, pid))
                pvals[sname][pid] = np.sum(permutation_scores >= scores[sname]['scores'][pid], axis=0) / float(permutation_scores.shape[0])

        # store computed p-values for future runs
        with open('%s_pvals.pkl' % self.PERMDIR, 'wb') as outfile:
            cPickle.dump(pvals, outfile)

        return pvals

    def compute_and_plot_area_mapping(self, filter_by_permutation=False, only_visual=False):

        # load the correlation scores
        scores = self._collect_scores()

        # compute pvalues if filtering my permutataion test is requested
        if filter_by_permutation:
            pvals = self._compute_pvals()

        # prepare matices to store resutls
        score_per_arealayer = np.zeros((self.nareas, self.nlayers))
        n_sig_per_area = np.zeros(self.nareas)
        n_tot_per_area = np.zeros(self.nareas)
        n_per_arealayer = np.zeros((self.nareas, self.nlayers))

        single_scores = {}
        for aid in range(self.nareas):
            for lid in range(self.nlayers):
                single_scores[(aid, lid)] = []

        # aggregate scores over all subjects
        for sname in scores.keys():

            # skip subjects with no probes
            if scores[sname]['scores'] is None:
                continue

            # filter scores by permutation test results
            if filter_by_permutation:
                scores[sname]['scores'] = scores[sname]['scores'] * (pvals[sname] <= 0.001)

            for aid in range(self.nareas):
                
                # skip an area if there were no probes in it
                if len(scores[sname]['scores'][scores[sname]['areas'] == aid]) == 0:
                    continue

                # count total number of probes in the area
                n_tot_per_area[aid] += len(scores[sname]['scores'][scores[sname]['areas'] == aid])

                # count number of significant probes in the area
                n_sig_per_area[aid] += np.sum(np.sum(scores[sname]['scores'][scores[sname]['areas'] == aid], axis=1) > 0.0)

                for lid in range(self.nlayers):

                    n_per_arealayer[aid, lid] += np.sum(scores[sname]['scores'][scores[sname]['areas'] == aid, lid] > 0.0)

                    if self.statistic == 'corr':
                        sig_score = np.sum(scores[sname]['scores'][scores[sname]['areas'] == aid, lid])
                    elif self.statistic == 'varexp':
                        sig_score = np.sum(scores[sname]['scores'][scores[sname]['areas'] == aid, lid] ** 2)
                    else:
                        raise Exception('Unknown statistic %s' % self.statistic)
                    score_per_arealayer[aid, lid] += sig_score

                    if sig_score > 0.0:
                        single_scores[(aid, lid)].append(sig_score)

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
            filename = '%s_%s.%s%s.%s%s%s.png' % (self.backbone, self.featureset, self.distance, self.suffix, self.scope, ('%.10f' % self.threshold)[2:].rstrip('0'), permfiltered)
        elif self.backbone == 'lp':
            filename = '%s_%s%s.png' % (self.backbone, self.featureset, permfiltered)
        else:
            raise Exception('Unknown backbone %s' % self.backbone)

        #
        # Stats
        #

        # diagonality with weighed spearman
        visual_areas = [17, 18, 19, 37, 29]
        areas = []
        layers = []
        weights = []
        for a, aid in enumerate(visual_areas):
            for lid in range(self.nlayers):
                for s in single_scores[(aid, lid)]:
                    areas.append(a)
                    layers.append(lid)
                    weights.append(s)

        print areas
        print layers
        print weights

        exit()

        # diagonality
        #visual_areas = [17, 18, 19, 37, 29]
        #n_per_visual = n_per_arealayer[visual_areas, :]
        #score_per_visual_normalized = score_per_arealayer_normalized[visual_areas, :]
        #areas = []
        #layers = []
        #for a in range(len(visual_areas)):
        #    for l in range(self.nlayers):
        #        for c in range(int(n_per_visual[a, l])):
        #            areas.append(a)
        #            layers.append(l)
        #diagonality = spearmanr(areas, layers)
        #title = 'Diagonality: %.4f (p-value: %.5f)' % (diagonality[0], diagonality[1]) 
        #print title

        # visual volume
        #volume = np.ravel(np.sum(score_per_arealayer_normalized, 1)) * n_sig_per_area
        #visual_areas = [17, 18, 19, 37, 29]
        #visual_volume = np.sum(volume[visual_areas])

        # specifity to visual areas
        #total_volume = np.sum(volume)
        #specificity_to_visual = visual_volume / total_volume

        # log ratio high-layer to low-layers
        #high_visual_volume = np.sum(score_per_arealayer_normalized[visual_areas][:, [5,6,7]])
        #low_visual_volume = np.sum(score_per_arealayer_normalized[visual_areas][:, [1,2,3]])
        #logratio = np.log(high_visual_volume / low_visual_volume)

        #print 'Visual volume:      %.4f' % visual_volume
        #print 'Visual specificity: %.4f' % specificity_to_visual
        #print 'High/low logratio:  %.4f' % logratio

        # log ratio per area
        #print '\t17: %.4f' % np.log(np.sum(score_per_arealayer_normalized[17, [5,6,7]]) / np.sum(score_per_arealayer_normalized[17, [1,2,3]]))
        #print '\t18: %.4f' % np.log(np.sum(score_per_arealayer_normalized[18, [5,6,7]]) / np.sum(score_per_arealayer_normalized[18, [1,2,3]]))
        #print '\t19: %.4f' % np.log(np.sum(score_per_arealayer_normalized[19, [5,6,7]]) / np.sum(score_per_arealayer_normalized[19, [1,2,3]]))
        #print '\t37: %.4f' % np.log(np.sum(score_per_arealayer_normalized[37, [5,6,7]]) / np.sum(score_per_arealayer_normalized[37, [1,2,3]]))
        #print '\t20: %.4f' % np.log(np.sum(score_per_arealayer_normalized[20, [5,6,7]]) / np.sum(score_per_arealayer_normalized[20, [1,2,3]]))
        
        # volume per area
        #print '\t17: %.4f' % np.sum(volume[17])
        #print '\t18: %.4f' % np.sum(volume[18])
        #print '\t19: %.4f' % np.sum(volume[19])
        #print '\t37: %.4f' % np.sum(volume[37])
        #print '\t20: %.4f' % np.sum(volume[20])

        # visual specificity per layer
        #specificity_to_visual_per_layer = np.sum(score_per_arealayer_normalized[visual_areas], 0) / np.sum(score_per_arealayer_normalized, 0)
        #for l in range(self.nlayers):
        #    print 'L%d: %.4f' % (l, specificity_to_visual_per_layer[l])

        # visual volume per layer
        #visual_scores = score_per_arealayer_normalized[visual_areas, :]
        #visual_layer_volume = np.sum(visual_scores, 0)
        #for l in range(self.nlayers):
        #    print 'L%d: %.4f' % (l, visual_layer_volume[l])

        # generate and store plot
        if only_visual:
            filename = 'visual_' + filename
            Plotter.xlayer_yarea_zscore_visual_linfit('%s/Mapper/%s' % (self.OUTDIR, filename), self.nareas, self.nlayers,
                                                      n_sig_per_area, n_tot_per_area, score_per_arealayer_normalized, title)
        else:
            Plotter.xlayer_yarea_zscore('%s/Mapper/%s' % (self.OUTDIR, filename), self.nareas, self.nlayers,
                                        n_sig_per_area, n_tot_per_area, score_per_arealayer_normalized, title)

    def compute_and_plot_single_mni_score(self, filter_by_permutation=False):

        # load the correlation scores
        scores = self._collect_scores()

        # compute pvalues if filtering my permutataion test is requested
        if filter_by_permutation:
            pvals = self._compute_pvals()

        # collect all probes into a matrix with each row having [2nd MNI, layer, rho]
        allprobes = np.zeros((0, 3))
        for sname in scores:
            for pid in range(len(scores[sname]['areas'])):
                if scores[sname]['areas'][pid] in [17, 18, 19, 37, 20]:
                    for lid in range(self.nlayers):
                        if not filter_by_permutation or pvals[sname][pid, lid] <= 0.001:
                            record = np.array([scores[sname]['mni'][pid, 1], lid, scores[sname]['scores'][pid, lid]**2]).reshape((1, 3))
                            allprobes = np.concatenate((allprobes, record))

        # drop record with static being 0
        allprobes = allprobes[allprobes[:, 2] != 0]

        # sort probes by sagittalcoordinate
        allprobes = allprobes[allprobes[:,0].argsort()]

        # generate and store plot
        permfiltered = 'permfiltered' if filter_by_permutation else ''
        filename = '%s/Mapper/single_xmni_yscore_%s_%s%s' % (self.OUTDIR, self.backbone, self.featureset, permfiltered)
        Plotter.xmni_yscore(filename, self.nlayers, allprobes)
        filename = '%s/Mapper/single_hist_xmni_yscore_%s_%s%s' % (self.OUTDIR, self.backbone, self.featureset, permfiltered)
        Plotter.hist_xmni_yvarexp(filename, self.nlayers, allprobes)


if __name__ == '__main__':

    parser = argparse.ArgumentParser(description='Map areas to layers and plot aggregated scoring heatmap')
    parser.add_argument('-b', '--backbone', dest='backbone', type=str, required=True, help='rsa or linear')
    parser.add_argument('-f', '--featureset', dest='featureset', type=str, required=True, help='Directory with brain features (Processed/?)')
    parser.add_argument('-d', '--distance', dest='distance', type=str, required=False, help='The distance metric to use')
    parser.add_argument('-o', '--onwhat', dest='onwhat', type=str, required=False, help='image or matrix depending on which you to compute the correlation on')
    parser.add_argument('-t', '--threshold', dest='threshold', type=float, required=False, help='Significance level a score must have to be counter (1.0 to store all)')
    parser.add_argument('-s', '--statistic', dest='statistic', type=str, required=True, help='Type of score to compute when aggregating: varexp, corr')
    parser.add_argument('-p', '--permfilter', dest='permfilter', type=str, required=True, help='Whether to filter the results with permutation test results')
    parser.add_argument('-g', '--graph', dest='graph', type=str, required=True, help='Which graph to output: layer_area_score, mni_score, mni_layer')
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
    graph = str(args.graph)

    # initialize and run the mapper
    mapper = Mapper(backbone, featureset, distance, suffix, onwhat, threshold, statistic)
    if graph == 'layer_area_score':
        mapper.compute_and_plot_area_mapping(permfilter, only_visual=False)
    elif graph == 'layer_area_score_visual':
        mapper.compute_and_plot_area_mapping(permfilter, only_visual=True)
    elif graph == 'mni_score':
        mapper.compute_and_plot_single_mni_score(permfilter)
    elif graph == 'mni_layer':
        mapper.compute_and_plot_single_mni_layer(permfilter)
    else:
        raise Exception('Unknown graph %s' % graph)



    print 'All done.'
