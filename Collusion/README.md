Compare Features of Brain Responses and DNN Activations
=======================================================

Once DNN activations are obtained (see `../DNN`) and brain response features are extracted (see `../Intracranial`) 
we can proceed and make the comparison.



Comparison via Linear Model predictions
---------------------------------------
`compute_linear_prediction_scores.sh` will train a linear model for each (DNN Layer, Probe) to predict Probe response
from DNN Layer activity. The R^2 cross-validation score for each (DNN Layer, Probe) pair is stored in `Data/Intracranial/Probe_to_Layer_Maps/lp_meangamma_bipolar_noscram_artif_responsive_brodmann`  

Next the Mapper `python Mapper.py -b lp -f meangamma_bipolar_noscram_artif_brodmann_resppositive -s varexp -p False -g layer_area_score` will assign probes to areas and map areas to DNN layers according to the average score. The resulting plot is stored under `Outcome/Mapper/lp_meangamma_bipolar_noscram_artif_brodmann_resppositive.png`  
  
`plot_map_all_subjects.m` will take probes-to-layers mappings and plot all probes
on one 3D mesh (probably will look messy)


Comparison via Representational Dissimilarity Analysis
------------------------------------------------------

Run `./compute_rdm_matrices.sh` (look inside to set parameters) to compute distance matrices over stimuli in all possible feature spaces: pixels, DNN layer activation, each particular probe responses.  

Next run `./compute_scores_on_rdms.sh` (look inside to set parameters) to compute correlation scores between each possible pair of 9 DNN repsentationans and ~1000 of probe responses. Resulting scores are stored under `../../Data/RSA/`.  

Perform the permutation test by running `python compute_permuted_rdm_scores.py -f meanalpha_LFP_bipolar_noscram_artif_brodmann_alpha_resppositive -d euclidean -o matrix -t 1.0`

Next mapper
On HPC: `export LD_LIBRARY_PATH=/gpfs/hpchome/a72073/Python/lib/:/usr/lib:/usr/local/lib:/usr/lib64:/usr/local/lib64:/gpfs/hpchome/a72073/Software/lib`  
and then `srun -N 1 --cpus-per-task=1 --mem=4000 -t 24:00:00 python Mapper.py -b rsa -f meanalpha_LFP_bipolar_noscram_artif_brodmann_alpha_resppositive -d euclidean -o matrix -t 1.0 -s corr -p True -g layer_area_score`  
(on EENet: `srun -N 1 --partition=long --cpus-per-task=1 --mem=4000 --exclude idu[38-41] python Mapper.py -b rsa -f meanalpha_LFP_bipolar_noscram_artif_brodmann_alpha_resppositive -d euclidean -o matrix -t 1.0 -s corr -p True -g layer_area_score`)