#!/bin/bash

matlab -nojvm -nodisplay -nosplash -r "range = [1:12]; freqlimits = [70 150]; bandname = 'highgamma'; ncycles = 6; window = [150 350]; preprocess_compute_responsiveness; exit" &
matlab -nojvm -nodisplay -nosplash -r "range = [13:24]; freqlimits = [70 150]; bandname = 'highgamma'; ncycles = 6; window = [150 350]; preprocess_compute_responsiveness; exit" &
matlab -nojvm -nodisplay -nosplash -r "range = [25:36]; freqlimits = [70 150]; bandname = 'highgamma'; ncycles = 6; window = [150 350]; preprocess_compute_responsiveness; exit" &
matlab -nojvm -nodisplay -nosplash -r "range = [37:48]; freqlimits = [70 150]; bandname = 'highgamma'; ncycles = 6; window = [150 350]; preprocess_compute_responsiveness; exit" &
matlab -nojvm -nodisplay -nosplash -r "range = [49:60]; freqlimits = [70 150]; bandname = 'highgamma'; ncycles = 6; window = [150 350]; preprocess_compute_responsiveness; exit" &
matlab -nojvm -nodisplay -nosplash -r "range = [61:72]; freqlimits = [70 150]; bandname = 'highgamma'; ncycles = 6; window = [150 350]; preprocess_compute_responsiveness; exit" &
matlab -nojvm -nodisplay -nosplash -r "range = [73:84]; freqlimits = [70 150]; bandname = 'highgamma'; ncycles = 6; window = [150 350]; preprocess_compute_responsiveness; exit" &
matlab -nojvm -nodisplay -nosplash -r "range = [85:100]; freqlimits = [70 150]; bandname = 'highgamma'; ncycles = 6; window = [150 350]; preprocess_compute_responsiveness; exit" &
