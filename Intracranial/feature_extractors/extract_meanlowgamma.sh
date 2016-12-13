#!/bin/bash

matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_bipolar_noscram_artif_brodmann_lowgamma_resppositive'; range = [1:12]; bandname = 'lowgamma'; freqlimits = [30 70]; bins=[[30 40]; [41 50]; [51 60]; [61 70]]; ncycles = 6; extract_meanband; exit" &
matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_bipolar_noscram_artif_brodmann_lowgamma_resppositive'; range = [13:24]; bandname = 'lowgamma'; freqlimits = [30 70]; bins=[[30 40]; [41 50]; [51 60]; [61 70]]; ncycles = 6; extract_meanband; exit" &
matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_bipolar_noscram_artif_brodmann_lowgamma_resppositive'; range = [25:36]; bandname = 'lowgamma'; freqlimits = [30 70]; bins=[[30 40]; [41 50]; [51 60]; [61 70]]; ncycles = 6; extract_meanband; exit" &
matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_bipolar_noscram_artif_brodmann_lowgamma_resppositive'; range = [37:48]; bandname = 'lowgamma'; freqlimits = [30 70]; bins=[[30 40]; [41 50]; [51 60]; [61 70]]; ncycles = 6; extract_meanband; exit" &
matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_bipolar_noscram_artif_brodmann_lowgamma_resppositive'; range = [49:60]; bandname = 'lowgamma'; freqlimits = [30 70]; bins=[[30 40]; [41 50]; [51 60]; [61 70]]; ncycles = 6; extract_meanband; exit" &
matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_bipolar_noscram_artif_brodmann_lowgamma_resppositive'; range = [61:72]; bandname = 'lowgamma'; freqlimits = [30 70]; bins=[[30 40]; [41 50]; [51 60]; [61 70]]; ncycles = 6; extract_meanband; exit" &
matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_bipolar_noscram_artif_brodmann_lowgamma_resppositive'; range = [73:84]; bandname = 'lowgamma'; freqlimits = [30 70]; bins=[[30 40]; [41 50]; [51 60]; [61 70]]; ncycles = 6; extract_meanband; exit" &
matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_bipolar_noscram_artif_brodmann_lowgamma_resppositive'; range = [85:100]; bandname = 'lowgamma'; freqlimits = [30 70]; bins=[[30 40]; [41 50]; [51 60]; [61 70]]; ncycles = 6; extract_meanband; exit" &
