#!/bin/bash
module load matlab-r2013b
EXCLUDE=stage[1-111,118-131]

# theta 50
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w50_theta_resppositive'; range=[1:12]; bandname='theta'; freqlimits=[5 8]; bins=[[5 8]]; ncycles = 3; window = [50 250]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w50_theta_resppositive'; range=[13:24]; bandname='theta'; freqlimits=[5 8]; bins=[[5 8]]; ncycles = 3; window = [50 250]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w50_theta_resppositive'; range=[25:36]; bandname='theta'; freqlimits=[5 8]; bins=[[5 8]]; ncycles = 3; window = [50 250]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w50_theta_resppositive'; range=[37:48]; bandname='theta'; freqlimits=[5 8]; bins=[[5 8]]; ncycles = 3; window = [50 250]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w50_theta_resppositive'; range=[49:60]; bandname='theta'; freqlimits=[5 8]; bins=[[5 8]]; ncycles = 3; window = [50 250]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w50_theta_resppositive'; range=[61:72]; bandname='theta'; freqlimits=[5 8]; bins=[[5 8]]; ncycles = 3; window = [50 250]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w50_theta_resppositive'; range=[73:84]; bandname='theta'; freqlimits=[5 8]; bins=[[5 8]]; ncycles = 3; window = [50 250]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w50_theta_resppositive'; range=[85:100]; bandname='theta'; freqlimits=[5 8]; bins=[[5 8]]; ncycles = 3; window = [50 250]; extract_meanband; exit" &
sleep 1

# theta 150
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w150_theta_resppositive'; range=[1:12]; bandname='theta'; freqlimits=[5 8]; bins=[[5 8]]; ncycles = 3; window = [150 350]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w150_theta_resppositive'; range=[13:24]; bandname='theta'; freqlimits=[5 8]; bins=[[5 8]]; ncycles = 3; window = [150 350]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w150_theta_resppositive'; range=[25:36]; bandname='theta'; freqlimits=[5 8]; bins=[[5 8]]; ncycles = 3; window = [150 350]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w150_theta_resppositive'; range=[37:48]; bandname='theta'; freqlimits=[5 8]; bins=[[5 8]]; ncycles = 3; window = [150 350]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w150_theta_resppositive'; range=[49:60]; bandname='theta'; freqlimits=[5 8]; bins=[[5 8]]; ncycles = 3; window = [150 350]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w150_theta_resppositive'; range=[61:72]; bandname='theta'; freqlimits=[5 8]; bins=[[5 8]]; ncycles = 3; window = [150 350]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w150_theta_resppositive'; range=[73:84]; bandname='theta'; freqlimits=[5 8]; bins=[[5 8]]; ncycles = 3; window = [150 350]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w150_theta_resppositive'; range=[85:100]; bandname='theta'; freqlimits=[5 8]; bins=[[5 8]]; ncycles = 3; window = [150 350]; extract_meanband; exit" &
sleep 1

# theta 250
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w250_theta_resppositive'; range=[1:12]; bandname='theta'; freqlimits=[5 8]; bins=[[5 8]]; ncycles = 3; window = [250 450]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w250_theta_resppositive'; range=[13:24]; bandname='theta'; freqlimits=[5 8]; bins=[[5 8]]; ncycles = 3; window = [250 450]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w250_theta_resppositive'; range=[25:36]; bandname='theta'; freqlimits=[5 8]; bins=[[5 8]]; ncycles = 3; window = [250 450]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w250_theta_resppositive'; range=[37:48]; bandname='theta'; freqlimits=[5 8]; bins=[[5 8]]; ncycles = 3; window = [250 450]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w250_theta_resppositive'; range=[49:60]; bandname='theta'; freqlimits=[5 8]; bins=[[5 8]]; ncycles = 3; window = [250 450]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w250_theta_resppositive'; range=[61:72]; bandname='theta'; freqlimits=[5 8]; bins=[[5 8]]; ncycles = 3; window = [250 450]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w250_theta_resppositive'; range=[73:84]; bandname='theta'; freqlimits=[5 8]; bins=[[5 8]]; ncycles = 3; window = [250 450]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w250_theta_resppositive'; range=[85:100]; bandname='theta'; freqlimits=[5 8]; bins=[[5 8]]; ncycles = 3; window = [250 450]; extract_meanband; exit" &
sleep 1

# alpha 50
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w50_alpha_resppositive'; range = [1:12]; bandname = 'alpha'; freqlimits = [9 14]; bins=[[9 14]]; ncycles = 4; window = [50 250]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w50_alpha_resppositive'; range = [13:24]; bandname = 'alpha'; freqlimits = [9 14]; bins=[[9 14]]; ncycles = 4; window = [50 250]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w50_alpha_resppositive'; range = [25:36]; bandname = 'alpha'; freqlimits = [9 14]; bins=[[9 14]]; ncycles = 4; window = [50 250]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w50_alpha_resppositive'; range = [37:48]; bandname = 'alpha'; freqlimits = [9 14]; bins=[[9 14]]; ncycles = 4; window = [50 250]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w50_alpha_resppositive'; range = [49:60]; bandname = 'alpha'; freqlimits = [9 14]; bins=[[9 14]]; ncycles = 4; window = [50 250]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w50_alpha_resppositive'; range = [61:72]; bandname = 'alpha'; freqlimits = [9 14]; bins=[[9 14]]; ncycles = 4; window = [50 250]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w50_alpha_resppositive'; range = [73:84]; bandname = 'alpha'; freqlimits = [9 14]; bins=[[9 14]]; ncycles = 4; window = [50 250]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w50_alpha_resppositive'; range = [85:100]; bandname = 'alpha'; freqlimits = [9 14]; bins=[[9 14]]; ncycles = 4; window = [50 250]; extract_meanband; exit" &
sleep 1

# alpha 150
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w150_alpha_resppositive'; range = [1:12]; bandname = 'alpha'; freqlimits = [9 14]; bins=[[9 14]]; ncycles = 4; window = [150 350]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w150_alpha_resppositive'; range = [13:24]; bandname = 'alpha'; freqlimits = [9 14]; bins=[[9 14]]; ncycles = 4; window = [150 350]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w150_alpha_resppositive'; range = [25:36]; bandname = 'alpha'; freqlimits = [9 14]; bins=[[9 14]]; ncycles = 4; window = [150 350]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w150_alpha_resppositive'; range = [37:48]; bandname = 'alpha'; freqlimits = [9 14]; bins=[[9 14]]; ncycles = 4; window = [150 350]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w150_alpha_resppositive'; range = [49:60]; bandname = 'alpha'; freqlimits = [9 14]; bins=[[9 14]]; ncycles = 4; window = [150 350]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w150_alpha_resppositive'; range = [61:72]; bandname = 'alpha'; freqlimits = [9 14]; bins=[[9 14]]; ncycles = 4; window = [150 350]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w150_alpha_resppositive'; range = [73:84]; bandname = 'alpha'; freqlimits = [9 14]; bins=[[9 14]]; ncycles = 4; window = [150 350]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w150_alpha_resppositive'; range = [85:100]; bandname = 'alpha'; freqlimits = [9 14]; bins=[[9 14]]; ncycles = 4; window = [150 350]; extract_meanband; exit" &
sleep 1

# alpha 250
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w250_alpha_resppositive'; range = [1:12]; bandname = 'alpha'; freqlimits = [9 14]; bins=[[9 14]]; ncycles = 4; window = [250 450]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w250_alpha_resppositive'; range = [13:24]; bandname = 'alpha'; freqlimits = [9 14]; bins=[[9 14]]; ncycles = 4; window = [250 450]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w250_alpha_resppositive'; range = [25:36]; bandname = 'alpha'; freqlimits = [9 14]; bins=[[9 14]]; ncycles = 4; window = [250 450]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w250_alpha_resppositive'; range = [37:48]; bandname = 'alpha'; freqlimits = [9 14]; bins=[[9 14]]; ncycles = 4; window = [250 450]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w250_alpha_resppositive'; range = [49:60]; bandname = 'alpha'; freqlimits = [9 14]; bins=[[9 14]]; ncycles = 4; window = [250 450]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w250_alpha_resppositive'; range = [61:72]; bandname = 'alpha'; freqlimits = [9 14]; bins=[[9 14]]; ncycles = 4; window = [250 450]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w250_alpha_resppositive'; range = [73:84]; bandname = 'alpha'; freqlimits = [9 14]; bins=[[9 14]]; ncycles = 4; window = [250 450]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w250_alpha_resppositive'; range = [85:100]; bandname = 'alpha'; freqlimits = [9 14]; bins=[[9 14]]; ncycles = 4; window = [250 450]; extract_meanband; exit" &
sleep 1

# beta 50
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w50_beta_resppositive'; range = [1:12]; bandname = 'beta'; freqlimits = [15 30]; bins=[[15 22]; [23 30]]; ncycles = 5; window = [50 250]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w50_beta_resppositive'; range = [13:24]; bandname = 'beta'; freqlimits = [15 30]; bins=[[15 22]; [23 30]]; ncycles = 5; window = [50 250]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w50_beta_resppositive'; range = [25:36]; bandname = 'beta'; freqlimits = [15 30]; bins=[[15 22]; [23 30]]; ncycles = 5; window = [50 250]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w50_beta_resppositive'; range = [37:48]; bandname = 'beta'; freqlimits = [15 30]; bins=[[15 22]; [23 30]]; ncycles = 5; window = [50 250]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w50_beta_resppositive'; range = [49:60]; bandname = 'beta'; freqlimits = [15 30]; bins=[[15 22]; [23 30]]; ncycles = 5; window = [50 250]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w50_beta_resppositive'; range = [61:72]; bandname = 'beta'; freqlimits = [15 30]; bins=[[15 22]; [23 30]]; ncycles = 5; window = [50 250]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w50_beta_resppositive'; range = [73:84]; bandname = 'beta'; freqlimits = [15 30]; bins=[[15 22]; [23 30]]; ncycles = 5; window = [50 250]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w50_beta_resppositive'; range = [85:100]; bandname = 'beta'; freqlimits = [15 30]; bins=[[15 22]; [23 30]]; ncycles = 5; window = [50 250]; extract_meanband; exit" &
sleep 1

# beta 150
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w150_beta_resppositive'; range = [1:12]; bandname = 'beta'; freqlimits = [15 30]; bins=[[15 22]; [23 30]]; ncycles = 5; window = [150 350]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w150_beta_resppositive'; range = [13:24]; bandname = 'beta'; freqlimits = [15 30]; bins=[[15 22]; [23 30]]; ncycles = 5; window = [150 350]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w150_beta_resppositive'; range = [25:36]; bandname = 'beta'; freqlimits = [15 30]; bins=[[15 22]; [23 30]]; ncycles = 5; window = [150 350]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w150_beta_resppositive'; range = [37:48]; bandname = 'beta'; freqlimits = [15 30]; bins=[[15 22]; [23 30]]; ncycles = 5; window = [150 350]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w150_beta_resppositive'; range = [49:60]; bandname = 'beta'; freqlimits = [15 30]; bins=[[15 22]; [23 30]]; ncycles = 5; window = [150 350]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w150_beta_resppositive'; range = [61:72]; bandname = 'beta'; freqlimits = [15 30]; bins=[[15 22]; [23 30]]; ncycles = 5; window = [150 350]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w150_beta_resppositive'; range = [73:84]; bandname = 'beta'; freqlimits = [15 30]; bins=[[15 22]; [23 30]]; ncycles = 5; window = [150 350]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w150_beta_resppositive'; range = [85:100]; bandname = 'beta'; freqlimits = [15 30]; bins=[[15 22]; [23 30]]; ncycles = 5; window = [150 350]; extract_meanband; exit" &
sleep 1

# beta 250
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w250_beta_resppositive'; range = [1:12]; bandname = 'beta'; freqlimits = [15 30]; bins=[[15 22]; [23 30]]; ncycles = 5; window = [250 450]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w250_beta_resppositive'; range = [13:24]; bandname = 'beta'; freqlimits = [15 30]; bins=[[15 22]; [23 30]]; ncycles = 5; window = [250 450]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w250_beta_resppositive'; range = [25:36]; bandname = 'beta'; freqlimits = [15 30]; bins=[[15 22]; [23 30]]; ncycles = 5; window = [250 450]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w250_beta_resppositive'; range = [37:48]; bandname = 'beta'; freqlimits = [15 30]; bins=[[15 22]; [23 30]]; ncycles = 5; window = [250 450]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w250_beta_resppositive'; range = [49:60]; bandname = 'beta'; freqlimits = [15 30]; bins=[[15 22]; [23 30]]; ncycles = 5; window = [250 450]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w250_beta_resppositive'; range = [61:72]; bandname = 'beta'; freqlimits = [15 30]; bins=[[15 22]; [23 30]]; ncycles = 5; window = [250 450]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w250_beta_resppositive'; range = [73:84]; bandname = 'beta'; freqlimits = [15 30]; bins=[[15 22]; [23 30]]; ncycles = 5; window = [250 450]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w250_beta_resppositive'; range = [85:100]; bandname = 'beta'; freqlimits = [15 30]; bins=[[15 22]; [23 30]]; ncycles = 5; window = [250 450]; extract_meanband; exit" &
sleep 1

# lowgamma 50
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w50_lowgamma_resppositive'; range = [1:12]; bandname = 'lowgamma'; freqlimits = [30 70]; bins=[[30 40]; [41 50]; [51 60]; [61 70]]; ncycles = 6; window = [50 250]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w50_lowgamma_resppositive'; range = [13:24]; bandname = 'lowgamma'; freqlimits = [30 70]; bins=[[30 40]; [41 50]; [51 60]; [61 70]]; ncycles = 6; window = [50 250]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w50_lowgamma_resppositive'; range = [25:36]; bandname = 'lowgamma'; freqlimits = [30 70]; bins=[[30 40]; [41 50]; [51 60]; [61 70]]; ncycles = 6; window = [50 250]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w50_lowgamma_resppositive'; range = [37:48]; bandname = 'lowgamma'; freqlimits = [30 70]; bins=[[30 40]; [41 50]; [51 60]; [61 70]]; ncycles = 6; window = [50 250]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w50_lowgamma_resppositive'; range = [49:60]; bandname = 'lowgamma'; freqlimits = [30 70]; bins=[[30 40]; [41 50]; [51 60]; [61 70]]; ncycles = 6; window = [50 250]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w50_lowgamma_resppositive'; range = [61:72]; bandname = 'lowgamma'; freqlimits = [30 70]; bins=[[30 40]; [41 50]; [51 60]; [61 70]]; ncycles = 6; window = [50 250]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w50_lowgamma_resppositive'; range = [73:84]; bandname = 'lowgamma'; freqlimits = [30 70]; bins=[[30 40]; [41 50]; [51 60]; [61 70]]; ncycles = 6; window = [50 250]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w50_lowgamma_resppositive'; range = [85:100]; bandname = 'lowgamma'; freqlimits = [30 70]; bins=[[30 40]; [41 50]; [51 60]; [61 70]]; ncycles = 6; window = [50 250]; extract_meanband; exit" &
sleep 1

# lowgamma 150
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w150_lowgamma_resppositive'; range = [1:12]; bandname = 'lowgamma'; freqlimits = [30 70]; bins=[[30 40]; [41 50]; [51 60]; [61 70]]; ncycles = 6; window = [150 350]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w150_lowgamma_resppositive'; range = [13:24]; bandname = 'lowgamma'; freqlimits = [30 70]; bins=[[30 40]; [41 50]; [51 60]; [61 70]]; ncycles = 6; window = [150 350]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w150_lowgamma_resppositive'; range = [25:36]; bandname = 'lowgamma'; freqlimits = [30 70]; bins=[[30 40]; [41 50]; [51 60]; [61 70]]; ncycles = 6; window = [150 350]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w150_lowgamma_resppositive'; range = [37:48]; bandname = 'lowgamma'; freqlimits = [30 70]; bins=[[30 40]; [41 50]; [51 60]; [61 70]]; ncycles = 6; window = [150 350]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w150_lowgamma_resppositive'; range = [49:60]; bandname = 'lowgamma'; freqlimits = [30 70]; bins=[[30 40]; [41 50]; [51 60]; [61 70]]; ncycles = 6; window = [150 350]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w150_lowgamma_resppositive'; range = [61:72]; bandname = 'lowgamma'; freqlimits = [30 70]; bins=[[30 40]; [41 50]; [51 60]; [61 70]]; ncycles = 6; window = [150 350]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w150_lowgamma_resppositive'; range = [73:84]; bandname = 'lowgamma'; freqlimits = [30 70]; bins=[[30 40]; [41 50]; [51 60]; [61 70]]; ncycles = 6; window = [150 350]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w150_lowgamma_resppositive'; range = [85:100]; bandname = 'lowgamma'; freqlimits = [30 70]; bins=[[30 40]; [41 50]; [51 60]; [61 70]]; ncycles = 6; window = [150 350]; extract_meanband; exit" &
sleep 1

# lowgamma 250
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w250_lowgamma_resppositive'; range = [1:12]; bandname = 'lowgamma'; freqlimits = [30 70]; bins=[[30 40]; [41 50]; [51 60]; [61 70]]; ncycles = 6; window = [250 450]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w250_lowgamma_resppositive'; range = [13:24]; bandname = 'lowgamma'; freqlimits = [30 70]; bins=[[30 40]; [41 50]; [51 60]; [61 70]]; ncycles = 6; window = [250 450]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w250_lowgamma_resppositive'; range = [25:36]; bandname = 'lowgamma'; freqlimits = [30 70]; bins=[[30 40]; [41 50]; [51 60]; [61 70]]; ncycles = 6; window = [250 450]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w250_lowgamma_resppositive'; range = [37:48]; bandname = 'lowgamma'; freqlimits = [30 70]; bins=[[30 40]; [41 50]; [51 60]; [61 70]]; ncycles = 6; window = [250 450]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w250_lowgamma_resppositive'; range = [49:60]; bandname = 'lowgamma'; freqlimits = [30 70]; bins=[[30 40]; [41 50]; [51 60]; [61 70]]; ncycles = 6; window = [250 450]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w250_lowgamma_resppositive'; range = [61:72]; bandname = 'lowgamma'; freqlimits = [30 70]; bins=[[30 40]; [41 50]; [51 60]; [61 70]]; ncycles = 6; window = [250 450]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w250_lowgamma_resppositive'; range = [73:84]; bandname = 'lowgamma'; freqlimits = [30 70]; bins=[[30 40]; [41 50]; [51 60]; [61 70]]; ncycles = 6; window = [250 450]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w250_lowgamma_resppositive'; range = [85:100]; bandname = 'lowgamma'; freqlimits = [30 70]; bins=[[30 40]; [41 50]; [51 60]; [61 70]]; ncycles = 6; window = [250 450]; extract_meanband; exit" &
sleep 1

# highgamma 50
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w50_highgamma_resppositive'; range = [1:12]; bandname = 'highgamma'; freqlimits = [70 150]; bins=[[70 80]; [81 90]; [91 100]; [101 110]; [111 120]; [121 130]; [131 140]; [141 150]]; ncycles = 6; window = [50 250]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w50_highgamma_resppositive'; range = [13:24]; bandname = 'highgamma'; freqlimits = [70 150]; bins=[[70 80]; [81 90]; [91 100]; [101 110]; [111 120]; [121 130]; [131 140]; [141 150]]; ncycles = 6; window = [50 250]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w50_highgamma_resppositive'; range = [25:36]; bandname = 'highgamma'; freqlimits = [70 150]; bins=[[70 80]; [81 90]; [91 100]; [101 110]; [111 120]; [121 130]; [131 140]; [141 150]]; ncycles = 6; window = [50 250]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w50_highgamma_resppositive'; range = [37:48]; bandname = 'highgamma'; freqlimits = [70 150]; bins=[[70 80]; [81 90]; [91 100]; [101 110]; [111 120]; [121 130]; [131 140]; [141 150]]; ncycles = 6; window = [50 250]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w50_highgamma_resppositive'; range = [49:60]; bandname = 'highgamma'; freqlimits = [70 150]; bins=[[70 80]; [81 90]; [91 100]; [101 110]; [111 120]; [121 130]; [131 140]; [141 150]]; ncycles = 6; window = [50 250]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w50_highgamma_resppositive'; range = [61:72]; bandname = 'highgamma'; freqlimits = [70 150]; bins=[[70 80]; [81 90]; [91 100]; [101 110]; [111 120]; [121 130]; [131 140]; [141 150]]; ncycles = 6; window = [50 250]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w50_highgamma_resppositive'; range = [73:84]; bandname = 'highgamma'; freqlimits = [70 150]; bins=[[70 80]; [81 90]; [91 100]; [101 110]; [111 120]; [121 130]; [131 140]; [141 150]]; ncycles = 6; window = [50 250]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w50_highgamma_resppositive'; range = [85:100]; bandname = 'highgamma'; freqlimits = [70 150]; bins=[[70 80]; [81 90]; [91 100]; [101 110]; [111 120]; [121 130]; [131 140]; [141 150]]; ncycles = 6; window = [50 250]; extract_meanband; exit" &
sleep 1

# highgamma 150
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w150_highgamma_resppositive'; range = [1:12]; bandname = 'highgamma'; freqlimits = [70 150]; bins=[[70 80]; [81 90]; [91 100]; [101 110]; [111 120]; [121 130]; [131 140]; [141 150]]; ncycles = 6; window = [150 350]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w150_highgamma_resppositive'; range = [13:24]; bandname = 'highgamma'; freqlimits = [70 150]; bins=[[70 80]; [81 90]; [91 100]; [101 110]; [111 120]; [121 130]; [131 140]; [141 150]]; ncycles = 6; window = [150 350]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w150_highgamma_resppositive'; range = [25:36]; bandname = 'highgamma'; freqlimits = [70 150]; bins=[[70 80]; [81 90]; [91 100]; [101 110]; [111 120]; [121 130]; [131 140]; [141 150]]; ncycles = 6; window = [150 350]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w150_highgamma_resppositive'; range = [37:48]; bandname = 'highgamma'; freqlimits = [70 150]; bins=[[70 80]; [81 90]; [91 100]; [101 110]; [111 120]; [121 130]; [131 140]; [141 150]]; ncycles = 6; window = [150 350]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w150_highgamma_resppositive'; range = [49:60]; bandname = 'highgamma'; freqlimits = [70 150]; bins=[[70 80]; [81 90]; [91 100]; [101 110]; [111 120]; [121 130]; [131 140]; [141 150]]; ncycles = 6; window = [150 350]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w150_highgamma_resppositive'; range = [61:72]; bandname = 'highgamma'; freqlimits = [70 150]; bins=[[70 80]; [81 90]; [91 100]; [101 110]; [111 120]; [121 130]; [131 140]; [141 150]]; ncycles = 6; window = [150 350]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w150_highgamma_resppositive'; range = [73:84]; bandname = 'highgamma'; freqlimits = [70 150]; bins=[[70 80]; [81 90]; [91 100]; [101 110]; [111 120]; [121 130]; [131 140]; [141 150]]; ncycles = 6; window = [150 350]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w150_highgamma_resppositive'; range = [85:100]; bandname = 'highgamma'; freqlimits = [70 150]; bins=[[70 80]; [81 90]; [91 100]; [101 110]; [111 120]; [121 130]; [131 140]; [141 150]]; ncycles = 6; window = [150 350]; extract_meanband; exit" &
sleep 1

# highgamma 250
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w250_highgamma_resppositive'; range = [1:12]; bandname = 'highgamma'; freqlimits = [70 150]; bins=[[70 80]; [81 90]; [91 100]; [101 110]; [111 120]; [121 130]; [131 140]; [141 150]]; ncycles = 6; window = [250 450]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w250_highgamma_resppositive'; range = [13:24]; bandname = 'highgamma'; freqlimits = [70 150]; bins=[[70 80]; [81 90]; [91 100]; [101 110]; [111 120]; [121 130]; [131 140]; [141 150]]; ncycles = 6; window = [250 450]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w250_highgamma_resppositive'; range = [25:36]; bandname = 'highgamma'; freqlimits = [70 150]; bins=[[70 80]; [81 90]; [91 100]; [101 110]; [111 120]; [121 130]; [131 140]; [141 150]]; ncycles = 6; window = [250 450]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w250_highgamma_resppositive'; range = [37:48]; bandname = 'highgamma'; freqlimits = [70 150]; bins=[[70 80]; [81 90]; [91 100]; [101 110]; [111 120]; [121 130]; [131 140]; [141 150]]; ncycles = 6; window = [250 450]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w250_highgamma_resppositive'; range = [49:60]; bandname = 'highgamma'; freqlimits = [70 150]; bins=[[70 80]; [81 90]; [91 100]; [101 110]; [111 120]; [121 130]; [131 140]; [141 150]]; ncycles = 6; window = [250 450]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w250_highgamma_resppositive'; range = [61:72]; bandname = 'highgamma'; freqlimits = [70 150]; bins=[[70 80]; [81 90]; [91 100]; [101 110]; [111 120]; [121 130]; [131 140]; [141 150]]; ncycles = 6; window = [250 450]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w250_highgamma_resppositive'; range = [73:84]; bandname = 'highgamma'; freqlimits = [70 150]; bins=[[70 80]; [81 90]; [91 100]; [101 110]; [111 120]; [121 130]; [131 140]; [141 150]]; ncycles = 6; window = [250 450]; extract_meanband; exit" &
sleep 1
srun --partition=main,long -n 1 --exclude=$EXCLUDE --mem=2000 -t 24:00:00 matlab -nojvm -nodisplay -nosplash -r "indata = 'LFP_5c_artif_bipolar_BA_w250_highgamma_resppositive'; range = [85:100]; bandname = 'highgamma'; freqlimits = [70 150]; bins=[[70 80]; [81 90]; [91 100]; [101 110]; [111 120]; [121 130]; [131 140]; [141 150]]; ncycles = 6; window = [250 450]; extract_meanband; exit" &

echo 'All sent.'
