Activations of Deep Convolutional Neural Network are Aligned with Gamma Band Activity of Human Visual Cortex
============================================================================================================
Research article by [Ilya Kuzovkin](http://www.ikuz.eu), [Raul Vicente](http://neuro.cs.ut.ee/people), Mathilde Petton, Jean-Philippe Lachaux, Monica Baciu, Philippe Kahane, Sylvain Rheims, Juan R. Vidal and [Jaan Aru](http://neuro.cs.ut.ee/people). 

## Abstract
Previous work demonstrated a direct correspondence between the hierarchy of the human visual areas and layers of deep convolutional neural networks (DCNN) trained on visual object recognition. We used DCNNs to investigate which frequency bands carry feature transformations of increasing complexity along the ventral visual pathway. By capitalizing on intracranial depth recordings from 100 patients and 11293 electrodes we assessed the alignment between the DCNN and signals at different frequency bands in different time windows. We found that activity in low and high gamma bands was aligned with the increasing complexity of visual feature representations in the DCNN. These findings show that activity in the gamma band is not only a correlate of object recognition, but carries increasingly complex features along the ventral visual pathway. These results demonstrate the potential that modern artificial intelligence algorithms have in advancing our understanding of the brain. 

## The Pipeline
The overview of the three major steps and the analysis flow.

### DNN Activations
First we feed stimuli though the DNN to extract activations of each layer of DNN.
See [`DNN/RADME.md`](DNN/RADME.md) section "Scripts and running order" for detalils.

### Intractanial Data
Next we transform brain data into suitable structure and extract features.
See [`Intracranial/README.md`](Intracranial/README.md) for details.

### Predict Intracranial form DNN Activations
Finally we use DNN activations to map each intracranial probe to a DNN layer.
See [`Collusion/README.md`](Collusion/README.md) for details.

![Experimental pipeline](experimental_pipeline.png)

## The Data
Our data consists of two big chunks: activations and derivatives from human brain responses and activations and derivatives from DCNN responses. We made most of it publicly available with exception, due to the restrictions imposed by the third party, to the raw LFP responses from the implanted electrodes. But already from the the very next step of analysis -- spectral decomposition of the LFPs -- the data is available:

#### Images
Full set of 419 stimuli presented to the subjects: [images.zip | 3.4 Mb](http://neuro.cs.ut.ee/downloads/intracranial-dcnn/stimuli/images.zip)  

Out of 419 the subset of 250 images from 5 categories were used in the current analysis: [stimsequence.txt | 1.2 Kb](http://neuro.cs.ut.ee/downloads/intracranial-dcnn/stimuli/stimsequence.txt)

#### Human Responses to the Images
Human brain responses to those images from 11,293 electrodes across 100 subjects were recorded, resulting in 2,823,250 LFP recordings: [not available publicly]  

Recordings were preprocessed using detrending, artifact rejection, bipolar rereferencing and dropping non-responposive electrodes: [not available publicly]  
  
###### Average power, MNI and Brodmann area of each probe
LFP responses of remaining responsive electodes are split into 15 regions of interest: 5 bands (θ, α, β, γ, Γ) in 3 time windows (50-250 ms, 150-350 ms, 250-450 ms) and average baseline-normalized power extracted for each probe for each region of interest: [mean_band_responses.zip | 27 Mb](http://neuro.cs.ut.ee/downloads/intracranial-dcnn/mean_band_responses.zip), inside that archive you will find 15 directories -- one per region of interest. Within each directory there are 100 `.mat` files -- one per subject, each of those files has the following structure:
```
s.name           name (anonymized) of the test subject
s.stimseq        filenames of the stimuli images (always the same across all subjects)
s.stimgroup      category of each of the stimuli images (always the same across all subjects)
s.probes.mni     [N x 3] matrix with MNI coordinates of N probes
s.probes.areas   Brodmann area of each of N probes
s.data           [250 x N] baseline-normalized average power of each probe's response to each of the stimuli
```
###### RDM matrices
RDM matrix was computed for each probe's response: [brain_and_dnn_rdms.zip | 1.8 Gb](http://neuro.cs.ut.ee/downloads/intracranial-dcnn/brain_and_dnn_rdms.zip) has 15 directories, inside each you will find `M` files, corresponding to the number of responsive probes in that region of interest + 17 files that hold RDMs of DCNN (both the pre-trained AlexNet and randomly initialized AlexNet, those 17 files are same in all 15 directories). Brain RDM filename format is `brain-SUBJECT-PROBE.txt` and it holds an RDM matrix of size 250 x 250 that describes that probe's representation geometry.

#### DCNN Responses to the Images
The particular DCNN that was used in our research was AlexNet trained on ImageNet. Weights of this network are publicly available: [BVLC Reference CaffeNet](http://dl.caffe.berkeleyvision.org/bvlc_reference_caffenet.caffemodel).

###### Activations
Responses of that network to our set of images: [alexnet-activations.zip | 395 Mb](http://neuro.cs.ut.ee/downloads/intracranial-dcnn/alexnet-activations.zip) has an `.npy` for each layer of the DCNN.

#### Final RSA Scores and Results
Once we had human and machine responses and we computed representation geometry of both and compared those geometries using RSA analysis.

###### Correlation scores for comparing RDMs
Final RSA scores and p-values [rsa_scores_and_pvalues.zip | 2.9 Mb](http://neuro.cs.ut.ee/downloads/intracranial-dcnn/rsa_scores_and_pvalues.zip) show correlation between each pair of (probe, layer) RDMs and their significance level based on the permutation test. Both for pre-trained and random (control) networks.

###### Full-size figures

