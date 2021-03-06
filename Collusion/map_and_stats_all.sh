#!/bin/bash

# theta
srun --partition=long,phi,main -c 4 --mem=16000 python Mapper.py -b rsa -f meantheta_LFP_5c_artif_bipolar_BA_w50_theta_resppositive -d euclidean -o matrix -t 1.0 -s corr -p True -g layer_area_score_visual -n alexnet &
sleep 1
srun --partition=long,phi,main -c 4 --mem=16000 python Mapper.py -b rsa -f meantheta_LFP_5c_artif_bipolar_BA_w150_theta_resppositive -d euclidean -o matrix -t 1.0 -s corr -p True -g layer_area_score_visual -n alexnet &
sleep 1
srun --partition=long,phi,main -c 4 --mem=16000 python Mapper.py -b rsa -f meantheta_LFP_5c_artif_bipolar_BA_w250_theta_resppositive -d euclidean -o matrix -t 1.0 -s corr -p True -g layer_area_score_visual -n alexnet &
sleep 1
#srun --partition=long,phi,main -c 4 --mem=16000 python Mapper.py -b rsa -f meantheta_LFP_5c_artif_bipolar_BA_w50_theta_resppositive -d euclidean -o matrix -t 1.0 -s corr -p True -g layer_area_score_visual -n alexnetrandom &
#sleep 1
#srun --partition=long,phi,main -c 4 --mem=16000 python Mapper.py -b rsa -f meantheta_LFP_5c_artif_bipolar_BA_w150_theta_resppositive -d euclidean -o matrix -t 1.0 -s corr -p True -g layer_area_score_visual -n alexnetrandom &
#sleep 1
#srun --partition=long,phi,main -c 4 --mem=16000 python Mapper.py -b rsa -f meantheta_LFP_5c_artif_bipolar_BA_w250_theta_resppositive -d euclidean -o matrix -t 1.0 -s corr -p True -g layer_area_score_visual -n alexnetrandom &
#sleep 1

# alpha
srun --partition=long,phi,main -c 4 --mem=16000 python Mapper.py -b rsa -f meanalpha_LFP_5c_artif_bipolar_BA_w50_alpha_resppositive -d euclidean -o matrix -t 1.0 -s corr -p True -g layer_area_score_visual -n alexnet &
sleep 1
srun --partition=long,phi,main -c 4 --mem=16000 python Mapper.py -b rsa -f meanalpha_LFP_5c_artif_bipolar_BA_w150_alpha_resppositive -d euclidean -o matrix -t 1.0 -s corr -p True -g layer_area_score_visual -n alexnet &
sleep 1
srun --partition=long,phi,main -c 4 --mem=16000 python Mapper.py -b rsa -f meanalpha_LFP_5c_artif_bipolar_BA_w250_alpha_resppositive -d euclidean -o matrix -t 1.0 -s corr -p True -g layer_area_score_visual -n alexnet &
sleep 1
#srun --partition=long,phi,main -c 4 --mem=16000 python Mapper.py -b rsa -f meanalpha_LFP_5c_artif_bipolar_BA_w50_alpha_resppositive -d euclidean -o matrix -t 1.0 -s corr -p True -g layer_area_score_visual -n alexnetrandom &
#sleep 1
#srun --partition=long,phi,main -c 4 --mem=16000 python Mapper.py -b rsa -f meanalpha_LFP_5c_artif_bipolar_BA_w150_alpha_resppositive -d euclidean -o matrix -t 1.0 -s corr -p True -g layer_area_score_visual -n alexnetrandom &
#sleep 1
#srun --partition=long,phi,main -c 4 --mem=16000 python Mapper.py -b rsa -f meanalpha_LFP_5c_artif_bipolar_BA_w250_alpha_resppositive -d euclidean -o matrix -t 1.0 -s corr -p True -g layer_area_score_visual -n alexnetrandom &
#sleep 1

# beta
srun --partition=long,phi,main -c 4 --mem=16000 python Mapper.py -b rsa -f meanbeta_LFP_5c_artif_bipolar_BA_w50_beta_resppositive -d euclidean -o matrix -t 1.0 -s corr -p True -g layer_area_score_visual -n alexnet &
sleep 1
srun --partition=long,phi,main -c 4 --mem=16000 python Mapper.py -b rsa -f meanbeta_LFP_5c_artif_bipolar_BA_w150_beta_resppositive -d euclidean -o matrix -t 1.0 -s corr -p True -g layer_area_score_visual -n alexnet &
sleep 1
srun --partition=long,phi,main -c 4 --mem=16000 python Mapper.py -b rsa -f meanbeta_LFP_5c_artif_bipolar_BA_w250_beta_resppositive -d euclidean -o matrix -t 1.0 -s corr -p True -g layer_area_score_visual -n alexnet &
sleep 1
#srun --partition=long,phi,main -c 4 --mem=16000 python Mapper.py -b rsa -f meanbeta_LFP_5c_artif_bipolar_BA_w50_beta_resppositive -d euclidean -o matrix -t 1.0 -s corr -p True -g layer_area_score_visual -n alexnetrandom &
#sleep 1
#srun --partition=long,phi,main -c 4 --mem=16000 python Mapper.py -b rsa -f meanbeta_LFP_5c_artif_bipolar_BA_w150_beta_resppositive -d euclidean -o matrix -t 1.0 -s corr -p True -g layer_area_score_visual -n alexnetrandom &
#sleep 1
#srun --partition=long,phi,main -c 4 --mem=16000 python Mapper.py -b rsa -f meanbeta_LFP_5c_artif_bipolar_BA_w250_beta_resppositive -d euclidean -o matrix -t 1.0 -s corr -p True -g layer_area_score_visual -n alexnetrandom &
#sleep 1

# low gamma
srun --partition=long,phi,main -c 4 --mem=16000 python Mapper.py -b rsa -f meanlowgamma_LFP_5c_artif_bipolar_BA_w50_lowgamma_resppositive -d euclidean -o matrix -t 1.0 -s corr -p True -g layer_area_score_visual -n alexnet &
sleep 1
srun --partition=long,phi,main -c 4 --mem=16000 python Mapper.py -b rsa -f meanlowgamma_LFP_5c_artif_bipolar_BA_w150_lowgamma_resppositive -d euclidean -o matrix -t 1.0 -s corr -p True -g layer_area_score_visual -n alexnet &
sleep 1
srun --partition=long,phi,main -c 4 --mem=16000 python Mapper.py -b rsa -f meanlowgamma_LFP_5c_artif_bipolar_BA_w250_lowgamma_resppositive -d euclidean -o matrix -t 1.0 -s corr -p True -g layer_area_score_visual -n alexnet &
sleep 1
#srun --partition=long,phi,main -c 4 --mem=16000 python Mapper.py -b rsa -f meanlowgamma_LFP_5c_artif_bipolar_BA_w50_lowgamma_resppositive -d euclidean -o matrix -t 1.0 -s corr -p True -g layer_area_score_visual -n alexnetrandom &
#sleep 1
#srun --partition=long,phi,main -c 4 --mem=16000 python Mapper.py -b rsa -f meanlowgamma_LFP_5c_artif_bipolar_BA_w150_lowgamma_resppositive -d euclidean -o matrix -t 1.0 -s corr -p True -g layer_area_score_visual -n alexnetrandom &
#sleep 1
#srun --partition=long,phi,main -c 4 --mem=16000 python Mapper.py -b rsa -f meanlowgamma_LFP_5c_artif_bipolar_BA_w250_lowgamma_resppositive -d euclidean -o matrix -t 1.0 -s corr -p True -g layer_area_score_visual -n alexnetrandom &
#sleep 1

# high gamma
srun --partition=long,phi,main -c 4 --mem=16000 python Mapper.py -b rsa -f meanhighgamma_LFP_5c_artif_bipolar_BA_w50_highgamma_resppositive -d euclidean -o matrix -t 1.0 -s corr -p True -g layer_area_score_visual -n alexnet &
sleep 1
srun --partition=long,phi,main -c 4 --mem=16000 python Mapper.py -b rsa -f meanhighgamma_LFP_5c_artif_bipolar_BA_w150_highgamma_resppositive -d euclidean -o matrix -t 1.0 -s corr -p True -g layer_area_score_visual -n alexnet &
sleep 1
srun --partition=long,phi,main -c 4 --mem=16000 python Mapper.py -b rsa -f meanhighgamma_LFP_5c_artif_bipolar_BA_w250_highgamma_resppositive -d euclidean -o matrix -t 1.0 -s corr -p True -g layer_area_score_visual -n alexnet &
sleep 1
#srun --partition=long,phi,main -c 4 --mem=16000 python Mapper.py -b rsa -f meanhighgamma_LFP_5c_artif_bipolar_BA_w50_highgamma_resppositive -d euclidean -o matrix -t 1.0 -s corr -p True -g layer_area_score_visual -n alexnetrandom &
#sleep 1
#srun --partition=long,phi,main -c 4 --mem=16000 python Mapper.py -b rsa -f meanhighgamma_LFP_5c_artif_bipolar_BA_w150_highgamma_resppositive -d euclidean -o matrix -t 1.0 -s corr -p True -g layer_area_score_visual -n alexnetrandom &
#sleep 1
#srun --partition=long,phi,main -c 4 --mem=16000 python Mapper.py -b rsa -f meanhighgamma_LFP_5c_artif_bipolar_BA_w250_highgamma_resppositive -d euclidean -o matrix -t 1.0 -s corr -p True -g layer_area_score_visual -n alexnetrandom &
#sleep 1

echo 'All sent'