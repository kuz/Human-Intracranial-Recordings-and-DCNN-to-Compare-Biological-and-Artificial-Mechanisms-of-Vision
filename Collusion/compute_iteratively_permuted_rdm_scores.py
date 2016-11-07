import os
import time
import scipy.io as sio
from multiprocessing import Queue
from subprocess import Popen

class PermutationManager:

    #: Paths
    DATADIR = '../../Data'

    #: Probe counters
    total_probes = 0
    done_probes = 0

    #: Queue of probes to be processed
    underestimated_probes = None


    def __init__(self, featureset):

        # clear marker file directory

        # count total number of probes
        subjects = os.listdir('%s/Intracranial/Processed/%s/' % (self.DATADIR, featureset))
        for sid in range(len(subjects)):
            s = sio.loadmat('%s/Intracranial/Processed/%s/%s' % (self.DATADIR, featureset, subjects[sid]))
            self.total_probes += len(np.ravel(s['s']['probes'][0][0][0][0][3]))

        # initialize queue and put all probes into it
        underestimated_probes = Queue()
        # for TODO 

    def run(self):

        # iterate until all probes are processed
        while self.done_probes < self.total_probes:
            try:
                (sid, pid) = self.underestimated_probes.get()
            except:
                print 'Queue is empty. %d / %d probes processed. Waiting for new items in the queue...' % (self.done_probes, self.total_probes)
                time.sleep(60)






    for i in range(3):
   ....:     Popen(['srun -N 1 --partition=long --cpus-per-task=1 --mem=2000 --exclude idu[38-41] sleep 30'], shell='True', stdin=None, stdout=None, stderr=None, close_fds=True)
   ....:     time.sleep(5)