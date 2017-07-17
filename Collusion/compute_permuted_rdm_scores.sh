#!/bin/bash

echo " " > compute_permuted_rdm_scores_alexnet_runnable.sh
echo " " > compute_permuted_rdm_scores_alexnetrandom_runnable.sh

# theta
#python compute_permuted_rdm_scores.py -f meantheta_LFP_5c_artif_bipolar_BA_w50_theta_resppositive -d euclidean -o matrix -t 1.0 -n alexnet >> compute_permuted_rdm_scores_alexnet_runnable.sh
#python compute_permuted_rdm_scores.py -f meantheta_LFP_5c_artif_bipolar_BA_w150_theta_resppositive -d euclidean -o matrix -t 1.0 -n alexnet >> compute_permuted_rdm_scores_alexnet_runnable.sh
#python compute_permuted_rdm_scores.py -f meantheta_LFP_5c_artif_bipolar_BA_w250_theta_resppositive -d euclidean -o matrix -t 1.0 -n alexnet >> compute_permuted_rdm_scores_alexnet_runnable.sh
#python compute_permuted_rdm_scores.py -f meantheta_LFP_5c_artif_bipolar_BA_w50_theta_resppositive -d euclidean -o matrix -t 1.0 -n alexnetrandom >> compute_permuted_rdm_scores_alexnetrandom_runnable.sh
#python compute_permuted_rdm_scores.py -f meantheta_LFP_5c_artif_bipolar_BA_w150_theta_resppositive -d euclidean -o matrix -t 1.0 -n alexnetrandom >> compute_permuted_rdm_scores_alexnetrandom_runnable.sh
#python compute_permuted_rdm_scores.py -f meantheta_LFP_5c_artif_bipolar_BA_w250_theta_resppositive -d euclidean -o matrix -t 1.0 -n alexnetrandom >> compute_permuted_rdm_scores_alexnetrandom_runnable.sh

# alpha
#python compute_permuted_rdm_scores.py -f meanalpha_LFP_5c_artif_bipolar_BA_w50_alpha_resppositive -d euclidean -o matrix -t 1.0 -n alexnet >> compute_permuted_rdm_scores_alexnet_runnable.sh
#python compute_permuted_rdm_scores.py -f meanalpha_LFP_5c_artif_bipolar_BA_w150_alpha_resppositive -d euclidean -o matrix -t 1.0 -n alexnet >> compute_permuted_rdm_scores_alexnet_runnable.sh
#python compute_permuted_rdm_scores.py -f meanalpha_LFP_5c_artif_bipolar_BA_w250_alpha_resppositive -d euclidean -o matrix -t 1.0 -n alexnet >> compute_permuted_rdm_scores_alexnet_runnable.sh
#python compute_permuted_rdm_scores.py -f meanalpha_LFP_5c_artif_bipolar_BA_w50_alpha_resppositive -d euclidean -o matrix -t 1.0 -n alexnetrandom >> compute_permuted_rdm_scores_alexnetrandom_runnable.sh
#python compute_permuted_rdm_scores.py -f meanalpha_LFP_5c_artif_bipolar_BA_w150_alpha_resppositive -d euclidean -o matrix -t 1.0 -n alexnetrandom >> compute_permuted_rdm_scores_alexnetrandom_runnable.sh
#python compute_permuted_rdm_scores.py -f meanalpha_LFP_5c_artif_bipolar_BA_w250_alpha_resppositive -d euclidean -o matrix -t 1.0 -n alexnetrandom >> compute_permuted_rdm_scores_alexnetrandom_runnable.sh

# beta
python compute_permuted_rdm_scores.py -f meanbeta_LFP_5c_artif_bipolar_BA_w50_beta_resppositive -d euclidean -o matrix -t 1.0 -n alexnet >> compute_permuted_rdm_scores_alexnet_runnable.sh
python compute_permuted_rdm_scores.py -f meanbeta_LFP_5c_artif_bipolar_BA_w150_beta_resppositive -d euclidean -o matrix -t 1.0 -n alexnet >> compute_permuted_rdm_scores_alexnet_runnable.sh
python compute_permuted_rdm_scores.py -f meanbeta_LFP_5c_artif_bipolar_BA_w250_beta_resppositive -d euclidean -o matrix -t 1.0 -n alexnet >> compute_permuted_rdm_scores_alexnet_runnable.sh
python compute_permuted_rdm_scores.py -f meanbeta_LFP_5c_artif_bipolar_BA_w50_beta_resppositive -d euclidean -o matrix -t 1.0 -n alexnetrandom >> compute_permuted_rdm_scores_alexnetrandom_runnable.sh
python compute_permuted_rdm_scores.py -f meanbeta_LFP_5c_artif_bipolar_BA_w150_beta_resppositive -d euclidean -o matrix -t 1.0 -n alexnetrandom >> compute_permuted_rdm_scores_alexnetrandom_runnable.sh
python compute_permuted_rdm_scores.py -f meanbeta_LFP_5c_artif_bipolar_BA_w250_beta_resppositive -d euclidean -o matrix -t 1.0 -n alexnetrandom >> compute_permuted_rdm_scores_alexnetrandom_runnable.sh

# lowgamma
python compute_permuted_rdm_scores.py -f meanlowgamma_LFP_5c_artif_bipolar_BA_w50_lowgamma_resppositive -d euclidean -o matrix -t 1.0 -n alexnet >> compute_permuted_rdm_scores_alexnet_runnable.sh
python compute_permuted_rdm_scores.py -f meanlowgamma_LFP_5c_artif_bipolar_BA_w150_lowgamma_resppositive -d euclidean -o matrix -t 1.0 -n alexnet >> compute_permuted_rdm_scores_alexnet_runnable.sh
python compute_permuted_rdm_scores.py -f meanlowgamma_LFP_5c_artif_bipolar_BA_w250_lowgamma_resppositive -d euclidean -o matrix -t 1.0 -n alexnet >> compute_permuted_rdm_scores_alexnet_runnable.sh
python compute_permuted_rdm_scores.py -f meanlowgamma_LFP_5c_artif_bipolar_BA_w50_lowgamma_resppositive -d euclidean -o matrix -t 1.0 -n alexnetrandom >> compute_permuted_rdm_scores_alexnetrandom_runnable.sh
python compute_permuted_rdm_scores.py -f meanlowgamma_LFP_5c_artif_bipolar_BA_w150_lowgamma_resppositive -d euclidean -o matrix -t 1.0 -n alexnetrandom >> compute_permuted_rdm_scores_alexnetrandom_runnable.sh
python compute_permuted_rdm_scores.py -f meanlowgamma_LFP_5c_artif_bipolar_BA_w250_lowgamma_resppositive -d euclidean -o matrix -t 1.0 -n alexnetrandom >> compute_permuted_rdm_scores_alexnetrandom_runnable.sh

# highgamma
python compute_permuted_rdm_scores.py -f meanhighgamma_LFP_5c_artif_bipolar_BA_w50_highgamma_resppositive -d euclidean -o matrix -t 1.0 -n alexnet >> compute_permuted_rdm_scores_alexnet_runnable.sh
python compute_permuted_rdm_scores.py -f meanhighgamma_LFP_5c_artif_bipolar_BA_w150_highgamma_resppositive -d euclidean -o matrix -t 1.0 -n alexnet >> compute_permuted_rdm_scores_alexnet_runnable.sh
python compute_permuted_rdm_scores.py -f meanhighgamma_LFP_5c_artif_bipolar_BA_w250_highgamma_resppositive -d euclidean -o matrix -t 1.0 -n alexnet >> compute_permuted_rdm_scores_alexnet_runnable.sh
python compute_permuted_rdm_scores.py -f meanhighgamma_LFP_5c_artif_bipolar_BA_w50_highgamma_resppositive -d euclidean -o matrix -t 1.0 -n alexnetrandom >> compute_permuted_rdm_scores_alexnetrandom_runnable.sh
python compute_permuted_rdm_scores.py -f meanhighgamma_LFP_5c_artif_bipolar_BA_w150_highgamma_resppositive -d euclidean -o matrix -t 1.0 -n alexnetrandom >> compute_permuted_rdm_scores_alexnetrandom_runnable.sh
python compute_permuted_rdm_scores.py -f meanhighgamma_LFP_5c_artif_bipolar_BA_w250_highgamma_resppositive -d euclidean -o matrix -t 1.0 -n alexnetrandom >> compute_permuted_rdm_scores_alexnetrandom_runnable.sh

# run it all
chmod +x compute_permuted_rdm_scores_alexnet_runnable.sh
chmod +x compute_permuted_rdm_scores_alexnetrandom_runnable.sh
sleep 2
./compute_permuted_rdm_scores_alexnet_runnable.sh &
sleep 3
./compute_permuted_rdm_scores_alexnetrandom_runnable.sh &