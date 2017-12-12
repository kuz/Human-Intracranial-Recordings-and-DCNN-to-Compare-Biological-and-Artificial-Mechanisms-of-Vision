import os
import numpy as np
import scipy.io as sio
from collections import Counter

# paths
DATADIR = '../../Data'

# parameters
featureset = 'meantheta_LFP_5c_artif_bipolar_BA_w150_theta_resppositive'

# go over subjects and count
counts = {}
subjects = sorted(os.listdir('%s/Intracranial/Processed/%s/' % (DATADIR, featureset)))
for sid in range(len(subjects)):
    s = sio.loadmat('%s/Intracranial/Processed/%s/%s' % (DATADIR, featureset, subjects[sid]))
    areas = np.ravel(s['s']['probes'][0][0][0][0][3])
    counts[subjects[sid]] = Counter(areas)

# count stats
all_areas = []
vis_areas = []
for sname in subjects:
    for area in counts[sname].keys():
        all_areas.append(counts[sname][area])
        if area in [17, 18, 19, 37, 20]:
            vis_areas.append(counts[sname][area])

# ouput stats
print 'In all areas: range %d - %d, mean %.2f, median %.2f. Areas with only one probe: %.2f per cent' % (np.min(all_areas), np.max(all_areas), np.mean(all_areas), np.median(all_areas), np.sum(np.array(all_areas) == 1) / float(np.sum(all_areas)) * 100)
print 'In vis areas: range %d - %d, mean %.2f, median %.2f. Areas with only one probe: %.2f per cent' % (np.min(vis_areas), np.max(vis_areas), np.mean(vis_areas), np.median(vis_areas), np.sum(np.array(vis_areas) == 1) / float(np.sum(vis_areas)) * 100)