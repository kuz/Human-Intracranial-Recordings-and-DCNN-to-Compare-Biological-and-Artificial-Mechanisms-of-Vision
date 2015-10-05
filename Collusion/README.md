Predict Intracranial from DNN Activations
=========================================

`map_layers_to_probes.py` will train a linear model for each (DNN Layer, Probe)
pair and map each probe to one of the DNN layers accoring on how well activity
of that layer was able to predict probe's performance on a test set.  
`plot_map.m` will take probes-to-layers mapping and plot it on a 3D mesh