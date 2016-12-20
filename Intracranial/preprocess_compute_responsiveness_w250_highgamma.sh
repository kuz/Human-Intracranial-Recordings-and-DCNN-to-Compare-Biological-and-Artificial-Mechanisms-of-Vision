#!/bin/bash

matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_bipolar_noscram_artif_brodmann'; range = [1:12]; freqlimits = [70 150]; bandname = 'highgamma'; ncycles = 6; window = [250 450]; preprocess_compute_responsiveness; exit" &
matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_bipolar_noscram_artif_brodmann'; range = [13:24]; freqlimits = [70 150]; bandname = 'highgamma'; ncycles = 6; window = [250 450]; preprocess_compute_responsiveness; exit" &
matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_bipolar_noscram_artif_brodmann'; range = [25:36]; freqlimits = [70 150]; bandname = 'highgamma'; ncycles = 6; window = [250 450]; preprocess_compute_responsiveness; exit" &
matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_bipolar_noscram_artif_brodmann'; range = [37:48]; freqlimits = [70 150]; bandname = 'highgamma'; ncycles = 6; window = [250 450]; preprocess_compute_responsiveness; exit" &
matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_bipolar_noscram_artif_brodmann'; range = [49:60]; freqlimits = [70 150]; bandname = 'highgamma'; ncycles = 6; window = [250 450]; preprocess_compute_responsiveness; exit" &
matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_bipolar_noscram_artif_brodmann'; range = [61:72]; freqlimits = [70 150]; bandname = 'highgamma'; ncycles = 6; window = [250 450]; preprocess_compute_responsiveness; exit" &
matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_bipolar_noscram_artif_brodmann'; range = [73:84]; freqlimits = [70 150]; bandname = 'highgamma'; ncycles = 6; window = [250 450]; preprocess_compute_responsiveness; exit" &
matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_bipolar_noscram_artif_brodmann'; range = [85:100]; freqlimits = [70 150]; bandname = 'highgamma'; ncycles = 6; window = [250 450]; preprocess_compute_responsiveness; exit" &
