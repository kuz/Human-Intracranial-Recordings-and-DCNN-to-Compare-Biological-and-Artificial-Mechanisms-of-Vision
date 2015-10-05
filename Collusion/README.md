Predict Intracranial from DNN Activations
=========================================

`map_layers_to_probes.py` will train a linear model for each (DNN Layer, Probe)
pair and map each probe to one of the DNN layers accoring on how well activity
of that layer was able to predict probe's performance on a test set.  
  
`plot_map_per_subject.m` will take probes-to-layers mapping and plot it on a 3D
one subject per picture
  
`plot_map_all_subjects.m` will take probes-to-layers mappings and plot all probes
on one 3D mesh (probably will look messy)
