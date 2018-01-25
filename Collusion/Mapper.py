import os
import argparse
import cPickle
import numpy as np
import scipy.io as sio
import random
from Plotter import Plotter
from scipy.stats import spearmanr
from scipy.stats import mannwhitneyu
from IPython import embed

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

    def __init__(self, backbone, featureset, distance, suffix, scope, threshold, statistic, network):
        self.backbone = backbone
        self.featureset = featureset
        self.distance = distance
        self.suffix = suffix
        self.scope = scope
        self.threshold = threshold
        self.statistic = statistic
        self.network = network


        if self.backbone == 'rsa':
            self.SCOREDIR = '%s/Intracranial/Probe_to_Layer_Maps/%s_%s.%s%s.%s.%s%s' % (self.DATADIR, self.backbone, self.featureset, self.distance, self.suffix, self.network, self.scope, ('%.10f' % self.threshold)[2:].rstrip('0'))
            self.PERMDIR = '%s/Intracranial/Probe_to_Layer_Maps/Permutation/%s_%s.%s%s.%s.%s%s' % (self.DATADIR, self.backbone, self.featureset, self.distance, self.suffix, self.network, self.scope, ('%.10f' % self.threshold)[2:].rstrip('0'))
        elif self.backbone == 'lp':
            self.SCOREDIR = '%s/Intracranial/Probe_to_Layer_Maps/%s_%s' % (self.DATADIR, self.backbone, self.featureset)
            self.PERMDIR = None
        else:
            raise Exception('Unknown backbone %s' % self.backbone)
        self.subjects = sorted(os.listdir('%s/Intracranial/Processed/%s/' % (self.DATADIR, self.featureset)))
        print 'SCOREDIR: %s' % self.SCOREDIR

    def _collect_scores(self):
        allscores = {}
        nprobes = 0
        nprobes_in17 = 0
        for sfile in self.subjects:
            s = sio.loadmat('%s/Intracranial/Processed/%s/%s' % (self.DATADIR, self.featureset, sfile))
            sname = s['s']['name'][0][0][0]
            areas = np.ravel(s['s']['probes'][0][0][0][0][3])
            mni = s['s']['probes'][0][0][0][0][2]
            nprobes += mni.shape[0]
            nprobes_in17 += np.sum(areas == 17)
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

        
        # prepare matices to store results
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


        #
        # Stats
        #
        stats = {}
        visual_areas = [17, 18, 19, 37, 20]

        # normalize scores by the number of significant probes in an area
        score_per_arealayer_normalized = score_per_arealayer / np.tile(n_sig_per_area, (self.nlayers, 1)).T
        score_per_arealayer_normalized[np.isinf(score_per_arealayer_normalized)] = 0.0
        score_per_arealayer_normalized = np.nan_to_num(score_per_arealayer_normalized)


        #
        # Global stats
        #

        # diagonality
        n_per_visual = n_per_arealayer[visual_areas, :]
        score_per_visual_normalized = score_per_arealayer_normalized[visual_areas, :]
        areas = []
        layers = []
        for a in range(len(visual_areas)):
            for l in range(self.nlayers):
                for c in range(int(n_per_visual[a, l])):
                    areas.append(a)
                    layers.append(l)
        diagonality = spearmanr(areas, layers)
        stats['alignment'] = {'rho': diagonality[0], 'pval': diagonality[1]}
        title = 'Alignment: %.4f (p-value: %.5f)' % (diagonality[0], diagonality[1]) 

        # volume
        volume = np.sum(score_per_arealayer, 1)
        volume_normalized = volume / n_tot_per_area
        volume_normalized[np.isnan(volume_normalized)] = 0.0
        visual_volume = np.sum(score_per_arealayer[visual_areas], 1)
        visual_volume_normalized = visual_volume / n_tot_per_area[visual_areas]
        visual_volume_normalized[np.isnan(visual_volume_normalized)] = 0.0
        stats['volume'] = {'allareas': {'normalized': volume_normalized, 'absolute': volume},
                           'visual': {'normalized': visual_volume_normalized, 'absolute': visual_volume}}

        # specifity to visual areas
        specificity_to_visual = np.sum(visual_volume) / np.sum(volume)
        stats['visual_specifity'] = specificity_to_visual

        """
        # gamma in convolutional vs. theta-alpha-beta in fully connected
        convs = np.ravel(score_per_visual_normalized[:, [1,2,3,4,5]])
        convs = convs[convs > 0.0]
        fcs = np.ravel(score_per_visual_normalized[:, [6,7]])
        fcs = fcs[fcs > 0.0]
        print 'FC Volume', np.sum(fcs)
        print 'Conv Volume', np.sum(convs)
        """


        # 
        # per Area stats
        #
        stats['per_area'] = {'hhl_ratio': {}, 'volume': {}}
        
        for a in visual_areas:

            # high / (high + low) ratio
            high_visual_volume = np.sum(score_per_arealayer_normalized[a, [5,6,7]])
            low_visual_volume = np.sum(score_per_arealayer_normalized[a, [1,2,3]])
            ratio = high_visual_volume / float(high_visual_volume + low_visual_volume)
            if np.isnan(ratio): ratio = 0.0
            stats['per_area']['hhl_ratio'][a] = ratio

            # volume
            stats['per_area']['volume'][a] = np.sum(volume[a])

        #
        # per Layer stats
        #
        stats['per_layer'] = {'volume': np.sum(score_per_visual_normalized, 0),
                              'specificity': np.sum(score_per_visual_normalized, 0) / np.sum(score_per_arealayer_normalized, 0)}
        
        #
        # Figure
        #

        # add suffix to the file name if filtered by permutation test results
        permfiltered = 'permfiltered' if filter_by_permutation else ''

        # different filenames for different scoring backbone methods
        if self.backbone == 'rsa':
            filename = '%s_%s.%s%s.%s.%s%s%s' % (self.backbone, self.featureset, self.distance, self.suffix, self.network, self.scope, ('%.10f' % self.threshold)[2:].rstrip('0'), permfiltered)
        elif self.backbone == 'lp':
            filename = '%s_%s%s' % (self.backbone, self.featureset, permfiltered)
        else:
            raise Exception('Unknown backbone %s' % self.backbone)

        # store stats
        np.save('%s/Statistics/%s.npy' % (self.OUTDIR, filename), stats)

        # store plots
        Plotter.xlayer_yarea_zscore_visual('%s/Mapper/visual_%s.png' % (self.OUTDIR, filename), self.nareas, self.nlayers, n_sig_per_area, n_tot_per_area, score_per_arealayer_normalized, title)
        Plotter.xlayer_yarea_zscore('%s/Mapper/%s.png' % (self.OUTDIR, filename), self.nareas, self.nlayers, n_sig_per_area, n_tot_per_area, score_per_arealayer_normalized, title)
        #if only_visual:
        #    filename = 'visual_' + filename
        #    Plotter.xlayer_yarea_zscore_visual('%s/Mapper/%s.png' % (self.OUTDIR, filename), self.nareas, self.nlayers, n_sig_per_area, n_tot_per_area, score_per_arealayer_normalized, title)
        #else:
        #    Plotter.xlayer_yarea_zscore('%s/Mapper/%s.png' % (self.OUTDIR, filename), self.nareas, self.nlayers, n_sig_per_area, n_tot_per_area, score_per_arealayer_normalized, title)


    def compute_area_mapping_noise_estimate(self, filter_by_permutation=False, nruns=1000):
        '''
        Estimates the noise of the alignment measurement by splitting each subject's probeset in 2 halves, computing
        alignment score for each half separately, repeating this operation N times and reporting average alignment score
        and standard error
        '''

        # load the correlation scores
        scores = self._collect_scores()

        # compute pvalues if filtering my permutataion test is requested
        if filter_by_permutation:
            pvals = self._compute_pvals()
        
        # collect statistics over several runs
        one_half_alignments = []
        two_half_alignments = []
        one_half_pvals = []
        two_half_pvals = []
        for r in range(nruns):

            # aggregate scores over all subjects
            one_half_counter = np.array([0, 0, 0, 0, 0])
            two_half_counter = np.array([0, 0, 0, 0, 0])
            one_half_n_per_arealayer = np.zeros((self.nareas, self.nlayers))
            two_half_n_per_arealayer = np.zeros((self.nareas, self.nlayers))

            for sname in random.sample(scores.keys(), len(scores.keys())):

                # which half is to be balanced out by adding this subject's probes
                probes_in_visual_areas = []
                for va in [17, 18, 19, 37, 20]:
                    probes_in_visual_areas.append(np.sum(scores[sname]['areas'] == va))
                add_to_one_dist = np.sum(np.abs(one_half_counter - two_half_counter + probes_in_visual_areas))
                add_to_two_dist = np.sum(np.abs(two_half_counter - one_half_counter + probes_in_visual_areas))
                add_to_one = False
                if add_to_one_dist < add_to_two_dist:
                    add_to_one = True

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

                    for lid in range(self.nlayers):
                        if add_to_one:
                            one_half_n_per_arealayer[aid, lid] += np.sum(scores[sname]['scores'][scores[sname]['areas'] == aid, lid] > 0.0)
                        else:
                            two_half_n_per_arealayer[aid, lid] += np.sum(scores[sname]['scores'][scores[sname]['areas'] == aid, lid] > 0.0)

                if add_to_one:
                    one_half_counter += probes_in_visual_areas
                else:
                    two_half_counter += probes_in_visual_areas

            # compute alignment
            visual_areas = [17, 18, 19, 37, 20]
            n_per_visual = one_half_n_per_arealayer[visual_areas, :]
            areas = []
            layers = []
            for a in range(len(visual_areas)):
                for l in range(self.nlayers):
                    for c in range(int(n_per_visual[a, l])):
                        areas.append(a)
                        layers.append(l)
            diagonality = spearmanr(areas, layers)
            one_half_alignments.append(diagonality[0])
            one_half_pvals.append(diagonality[1])

            n_per_visual = two_half_n_per_arealayer[visual_areas, :]
            areas = []
            layers = []
            for a in range(len(visual_areas)):
                for l in range(self.nlayers):
                    for c in range(int(n_per_visual[a, l])):
                        areas.append(a)
                        layers.append(l)
            diagonality = spearmanr(areas, layers)
            two_half_alignments.append(diagonality[0])
            two_half_pvals.append(diagonality[1])

        print ''
        print self.featureset
        print '------------------------------------------------'
        one_half_alignments = np.nan_to_num(one_half_alignments)
        two_half_alignments = np.nan_to_num(two_half_alignments)
        one_half_pvals = np.nan_to_num(one_half_pvals)
        two_half_pvals = np.nan_to_num(two_half_pvals)
        print 'Alignment: median %.4f, mean %.4f, std %.4f' % (np.median(one_half_alignments), np.mean(one_half_alignments), np.std(one_half_alignments))
        print 'p-value:   median %.4f, mean %.4f, std %.4f' % (np.median(one_half_pvals), np.mean(one_half_pvals), np.std(one_half_pvals))
        alignment_diffs = np.abs(np.array(one_half_alignments) - np.array(two_half_alignments))
        pval_diffs = np.abs(np.array(one_half_pvals) - np.array(two_half_pvals))
        print 'Alignment diff: median %.4f, mean %.4f, std %.4f' % (np.median(alignment_diffs), np.mean(alignment_diffs), np.std(alignment_diffs))
        print 'p-value   diff: median %.4f, mean %.4f, std %.4f' % (np.median(pval_diffs), np.mean(pval_diffs), np.std(pval_diffs))
        print ''
        
        np.savetxt('%s/Noisy estimates/%s_alignments_with_%s.txt' % (self.OUTDIR, self.featureset, self.network), one_half_alignments, fmt='%.12f')
        #np.savetxt('two_half_alignments.txt', two_half_alignments, fmt='%.12f')
        #np.savetxt('one_half_pvals.txt', one_half_pvals, fmt='%.12f')
        #np.savetxt('alignment_diffs.txt', alignment_diffs, fmt='%.12f')
        #np.savetxt('pval_diffs.txt', pval_diffs, fmt='%.12f')


    def compute_and_plot_area_mapping_per_subject(self, filter_by_permutation=False, only_visual=False):

        # load the correlation scores
        scores = self._collect_scores()

        # compute pvalues if filtering my permutataion test is requested
        if filter_by_permutation:
            pvals = self._compute_pvals()

        # aggregate scores over all subjects
        for sname in scores.keys():

            # prepare matices to store resutls
            score_per_arealayer = np.zeros((self.nareas, self.nlayers))
            n_sig_per_area = np.zeros(self.nareas)
            n_tot_per_area = np.zeros(self.nareas)
            n_per_arealayer = np.zeros((self.nareas, self.nlayers))

            single_scores = {}
            for aid in range(self.nareas):
                for lid in range(self.nlayers):
                    single_scores[(aid, lid)] = []

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

            # normalize by the number of significant probes in an area
            score_per_arealayer_normalized = score_per_arealayer / np.tile(n_sig_per_area, (self.nlayers, 1)).T
            score_per_arealayer_normalized[np.isinf(score_per_arealayer_normalized)] = 0.0
            score_per_arealayer_normalized = np.nan_to_num(score_per_arealayer_normalized)

            # add suffix to the file name if filtered by permutation test results
            permfiltered = 'permfiltered' if filter_by_permutation else ''

            # different filenames for different scoring backbone methods
            if self.backbone == 'rsa':
                filename = '%s_%s.%s%s.%s.%s%s%s' % (self.backbone, self.featureset, self.distance, self.suffix, self.network, self.scope, ('%.10f' % self.threshold)[2:].rstrip('0'), permfiltered)
            elif self.backbone == 'lp':
                filename = '%s_%s%s' % (self.backbone, self.featureset, permfiltered)
            else:
                raise Exception('Unknown backbone %s' % self.backbone)

            try:
                os.mkdir('%s/Mapper/Subject' % (self.OUTDIR))
            except:
                pass

            try:
                os.mkdir('%s/Mapper/Subject/%s' % (self.OUTDIR, self.featureset))
            except:
                pass

            # generate and store plot
            if only_visual:
                filename = 'visual_' + sname + '_' + filename
                Plotter.xlayer_yarea_zscore_visual('%s/Mapper/Subject/%s/%s.png' % (self.OUTDIR, self.featureset, filename), self.nareas, self.nlayers, n_sig_per_area, n_tot_per_area, score_per_arealayer_normalized, '')
            else:
                Plotter.xlayer_yarea_zscore('%s/Mapper/Subject/%s/%s.png' % (self.OUTDIR, self.featureset, filename), self.nareas, self.nlayers, n_sig_per_area, n_tot_per_area, score_per_arealayer_normalized, '')

    

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
    parser.add_argument('-n', '--network', dest='network', type=str, required=True, help='Activations of which DNN are used')
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
    network = str(args.network)

    # initialize and run the mapper
    mapper = Mapper(backbone, featureset, distance, suffix, onwhat, threshold, statistic, network)
    
    if graph == 'layer_area_score':
        mapper.compute_and_plot_area_mapping(permfilter, only_visual=False)
        #mapper.compute_and_plot_area_mapping_per_subject(permfilter, only_visual=False)
    
    elif graph == 'layer_area_score_visual':
        mapper.compute_and_plot_area_mapping_per_subject(permfilter, only_visual=True)
        #mapper.compute_and_plot_area_mapping(permfilter, only_visual=True)
    
    elif graph == 'area_mapping_noise_estimate':    
        mapper.compute_area_mapping_noise_estimate(permfilter)
    
    elif graph == 'mni_score':
        mapper.compute_and_plot_single_mni_score(permfilter)
    
    elif graph == 'mni_layer':
        mapper.compute_and_plot_single_mni_layer(permfilter)
    
    else:
        raise Exception('Unknown graph %s' % graph)

    print 'All done.'
