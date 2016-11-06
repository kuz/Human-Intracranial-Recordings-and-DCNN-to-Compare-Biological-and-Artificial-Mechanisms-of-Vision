import os
import time
import numpy as np
import scipy.io as sio
from subprocess import Popen

featureset = 'meangamma_bipolar_noscram_artif_brodmann_resppositive'
DATADIR = '../../Data'

subjects = os.listdir('%s/Intracranial/Processed/%s/' % (DATADIR, featureset))
for sid in range(len(subjects)):
    s = sio.loadmat('%s/Intracranial/Processed/%s/%s' % (DATADIR, featureset, subjects[sid]))
    for pid in range(len(np.ravel(s['s']['probes'][0][0][0][0][3]))):
        print 'Processing subject %d probe %d' % (sid, pid)
        Popen(['srun -N 1 --partition=long --cpus-per-task=1 --mem=2000 --exclude idu[38-41] python RDMPermuter.py -i %d -p %d -b rsa -f %s -d euclidean -o matrix -t 1.0' % (sid, pid, featureset)], shell='True', stdin=None, stdout=None, stderr=None, close_fds=True)
        time.sleep(7*60)

print 'All done.'

