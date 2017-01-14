'''
Population Spearman Correlation
http://www.ewi.tudelft.nl/fileadmin/Faculteit/EWI/Over_de_faculteit/Afdelingen/Applied_Mathematics/Risico_en_Beslissings_Analyse/Papers/ahanea_population_rank_discrete.pdf
'''

import numpy as np

# parameters
nlayers = 9
nareas = 5

# data
x = np.ravel(np.matrix([range(nlayers)] * nareas))
y = np.ravel([[i] * nlayers for i in np.arange(nareas-1, -1, -1)])
data_lg_150 = np.matrix(
    [[ 0.06745,     0.06975,     0.08575,     0.07415,     0.0705,      0.1391,       0.,          0.,          0.        ],
     [ 0.03022,     0.07374,     0.06532,     0.0905,      0.06558,     0.08326,      0.02726,     0.02322,     0.01432   ],
     [ 0.01598571,  0.02581429,  0.07491429,  0.0785,      0.11132857,  0.11478571,   0.01611429,  0.01505714,  0.04617143],
     [ 0.,          0.0226,      0.00944286,  0.01796429,  0.02991429,  0.02919286,   0.05937857,  0.04925,     0.06270714],
     [ 0.,          0.,          0.,          0.,          0.,          0.,           0.,          0.,          0.        ]])

# PSC
n = nlayers
m = nareas
p = data_lg_150 / np.sum(data_lg_150)
prow = np.ravel(np.sum(p, 1))
pcol = np.ravel(np.sum(p, 0))
q = np.matrix(prow).T * np.matrix(pcol)

PcPd = 0
for i in range(m):
    for j in range(n):
        innersum = 0.0
        for k in range(m):
            for l in range(n):
                if k != i and l != j: innersum += np.sign(k - i) * (l - j) * q[k,l]
        PcPd += p[i, j] * innersum

U = 0.0
for i in range(m):
    inleft = 0.0
    inright = 0.0
    for j in range(i + 1, m):
        inleft += prow[i] * prow[j]
    for k in range(m):
        for j in range(i + 1, k):
            inright += prow[i] * prow[j] * prow[k]
    U += inleft - inright

V = 0.0
for i in range(n):
    inleft = 0.0
    inright = 0.0
    for j in range(i + 1, n):
        inleft += pcol[i] * pcol[j]
    for k in range(n):
        for j in range(i + 1, k):
            inright += pcol[i] * pcol[j] * pcol[k]
    V += inleft - inright

r = PcPd / np.sqrt(U * V)

print r




