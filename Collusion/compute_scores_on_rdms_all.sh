#!/bin/bash

# theta
./compute_scores_on_rdms.sh meantheta_LFP_5c_artif_bipolar_BA_w50_theta_resppositive euclidean matrix 1.0 alexnet &
sleep 1
./compute_scores_on_rdms.sh meantheta_LFP_5c_artif_bipolar_BA_w150_theta_resppositive euclidean matrix 1.0 alexnet &
sleep 1
./compute_scores_on_rdms.sh meantheta_LFP_5c_artif_bipolar_BA_w250_theta_resppositive euclidean matrix 1.0 alexnet &
sleep 1
./compute_scores_on_rdms.sh meantheta_LFP_5c_artif_bipolar_BA_w50_theta_resppositive euclidean matrix 1.0 alexnetrandom &
sleep 1
./compute_scores_on_rdms.sh meantheta_LFP_5c_artif_bipolar_BA_w150_theta_resppositive euclidean matrix 1.0 alexnetrandom &
sleep 1
./compute_scores_on_rdms.sh meantheta_LFP_5c_artif_bipolar_BA_w250_theta_resppositive euclidean matrix 1.0 alexnetrandom &
sleep 1

# alpha
./compute_scores_on_rdms.sh meanalpha_LFP_5c_artif_bipolar_BA_w50_alpha_resppositive euclidean matrix 1.0 alexnet &
sleep 1
./compute_scores_on_rdms.sh meanalpha_LFP_5c_artif_bipolar_BA_w150_alpha_resppositive euclidean matrix 1.0 alexnet &
sleep 1
./compute_scores_on_rdms.sh meanalpha_LFP_5c_artif_bipolar_BA_w250_alpha_resppositive euclidean matrix 1.0 alexnet &
sleep 1
./compute_scores_on_rdms.sh meanalpha_LFP_5c_artif_bipolar_BA_w50_alpha_resppositive euclidean matrix 1.0 alexnetrandom &
sleep 1
./compute_scores_on_rdms.sh meanalpha_LFP_5c_artif_bipolar_BA_w150_alpha_resppositive euclidean matrix 1.0 alexnetrandom &
sleep 1
./compute_scores_on_rdms.sh meanalpha_LFP_5c_artif_bipolar_BA_w250_alpha_resppositive euclidean matrix 1.0 alexnetrandom &
sleep 1

# beta
./compute_scores_on_rdms.sh meanbeta_LFP_5c_artif_bipolar_BA_w50_beta_resppositive euclidean matrix 1.0 alexnet &
sleep 1
./compute_scores_on_rdms.sh meanbeta_LFP_5c_artif_bipolar_BA_w150_beta_resppositive euclidean matrix 1.0 alexnet &
sleep 1
./compute_scores_on_rdms.sh meanbeta_LFP_5c_artif_bipolar_BA_w250_beta_resppositive euclidean matrix 1.0 alexnet &
sleep 1
./compute_scores_on_rdms.sh meanbeta_LFP_5c_artif_bipolar_BA_w50_beta_resppositive euclidean matrix 1.0 alexnetrandom &
sleep 1
./compute_scores_on_rdms.sh meanbeta_LFP_5c_artif_bipolar_BA_w150_beta_resppositive euclidean matrix 1.0 alexnetrandom &
sleep 1
./compute_scores_on_rdms.sh meanbeta_LFP_5c_artif_bipolar_BA_w250_beta_resppositive euclidean matrix 1.0 alexnetrandom &
sleep 1

# lowgamma
./compute_scores_on_rdms.sh meanlowgamma_LFP_5c_artif_bipolar_BA_w50_lowgamma_resppositive euclidean matrix 1.0 alexnet &
sleep 1
./compute_scores_on_rdms.sh meanlowgamma_LFP_5c_artif_bipolar_BA_w150_lowgamma_resppositive euclidean matrix 1.0 alexnet &
sleep 1
./compute_scores_on_rdms.sh meanlowgamma_LFP_5c_artif_bipolar_BA_w250_lowgamma_resppositive euclidean matrix 1.0 alexnet &
sleep 1
./compute_scores_on_rdms.sh meanlowgamma_LFP_5c_artif_bipolar_BA_w50_lowgamma_resppositive euclidean matrix 1.0 alexnetrandom &
sleep 1
./compute_scores_on_rdms.sh meanlowgamma_LFP_5c_artif_bipolar_BA_w150_lowgamma_resppositive euclidean matrix 1.0 alexnetrandom &
sleep 1
./compute_scores_on_rdms.sh meanlowgamma_LFP_5c_artif_bipolar_BA_w250_lowgamma_resppositive euclidean matrix 1.0 alexnetrandom &
sleep 1

# highgamma
./compute_scores_on_rdms.sh meanhighgamma_LFP_5c_artif_bipolar_BA_w50_highgamma_resppositive euclidean matrix 1.0 alexnet &
sleep 1
./compute_scores_on_rdms.sh meanhighgamma_LFP_5c_artif_bipolar_BA_w150_highgamma_resppositive euclidean matrix 1.0 alexnet &
sleep 1
./compute_scores_on_rdms.sh meanhighgamma_LFP_5c_artif_bipolar_BA_w250_highgamma_resppositive euclidean matrix 1.0 alexnet &
sleep 1
./compute_scores_on_rdms.sh meanhighgamma_LFP_5c_artif_bipolar_BA_w50_highgamma_resppositive euclidean matrix 1.0 alexnetrandom &
sleep 1
./compute_scores_on_rdms.sh meanhighgamma_LFP_5c_artif_bipolar_BA_w150_highgamma_resppositive euclidean matrix 1.0 alexnetrandom &
sleep 1
./compute_scores_on_rdms.sh meanhighgamma_LFP_5c_artif_bipolar_BA_w250_highgamma_resppositive euclidean matrix 1.0 alexnetrandom &
sleep 1