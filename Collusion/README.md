Compare Features of Brain Responses and DNN Activations
=======================================================

Once DNN activations are obtained (see `../DNN`) and brain response features are extracted (see `../Intracranial`) 
we can proceed and make the comparison.

Comparison via Representational Dissimilarity Analysis
------------------------------------------------------

1. `./compute_rdm_matrices_all.sh` will compute all RDM matrices: brain responses, DNN and random DNN  
2. `./compute_scores_on_rdms_all.sh` will compare all brain RDMs to all DNN RDMs  
3. `./compute_permuted_rdm_scores.sh` will run score computation 10000 times reshuffling brain responses each time  
4. `./map_and_stats_all.sh` generate all mapping plots and compute all the stats that are needed for the figures in the paper  

Proceed to `../Paper/Figure` to generate figures for the paper


Comparison via Linear Model predictions
---------------------------------------
OUTDATED  

`compute_linear_prediction_scores.sh` will train a linear model for each (DNN Layer, Probe) to predict Probe response
from DNN Layer activity. The R^2 cross-validation score for each (DNN Layer, Probe) pair is stored in `Data/Intracranial/Probe_to_Layer_Maps/lp_meangamma_bipolar_noscram_artif_responsive_brodmann`  

Next the Mapper `python Mapper.py -b lp -f meangamma_bipolar_noscram_artif_brodmann_resppositive -s varexp -p False -g layer_area_score` will assign probes to areas and map areas to DNN layers according to the average score. The resulting plot is stored under `Outcome/Mapper/lp_meangamma_bipolar_noscram_artif_brodmann_resppositive.png`  
  
`plot_map_all_subjects.m` will take probes-to-layers mappings and plot all probes
on one 3D mesh (probably will look messy)


