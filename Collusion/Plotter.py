import os
import numpy as np
import scipy.io as sio
from matplotlib import pylab as plt

class Plotter:

    @staticmethod
    def xlayer_yarea_zscore(self, filename, nareas, nlayers, n_sig_in_area, n_tot_in_area, data):
        
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