#!/bin/bash
module load matlab-r2013b
EXCLUDE=stage[1-104,109-131]

# w50 theta
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [1:12]; freqlimits = [5 8]; bandname = 'theta'; ncycles = 3; window = [50 250]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [13:24]; freqlimits = [5 8]; bandname = 'theta'; ncycles = 3; window = [50 250]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [25:36]; freqlimits = [5 8]; bandname = 'theta'; ncycles = 3; window = [50 250]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [37:48]; freqlimits = [5 8]; bandname = 'theta'; ncycles = 3; window = [50 250]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [49:60]; freqlimits = [5 8]; bandname = 'theta'; ncycles = 3; window = [50 250]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [61:72]; freqlimits = [5 8]; bandname = 'theta'; ncycles = 3; window = [50 250]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [73:84]; freqlimits = [5 8]; bandname = 'theta'; ncycles = 3; window = [50 250]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [85:100]; freqlimits = [5 8]; bandname = 'theta'; ncycles = 3; window = [50 250]; preprocess_compute_responsiveness; exit" &
sleep 1

# w50 alpha
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [1:12]; freqlimits = [9 14]; bandname = 'alpha'; ncycles = 4; window = [50 250]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [13:24]; freqlimits = [9 14]; bandname = 'alpha'; ncycles = 4; window = [50 250]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [25:36]; freqlimits = [9 14]; bandname = 'alpha'; ncycles = 4; window = [50 250]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [37:48]; freqlimits = [9 14]; bandname = 'alpha'; ncycles = 4; window = [50 250]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [49:60]; freqlimits = [9 14]; bandname = 'alpha'; ncycles = 4; window = [50 250]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [61:72]; freqlimits = [9 14]; bandname = 'alpha'; ncycles = 4; window = [50 250]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [73:84]; freqlimits = [9 14]; bandname = 'alpha'; ncycles = 4; window = [50 250]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [85:100]; freqlimits = [9 14]; bandname = 'alpha'; ncycles = 4; window = [50 250]; preprocess_compute_responsiveness; exit" &
sleep 1

# w50 beta
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [1:12]; freqlimits = [15 30]; bandname = 'beta'; ncycles = 5; window = [50 250]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [13:24]; freqlimits = [15 30]; bandname = 'beta'; ncycles = 5; window = [50 250]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [25:36]; freqlimits = [15 30]; bandname = 'beta'; ncycles = 5; window = [50 250]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [37:48]; freqlimits = [15 30]; bandname = 'beta'; ncycles = 5; window = [50 250]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [49:60]; freqlimits = [15 30]; bandname = 'beta'; ncycles = 5; window = [50 250]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [61:72]; freqlimits = [15 30]; bandname = 'beta'; ncycles = 5; window = [50 250]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [73:84]; freqlimits = [15 30]; bandname = 'beta'; ncycles = 5; window = [50 250]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [85:100]; freqlimits = [15 30]; bandname = 'beta'; ncycles = 5; window = [50 250]; preprocess_compute_responsiveness; exit" &
sleep 1

# w50 low gamma
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [1:12]; freqlimits = [31 70]; bandname = 'lowgamma'; ncycles = 6; window = [50 250]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [13:24]; freqlimits = [31 70]; bandname = 'lowgamma'; ncycles = 6; window = [50 250]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [25:36]; freqlimits = [31 70]; bandname = 'lowgamma'; ncycles = 6; window = [50 250]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [37:48]; freqlimits = [31 70]; bandname = 'lowgamma'; ncycles = 6; window = [50 250]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [49:60]; freqlimits = [31 70]; bandname = 'lowgamma'; ncycles = 6; window = [50 250]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [61:72]; freqlimits = [31 70]; bandname = 'lowgamma'; ncycles = 6; window = [50 250]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [73:84]; freqlimits = [31 70]; bandname = 'lowgamma'; ncycles = 6; window = [50 250]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [85:100]; freqlimits = [31 70]; bandname = 'lowgamma'; ncycles = 6; window = [50 250]; preprocess_compute_responsiveness; exit" &
sleep 1

# w50 high gamma
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [1:12]; freqlimits = [70 150]; bandname = 'highgamma'; ncycles = 5; window = [50 250]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [13:24]; freqlimits = [70 150]; bandname = 'highgamma'; ncycles = 5; window = [50 250]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [25:36]; freqlimits = [70 150]; bandname = 'highgamma'; ncycles = 5; window = [50 250]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [37:48]; freqlimits = [70 150]; bandname = 'highgamma'; ncycles = 5; window = [50 250]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [49:60]; freqlimits = [70 150]; bandname = 'highgamma'; ncycles = 5; window = [50 250]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [61:72]; freqlimits = [70 150]; bandname = 'highgamma'; ncycles = 5; window = [50 250]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [73:84]; freqlimits = [70 150]; bandname = 'highgamma'; ncycles = 5; window = [50 250]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [85:100]; freqlimits = [70 150]; bandname = 'highgamma'; ncycles = 5; window = [50 250]; preprocess_compute_responsiveness; exit" &
sleep 1

# w150 theta
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [1:12]; freqlimits = [5 8]; bandname = 'theta'; ncycles = 3; window = [150 350]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [13:24]; freqlimits = [5 8]; bandname = 'theta'; ncycles = 3; window = [150 350]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [25:36]; freqlimits = [5 8]; bandname = 'theta'; ncycles = 3; window = [150 350]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [37:48]; freqlimits = [5 8]; bandname = 'theta'; ncycles = 3; window = [150 350]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [49:60]; freqlimits = [5 8]; bandname = 'theta'; ncycles = 3; window = [150 350]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [61:72]; freqlimits = [5 8]; bandname = 'theta'; ncycles = 3; window = [150 350]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [73:84]; freqlimits = [5 8]; bandname = 'theta'; ncycles = 3; window = [150 350]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [85:100]; freqlimits = [5 8]; bandname = 'theta'; ncycles = 3; window = [150 350]; preprocess_compute_responsiveness; exit" &
sleep 1

# w150 alpha
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [1:12]; freqlimits = [9 14]; bandname = 'alpha'; ncycles = 4; window = [150 350]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [13:24]; freqlimits = [9 14]; bandname = 'alpha'; ncycles = 4; window = [150 350]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [25:36]; freqlimits = [9 14]; bandname = 'alpha'; ncycles = 4; window = [150 350]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [37:48]; freqlimits = [9 14]; bandname = 'alpha'; ncycles = 4; window = [150 350]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [49:60]; freqlimits = [9 14]; bandname = 'alpha'; ncycles = 4; window = [150 350]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [61:72]; freqlimits = [9 14]; bandname = 'alpha'; ncycles = 4; window = [150 350]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [73:84]; freqlimits = [9 14]; bandname = 'alpha'; ncycles = 4; window = [150 350]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [85:100]; freqlimits = [9 14]; bandname = 'alpha'; ncycles = 4; window = [150 350]; preprocess_compute_responsiveness; exit" &
sleep 1

# w150 beta
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [1:12]; freqlimits = [15 30]; bandname = 'beta'; ncycles = 5; window = [150 350]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [13:24]; freqlimits = [15 30]; bandname = 'beta'; ncycles = 5; window = [150 350]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [25:36]; freqlimits = [15 30]; bandname = 'beta'; ncycles = 5; window = [150 350]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [37:48]; freqlimits = [15 30]; bandname = 'beta'; ncycles = 5; window = [150 350]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [49:60]; freqlimits = [15 30]; bandname = 'beta'; ncycles = 5; window = [150 350]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [61:72]; freqlimits = [15 30]; bandname = 'beta'; ncycles = 5; window = [150 350]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [73:84]; freqlimits = [15 30]; bandname = 'beta'; ncycles = 5; window = [150 350]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [85:100]; freqlimits = [15 30]; bandname = 'beta'; ncycles = 5; window = [150 350]; preprocess_compute_responsiveness; exit" &
sleep 1

# w150 low gamma
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [1:12]; freqlimits = [31 70]; bandname = 'lowgamma'; ncycles = 6; window = [150 350]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [13:24]; freqlimits = [31 70]; bandname = 'lowgamma'; ncycles = 6; window = [150 350]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [25:36]; freqlimits = [31 70]; bandname = 'lowgamma'; ncycles = 6; window = [150 350]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [37:48]; freqlimits = [31 70]; bandname = 'lowgamma'; ncycles = 6; window = [150 350]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [49:60]; freqlimits = [31 70]; bandname = 'lowgamma'; ncycles = 6; window = [150 350]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [61:72]; freqlimits = [31 70]; bandname = 'lowgamma'; ncycles = 6; window = [150 350]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [73:84]; freqlimits = [31 70]; bandname = 'lowgamma'; ncycles = 6; window = [150 350]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [85:100]; freqlimits = [31 70]; bandname = 'lowgamma'; ncycles = 6; window = [150 350]; preprocess_compute_responsiveness; exit" &
sleep 1

# w150 high gamma
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [1:12]; freqlimits = [70 150]; bandname = 'highgamma'; ncycles = 6; window = [150 350]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [13:24]; freqlimits = [70 150]; bandname = 'highgamma'; ncycles = 6; window = [150 350]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [25:36]; freqlimits = [70 150]; bandname = 'highgamma'; ncycles = 6; window = [150 350]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [37:48]; freqlimits = [70 150]; bandname = 'highgamma'; ncycles = 6; window = [150 350]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [49:60]; freqlimits = [70 150]; bandname = 'highgamma'; ncycles = 6; window = [150 350]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [61:72]; freqlimits = [70 150]; bandname = 'highgamma'; ncycles = 6; window = [150 350]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [73:84]; freqlimits = [70 150]; bandname = 'highgamma'; ncycles = 6; window = [150 350]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [85:100]; freqlimits = [70 150]; bandname = 'highgamma'; ncycles = 6; window = [150 350]; preprocess_compute_responsiveness; exit" &
sleep 1

# w250 theta
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [1:12]; freqlimits = [5 8]; bandname = 'theta'; ncycles = 3; window = [250 450]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [13:24]; freqlimits = [5 8]; bandname = 'theta'; ncycles = 3; window = [250 450]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [25:36]; freqlimits = [5 8]; bandname = 'theta'; ncycles = 3; window = [250 450]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [37:48]; freqlimits = [5 8]; bandname = 'theta'; ncycles = 3; window = [250 450]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [49:60]; freqlimits = [5 8]; bandname = 'theta'; ncycles = 3; window = [250 450]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [61:72]; freqlimits = [5 8]; bandname = 'theta'; ncycles = 3; window = [250 450]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [73:84]; freqlimits = [5 8]; bandname = 'theta'; ncycles = 3; window = [250 450]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [85:100]; freqlimits = [5 8]; bandname = 'theta'; ncycles = 3; window = [250 450]; preprocess_compute_responsiveness; exit" &

# w250 alpha
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [1:12]; freqlimits = [9 14]; bandname = 'alpha'; ncycles = 4; window = [250 450]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [13:24]; freqlimits = [9 14]; bandname = 'alpha'; ncycles = 4; window = [250 450]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [25:36]; freqlimits = [9 14]; bandname = 'alpha'; ncycles = 4; window = [250 450]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [37:48]; freqlimits = [9 14]; bandname = 'alpha'; ncycles = 4; window = [250 450]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [49:60]; freqlimits = [9 14]; bandname = 'alpha'; ncycles = 4; window = [250 450]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [61:72]; freqlimits = [9 14]; bandname = 'alpha'; ncycles = 4; window = [250 450]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [73:84]; freqlimits = [9 14]; bandname = 'alpha'; ncycles = 4; window = [250 450]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [85:100]; freqlimits = [9 14]; bandname = 'alpha'; ncycles = 4; window = [250 450]; preprocess_compute_responsiveness; exit" &
sleep 1

# w250 beta
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [1:12]; freqlimits = [15 30]; bandname = 'beta'; ncycles = 5; window = [250 450]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [13:24]; freqlimits = [15 30]; bandname = 'beta'; ncycles = 5; window = [250 450]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [25:36]; freqlimits = [15 30]; bandname = 'beta'; ncycles = 5; window = [250 450]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [37:48]; freqlimits = [15 30]; bandname = 'beta'; ncycles = 5; window = [250 450]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [49:60]; freqlimits = [15 30]; bandname = 'beta'; ncycles = 5; window = [250 450]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [61:72]; freqlimits = [15 30]; bandname = 'beta'; ncycles = 5; window = [250 450]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [73:84]; freqlimits = [15 30]; bandname = 'beta'; ncycles = 5; window = [250 450]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [85:100]; freqlimits = [15 30]; bandname = 'beta'; ncycles = 5; window = [250 450]; preprocess_compute_responsiveness; exit" &
sleep 1

# w250 low gamma
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [1:12]; freqlimits = [31 70]; bandname = 'lowgamma'; ncycles = 6; window = [250 450]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [13:24]; freqlimits = [31 70]; bandname = 'lowgamma'; ncycles = 6; window = [250 450]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [25:36]; freqlimits = [31 70]; bandname = 'lowgamma'; ncycles = 6; window = [250 450]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [37:48]; freqlimits = [31 70]; bandname = 'lowgamma'; ncycles = 6; window = [250 450]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [49:60]; freqlimits = [31 70]; bandname = 'lowgamma'; ncycles = 6; window = [250 450]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [61:72]; freqlimits = [31 70]; bandname = 'lowgamma'; ncycles = 6; window = [250 450]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [73:84]; freqlimits = [31 70]; bandname = 'lowgamma'; ncycles = 6; window = [250 450]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [85:100]; freqlimits = [31 70]; bandname = 'lowgamma'; ncycles = 6; window = [250 450]; preprocess_compute_responsiveness; exit" &
sleep 1

# w250 high gamma
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [1:12]; freqlimits = [70 150]; bandname = 'highgamma'; ncycles = 6; window = [250 450]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [13:24]; freqlimits = [70 150]; bandname = 'highgamma'; ncycles = 6; window = [250 450]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [25:36]; freqlimits = [70 150]; bandname = 'highgamma'; ncycles = 6; window = [250 450]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [37:48]; freqlimits = [70 150]; bandname = 'highgamma'; ncycles = 6; window = [250 450]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [49:60]; freqlimits = [70 150]; bandname = 'highgamma'; ncycles = 6; window = [250 450]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [61:72]; freqlimits = [70 150]; bandname = 'highgamma'; ncycles = 6; window = [250 450]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [73:84]; freqlimits = [70 150]; bandname = 'highgamma'; ncycles = 6; window = [250 450]; preprocess_compute_responsiveness; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; range = [85:100]; freqlimits = [70 150]; bandname = 'highgamma'; ncycles = 6; window = [250 450]; preprocess_compute_responsiveness; exit" &
sleep 1
