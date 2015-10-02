# -*- coding: utf-8 -*-

"""

Compose the list of unique subjects and the file type we have for each of them

NB: Remember to make all file names uppercase before running the script.
for f in * ; do mv -- "$f" "$(tr [:lower:] [:upper:] <<< "$f")" ; done

"""

import os

# read the list of all data files
filelist = [x.upper() for x in os.listdir('../../Data/Intracranial/Restructured')]

# extract subjects and possible types of files
subjects = []
filetypes = []

for filename in filelist:
	pieces = filename.split('_')
	
	if pieces[0].upper() in ['LYONNEURO', 'GRE']:
		subjects.append('_'.join(pieces[:3]).upper())
		filetypes.append('_'.join(pieces[3:]).upper())
	else:
		subjects.append('_'.join(pieces[:2]).upper())
		filetypes.append('_'.join(pieces[2:]).upper())

# extract unique instances
subjects = list(set(subjects))
filetypes = sorted(list(set(filetypes)))

# show in a tabular form which subject has which files
for subject in subjects:
	line = subject + '\t'
	for filetype in filetypes:
		if subject + '_' + filetype in filelist:
			line += '•'
		line += '\t'
	print line

# store list of subjects
with open('subjects.txt', 'w') as f:
	f.write('\n'.join(subjects))
