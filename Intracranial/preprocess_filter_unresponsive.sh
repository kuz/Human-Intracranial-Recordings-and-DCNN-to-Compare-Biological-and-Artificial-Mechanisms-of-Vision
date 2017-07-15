#!/bin/bash
module load matlab-r2013b
EXCLUDE=stage[1-104,109-131]

# theta
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00  matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; window = [50 250]; bandname = 'theta'; preprocess_filter_unresponsive; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00  matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; window = [150 350]; bandname = 'theta'; preprocess_filter_unresponsive; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00  matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; window = [250 450]; bandname = 'theta'; preprocess_filter_unresponsive; exit" &
sleep 1

# alpha
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00  matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; window = [50 250]; bandname = 'alpha'; preprocess_filter_unresponsive; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00  matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; window = [150 350]; bandname = 'alpha'; preprocess_filter_unresponsive; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00  matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; window = [250 450]; bandname = 'alpha'; preprocess_filter_unresponsive; exit" &
sleep 1

# beta
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00  matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; window = [50 250]; bandname = 'beta'; preprocess_filter_unresponsive; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00  matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; window = [150 350]; bandname = 'beta'; preprocess_filter_unresponsive; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00  matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; window = [250 450]; bandname = 'beta'; preprocess_filter_unresponsive; exit" &
sleep 1

# low gamma
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00  matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; window = [50 250]; bandname = 'lowgamma'; preprocess_filter_unresponsive; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00  matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; window = [150 350]; bandname = 'lowgamma'; preprocess_filter_unresponsive; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00  matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; window = [250 450]; bandname = 'lowgamma'; preprocess_filter_unresponsive; exit" &
sleep 1


# high gamma
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00  matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; window = [50 250]; bandname = 'highgamma'; preprocess_filter_unresponsive; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00  matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; window = [150 350]; bandname = 'highgamma'; preprocess_filter_unresponsive; exit" &
sleep 1
srun --partition=main,long,gpu -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00  matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA'; window = [250 450]; bandname = 'highgamma'; preprocess_filter_unresponsive; exit" &
sleep 1

echo 'All sent.'
