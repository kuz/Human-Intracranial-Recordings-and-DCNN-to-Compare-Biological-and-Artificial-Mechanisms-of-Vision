Extract Brain Activations
=========================

To prepare the data for an experiment do the following in correct order:  

1. `matlab -nojvm -nodisplay -nosplash -r "structured_to_processed; exit"` to extract chunks of LFP recordings for each of the stimuli (28 min)  
2. Drop trials with artifacts: `matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c'; preprocess_lfp_artifacts; exit"` (26 min)  
3. Bipolar referencing: `matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif'; preprocess_lfp_to_bipolar; exit"` (13 min)  
4. Supply with area number: `matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar'; preprocess_add_area; exit"` (12 min)  
5. Compute electrode responsiveness `./preprocess_compute_responsiveness.sh` ( with 120 threads)  
6. 

* Run `matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_bipolar_noscram_artif_brodmann'; window = [150 350]; bandname = 'alpha'; preprocess_filter_unresponsive; exit"`
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
