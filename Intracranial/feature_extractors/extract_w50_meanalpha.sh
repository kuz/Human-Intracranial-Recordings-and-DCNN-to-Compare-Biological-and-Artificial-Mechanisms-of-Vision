#!/bin/bash

matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_bipolar_noscram_artif_brodmann_w50_alpha_resppositive'; range = [1:12]; bandname = 'alpha'; freqlimits = [9 14]; bins=[[9 14]]; ncycles = 4; window = [50 250]; extract_meanband; exit" &
matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_bipolar_noscram_artif_brodmann_w50_alpha_resppositive'; range = [13:24]; bandname = 'alpha'; freqlimits = [9 14]; bins=[[9 14]]; ncycles = 4; window = [50 250]; extract_meanband; exit" &
matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_bipolar_noscram_artif_brodmann_w50_alpha_resppositive'; range = [25:36]; bandname = 'alpha'; freqlimits = [9 14]; bins=[[9 14]]; ncycles = 4; window = [50 250]; extract_meanband; exit" &
matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_bipolar_noscram_artif_brodmann_w50_alpha_resppositive'; range = [37:48]; bandname = 'alpha'; freqlimits = [9 14]; bins=[[9 14]]; ncycles = 4; window = [50 250]; extract_meanband; exit" &
matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_bipolar_noscram_artif_brodmann_w50_alpha_resppositive'; range = [49:60]; bandname = 'alpha'; freqlimits = [9 14]; bins=[[9 14]]; ncycles = 4; window = [50 250]; extract_meanband; exit" &
matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_bipolar_noscram_artif_brodmann_w50_alpha_resppositive'; range = [61:72]; bandname = 'alpha'; freqlimits = [9 14]; bins=[[9 14]]; ncycles = 4; window = [50 250]; extract_meanband; exit" &
matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_bipolar_noscram_artif_brodmann_w50_alpha_resppositive'; range = [73:84]; bandname = 'alpha'; freqlimits = [9 14]; bins=[[9 14]]; ncycles = 4; window = [50 250]; extract_meanband; exit" &
matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_bipolar_noscram_artif_brodmann_w50_alpha_resppositive'; range = [85:100]; bandname = 'alpha'; freqlimits = [9 14]; bins=[[9 14]]; ncycles = 4; window = [50 250]; extract_meanband; exit" &
