#!/bin/bash

# theta
./compute_rdm_matrices.sh meantheta_LFP_5c_artif_bipolar_BA_w50_theta_resppositive euclidean & 
./compute_rdm_matrices.sh meantheta_LFP_5c_artif_bipolar_BA_w150_theta_resppositive euclidean & 
./compute_rdm_matrices.sh meantheta_LFP_5c_artif_bipolar_BA_w250_theta_resppositive euclidean & 

# alpha
./compute_rdm_matrices.sh meanalpha_LFP_5c_artif_bipolar_BA_w50_alpha_resppositive euclidean & 
./compute_rdm_matrices.sh meanalpha_LFP_5c_artif_bipolar_BA_w150_alpha_resppositive euclidean & 
./compute_rdm_matrices.sh meanalpha_LFP_5c_artif_bipolar_BA_w250_alpha_resppositive euclidean & 

# beta
./compute_rdm_matrices.sh meanbeta_LFP_5c_artif_bipolar_BA_w50_beta_resppositive euclidean & 
./compute_rdm_matrices.sh meanbeta_LFP_5c_artif_bipolar_BA_w150_beta_resppositive euclidean & 
./compute_rdm_matrices.sh meanbeta_LFP_5c_artif_bipolar_BA_w250_beta_resppositive euclidean & 

# low gamma
./compute_rdm_matrices.sh meanlowgamma_LFP_5c_artif_bipolar_BA_w50_lowgamma_resppositive euclidean & 
./compute_rdm_matrices.sh meanlowgamma_LFP_5c_artif_bipolar_BA_w150_lowgamma_resppositive euclidean & 
./compute_rdm_matrices.sh meanlowgamma_LFP_5c_artif_bipolar_BA_w250_lowgamma_resppositive euclidean & 

# high gamma
./compute_rdm_matrices.sh meanhighgamma_LFP_5c_artif_bipolar_BA_w50_highgamma_resppositive euclidean & 
./compute_rdm_matrices.sh meanhighgamma_LFP_5c_artif_bipolar_BA_w150_highgamma_resppositive euclidean & 
./compute_rdm_matrices.sh meanhighgamma_LFP_5c_artif_bipolar_BA_w250_highgamma_resppositive euclidean & 
