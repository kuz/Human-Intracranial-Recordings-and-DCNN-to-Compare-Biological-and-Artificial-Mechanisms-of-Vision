import os
import numpy as np
import scipy.io as sio
from matplotlib import pylab as plt

class Plotter:

    @staticmethod
    def xlayer_yarea_zscore(filename, nareas, nlayers, n_sig_in_area, n_tot_in_area, data):
       
        # generate Y axis labels
        ylabels = []
        for aid in range(nareas):    
            prefix = '0' if aid < 10 else ''
            label = '(%d/%d) %s%d' % (int(n_sig_in_area[aid]), int(n_tot_in_area[aid]), prefix, aid)
            ylabels.append(label)

        plt.figure(figsize=(15, 15), dpi=600);
        plt.imshow(data, interpolation='none');
        plt.xticks(range(nlayers));
        plt.yticks(range(nareas), ylabels);
        plt.colorbar();
        for aid in range(nareas):
            for lid in range(nlayers):
                plt.text(lid, aid, ('%.3f' % data[aid, lid])[1:], va='center', ha='center', size=6)
        plt.savefig(filename, bbox_inches='tight');
        plt.clf();

    @staticmethod
    def xmni_yscore(basename, nlayers, data):
        for lid in range(nlayers):
            plt.figure(figsize=(10, 10), dpi=300);
            x = data[data[:, 1] == lid, 0]
            y = data[data[:, 1] == lid, 2]
            plt.plot(x, y, 'o');
            plt.legend(['Layer %d' % lid]);
            plt.savefig('%s%d.png' % (basename, lid), bbox_inches='tight');
            plt.clf();

    @staticmethod
    def hist_xmni_yvarexp(basename, nlayers, data):
        for lid in range(nlayers):
            plt.figure(figsize=(10, 10), dpi=300);
            x = data[data[:, 1] == lid, 0]
            plt.hist(x, 50, normed=1)
            plt.xlim(-100, 20);
            plt.legend(['Layer %d' % lid]);
            plt.savefig('%s%d.png' % (basename, lid), bbox_inches='tight');
            plt.clf();