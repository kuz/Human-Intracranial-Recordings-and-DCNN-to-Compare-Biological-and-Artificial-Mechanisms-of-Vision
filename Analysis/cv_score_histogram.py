import numpy as np
import matplotlib.pyplot as plt
import glob

# parameters
featureset = 'meangamma_bipolar_noscram_artif_ventral_brodmann'
paramset = 'pca250'

# load data
actual = []
permuted = []
for filename in glob.glob('../../Outcome/Permutation test/%s.%s.actual/*.txt' % (featureset, paramset)):
    actual += list(np.loadtxt(filename))
for filename in glob.glob('../../Outcome/Permutation test/%s.%s.permuted/*.txt' % (featureset, paramset)):
    permuted += list(np.loadtxt(filename))
actual = np.array(actual)
permuted = np.array(permuted)

# compute a score
score_actual = np.sum(actual[actual > 0.0])
score_permuted = np.sum(permuted[permuted > 0.0])
score = score_actual - score_permuted

# histograms
h_actual = np.histogram(actual, bins=100, range=(-1.0, 1.0))
h_permuted = np.histogram(permuted, bins=100, range=(-1.0, 1.0))

# raw histgrams
bins = np.linspace(-0.5, 0.5, 100)
plt.hist(actual, bins, alpha=0.5)
plt.hist(permuted, bins, alpha=0.5)
plt.title('Score %.4f' % score)
plt.savefig('../../Outcome/Permutation test/%s.%s.full.png' % (featureset, paramset), bbox_inches='tight')

# difference
plt.clf()
diff = h_actual[0] - h_permuted[0]
plt.bar(np.arange(len(diff)), diff)
plt.xticks(np.arange(len(diff)), h_actual[1][1:], rotation='vertical', fontsize=5)
plt.title('Score %.4f' % score)
plt.savefig('../../Outcome/Permutation test/%s.%s.diff.png' % (featureset, paramset), bbox_inches='tight')
