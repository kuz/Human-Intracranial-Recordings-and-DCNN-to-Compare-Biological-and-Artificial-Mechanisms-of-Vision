"""

Eric Bair, Trevor Hastie, Debashis Paul, and Robert Tibshirani
"Prediction by Supervised Principal Components"
2006

Here in a nutshell is the supervised principal component proposal:
    1. Compute (univariate) standard regression coefficients for each feature.
    2. Form a reduced data matrix consisting of only those features whose
       univariate coefficient exceeds a threshold θ in absolute value (θ
       is estimated by cross-validation).
    3. Compute the first (or first few) principal components of the reduced
       data matrix.
    4. Use these principal component(s) in a regression model to predict
       the outcome.

"""

print __doc__

import numpy as np
from sklearn import decomposition
from sklearn import datasets
from sklearn.cross_validation import train_test_split
from sklearn.linear_model import Ridge

# load data
np.random.seed(5)
iris = datasets.load_iris()
X = iris.data
y = iris.target
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.33, random_state=42)

# PCA
pca = decomposition.PCA(n_components=1)
pca.fit(X_train)
X_train_pca = pca.transform(X_train)
X_test_pca = pca.transform(X_test)

# sPCA
s = X_train.T * np.matrix(y_train).T
n = np.sqrt(np.sum(X_train**2, axis=0)).T
sn = np.ravel(s / np.matrix(n).T)
sn = np.nan_to_num(sn)
keep_features = np.where(sn > np.mean(sn[sn > 0.0]))[0]
X_train_th = X_train[:, keep_features]
X_test_th = X_test[:, keep_features]
pca = decomposition.PCA(n_components=1)
pca.fit(X_train_th)
X_train_spca = pca.transform(X_train_th)
X_test_spca = pca.transform(X_test_th)

# Tests
clf = Ridge(alpha=1.0)
clf.fit(X_train, y_train)
print 'Original', clf.score(X_test, y_test)

clf = Ridge(alpha=1.0)
clf.fit(X_train_pca, y_train)
print 'PCA     ', clf.score(X_test_pca, y_test)

clf = Ridge(alpha=1.0)
clf.fit(X_train_spca, y_train)
print 'sPCA    ', clf.score(X_test_spca, y_test)