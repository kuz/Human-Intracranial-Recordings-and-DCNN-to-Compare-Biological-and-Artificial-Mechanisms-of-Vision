#!/bin/bash

matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_bipolar_noscram_artif_brodmann_w250_theta_resppositive'; range=[1:12]; bandname='theta'; freqlimits=[5 8]; bins=[[5 8]]; ncycles = 3; extract_meanband; exit" &
matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_bipolar_noscram_artif_brodmann_w250_theta_resppositive'; range=[13:24]; bandname='theta'; freqlimits=[5 8]; bins=[[5 8]]; ncycles = 3; extract_meanband; exit" &
matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_bipolar_noscram_artif_brodmann_w250_theta_resppositive'; range=[25:36]; bandname='theta'; freqlimits=[5 8]; bins=[[5 8]]; ncycles = 3; extract_meanband; exit" &
matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_bipolar_noscram_artif_brodmann_w250_theta_resppositive'; range=[37:48]; bandname='theta'; freqlimits=[5 8]; bins=[[5 8]]; ncycles = 3; extract_meanband; exit" &
matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_bipolar_noscram_artif_brodmann_w250_theta_resppositive'; range=[49:60]; bandname='theta'; freqlimits=[5 8]; bins=[[5 8]]; ncycles = 3; extract_meanband; exit" &
matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_bipolar_noscram_artif_brodmann_w250_theta_resppositive'; range=[61:72]; bandname='theta'; freqlimits=[5 8]; bins=[[5 8]]; ncycles = 3; extract_meanband; exit" &
matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_bipolar_noscram_artif_brodmann_w250_theta_resppositive'; range=[73:84]; bandname='theta'; freqlimits=[5 8]; bins=[[5 8]]; ncycles = 3; extract_meanband; exit" &
matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_bipolar_noscram_artif_brodmann_w250_theta_resppositive'; range=[85:100]; bandname='theta'; freqlimits=[5 8]; bins=[[5 8]]; ncycles = 3; extract_meanband; exit" &
