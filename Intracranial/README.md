Extract Brain Activations
=========================

To prepare the data for an experiment do the following in correct order:  

1. `matlab -nojvm -nodisplay -nosplash -r "structured_to_processed; exit"` to extract chunks of LFP recordings for each of the stimuli (28 min)  
2. Drop trials with artifacts: `matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c'; preprocess_lfp_artifacts; exit"` (26 min)  
3. Bipolar referencing: `matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif'; preprocess_lfp_to_bipolar; exit"` (13 min)  
4. Supply with area number: `matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar'; preprocess_add_area; exit"` (12 min)  
5. Compute electrode responsiveness `./preprocess_compute_responsiveness.sh` (~12 hours with 120 threads)  
6. Prepare subset of data with significantly positively responsive probes by running `./preprocess_filter_unresponsive.sh` (18 min)  
7. `cd feature_extractors` and run `./extract_meanbands.sh` to extract meanband features for signifiant probes ()  

This concludes data preprocessing pipeline, now go to `../Collusion` and follow the instruction there.
