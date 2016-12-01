Extract Brain Activations
=========================

To prepare the data for an experiment do the following in correct order:  

* Check the `indata` parameters in `preprocess_compute_responsiveness.m`
* Run `./preprocess_compute_responsiveness_alpha.sh`
* Run `matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_bipolar_noscram_artif_brodmann'; bandname = 'alpha'; preprocess_filter_unresponsive; exit"`
* `cd feature_extractors`
* Check the parameters inside `extract_meanalpha.sh`
* Run `./extract_meanalpha.sh`

This concludes data preprocessing pipeline, now go to `../Collusion` and follow the instruction there.

### Files
Listed in the order of running.  
`subject_files_we_posses.py` creates the `subjects.txt` list  
`apply_eeg2mat.m` transforms .eeg files into .mat files  
`assemble.m` forms standartized tensors from all the data  
`feature_extractors` hold different ways of extracting features from LFP data
`plotmni` contains scripts to plot electode positions in a 3D mesh


### Pipeline
