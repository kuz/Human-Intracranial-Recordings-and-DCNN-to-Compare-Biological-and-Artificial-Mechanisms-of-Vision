import os
import numpy as np
import scipy.io as sio
import matplotlib
matplotlib.use('Agg')
from matplotlib import pylab as plt
from scipy.spatial.distance import cosine
import matplotlib.cm as cm

class Plotter:

    @staticmethod
    def xlayer_yarea_zscore(filename, nareas, nlayers, n_sig_in_area, n_tot_in_area, data, title):
       
        # generate Y axis labels
        ylabels = []
        for aid in range(nareas):    
            prefix = '0' if aid < 10 else ''
            label = '(%d/%d) %s%d' % (int(n_sig_in_area[aid]), int(n_tot_in_area[aid]), prefix, aid)
            ylabels.append(label)

        plt.figure(figsize=(30, 30), dpi=600);
        plt.imshow(data, interpolation='none', cmap=cm.Blues);
        plt.clim(0, 0.22);
        plt.xticks(range(nlayers), size=14);
        plt.yticks(range(nareas), ylabels, size=14);
        plt.xlabel('DCNN layer', size=18);
        plt.ylabel('Brodmann area', size=18);
        plt.title(title, size=18);
        plt.colorbar();
        for aid in range(nareas):
            for lid in range(nlayers):
                plt.text(lid, aid, ('%.3f' % data[aid, lid])[1:], va='center', ha='center', size=12)
        plt.savefig(filename, bbox_inches='tight');
        plt.clf();

    @staticmethod
    def xlayer_yarea_zscore_visual(filename, nareas, nlayers, n_sig_in_area, n_tot_in_area, data, title):
       
        # trim data to visual areas
        visual_areas = visual_areas = [17, 18, 19, 37, 20]
        nareas = len(visual_areas)
        n_sig_in_area = n_sig_in_area[visual_areas]
        n_tot_in_area = n_tot_in_area[visual_areas]
        data = data[visual_areas, :]

        # generate Y axis labels
        ylabels = []
        for aid in range(nareas):    
            prefix = '0' if visual_areas[aid] < 10 else ''
            label = '(%d/%d) %s%d' % (int(n_sig_in_area[aid]), int(n_tot_in_area[aid]), prefix, visual_areas[aid])
            ylabels.append(label)

        # plot
        plt.figure(figsize=(15, 8), dpi=600);
        plt.imshow(data, interpolation='none', cmap=cm.Blues);
        plt.clim(0, 0.22);
        plt.xticks(range(nlayers), size=24);
        plt.yticks(range(nareas), ylabels, size=24);
        plt.xlabel('DCNN layer', size=24);
        plt.ylabel('Brodmann area', size=24);
        plt.title(title, size=24);
        #plt.colorbar();
        for aid in range(nareas):
            for lid in range(nlayers):
                plt.text(lid, aid, ('%.3f' % data[aid, lid])[1:], va='center', ha='center', size=24)

        plt.savefig(filename, bbox_inches='tight');
        plt.clf();
        plt.close();

    @staticmethod
    def xlayer_yarea_zscore_visual_linfit(filename, nareas, nlayers, n_sig_in_area, n_tot_in_area, data, title):
       
        # trim data to visual areas
        visual_areas = visual_areas = [17, 18, 19, 37, 20]
        nareas = len(visual_areas)
        n_sig_in_area = n_sig_in_area[visual_areas]
        n_tot_in_area = n_tot_in_area[visual_areas]
        data = data[visual_areas, :]

        # generate Y axis labels
        ylabels = []
        for aid in range(nareas):    
            prefix = '0' if visual_areas[aid] < 10 else ''
            label = '(%d/%d) %s%d' % (int(n_sig_in_area[aid]), int(n_tot_in_area[aid]), prefix, visual_areas[aid])
            ylabels.append(label)

        # compute similarity measure
        x = np.ravel(np.matrix([range(nlayers)] * nareas))
        y = np.ravel([[i] * nlayers for i in np.arange(nareas-1, -1, -1)])

        # fit the lines
        ideal_m, ideal_b = np.polyfit([0, 1, 1, 2, 3, 4, 5, 5, 6, 7], [4, 4, 3, 3, 3, 2, 2, 1, 1, 0], 1)
        m, b = np.polyfit(x, y, 1, w=np.ravel(data))

        # cosine distance
        v = np.array([100, m * 100 + b]) - np.array([0, m * 0 + b])
        ideal_v = np.array([100, ideal_m * 100 + ideal_b]) - np.array([0, ideal_m * 0 + ideal_b])

        # plot
        plt.figure(figsize=(15, 8), dpi=600);
        plt.subplot(1, 2, 1)

        plt.imshow(data, interpolation='none', cmap=cm.Blues);
        plt.clim(0, 0.22);
        plt.xticks(range(nlayers), size=24);
        plt.yticks(range(nareas), ylabels, size=24);
        plt.xlabel('DCNN layer', size=24);
        plt.ylabel('Brodmann area', size=24);
        plt.title(title, size=24);
        #plt.colorbar();
        for aid in range(nareas):
            for lid in range(nlayers):
                plt.text(lid, aid, ('%.3f' % data[aid, lid])[1:], va='center', ha='center', size=24)

        plt.subplot(1, 2, 2)
        plt.scatter(x, y, s=np.array(np.ravel(data))*1000);
        plt.plot(np.array(x), ideal_m*np.array(x)+ideal_b, 'g');
        plt.plot(np.array(x), m*np.array(x)+b, 'b');
        plt.title('Cosine distance: %.5f' % cosine(v, ideal_v))
        plt.xticks(range(nlayers));
        plt.yticks(range(nareas), list(reversed(ylabels)));

        plt.savefig(filename, bbox_inches='tight');
        plt.clf();

    @staticmethod
    def xmni_yscore(basename, nlayers, data):

        plt.figure(figsize=(10, 10), dpi=300);
        for lid in range(nlayers):
            x = data[data[:, 1] == lid, 0]
            y = data[data[:, 1] == lid, 2]
            plt.plot(x, y, 'o');
            plt.legend(['Layer %d' % x for x in range(nlayers)]);
        plt.savefig('%s_all.png' % basename, bbox_inches='tight');
        plt.clf();

        for lid in range(nlayers):
            plt.figure(figsize=(10, 10), dpi=300);
            x = data[data[:, 1] == lid, 0]
            y = data[data[:, 1] == lid, 2]
            plt.plot(x, y, 'o');
            plt.legend(['Layer %d' % lid]);
            plt.savefig('%s_layer%d.png' % (basename, lid), bbox_inches='tight');
            plt.clf();

    @staticmethod
    def hist_xmni_yvarexp(basename, nlayers, data):
        for lid in range(nlayers):
            plt.figure(figsize=(10, 10), dpi=300);
            x = data[data[:, 1] == lid, 0]
            plt.hist(x, 50, normed=1)
            plt.xlim(-100, 20);
            plt.legend(['Layer %d' % lid]);
            plt.savefig('%s_layer%d.png' % (basename, lid), bbox_inches='tight');
            plt.clf();
