Frequency-Resolved Correlates of Visual Object Recognition in Human Brain Revealed by Deep Convolutional Neural Networks
========================================================================================================================
Research article by [http://www.ikuz.eu](Ilya Kuzovkin), [http://neuro.cs.ut.ee/people](Raul Vicente), Mathilde Petton, Jean-Philippe Lachaux, Monica Baciu, Philippe Kahane, Sylvain Rheims, Juan R. Vidal and [http://neuro.cs.ut.ee/people](Jaan Aru). 

## Abstract
Previous works have demonstrated a direct correspondence between the hierarchy of the human visual areas and layers of deep convolutional neural networks (DCNN) trained on visual object recognition. We used DCNNs to investigate which frequency bands carry feature transformations of increasing complexity along the ventral visual pathway. By capitalizing on direct intracranial recordings from $81$ patients and $9147$ electrodes we assessed the alignment between the DCNN and signals at different frequency bands in different time windows. We found that activity in low and high gamma bands was aligned with the increasing complexity of visual feature representations in the DCNN. These findings show that activity in the gamma band is not only a correlate of object recognition, but carries increasingly complex features along the ventral visual pathway. Similar alignment was found in the alpha frequency highlighting an unexpected role for alpha in contributing to visual object recognition. These results demonstrate the potential that modern artificial intelligence algorithms have in advancing our understanding of the brain.

## The Pipeline
![Experimental pipeline](experimental_pipeline.png)

### DNN Activations
First we feed stimuli though the DNN to extract activations of each layer of DNN.
See [`DNN/RADME.md`](DNN/RADME.md) section "Scripts and running order" for detalils.

### Intractanial Data
Next we transform brain data into suitable structure and extract features.
See [`Intracranial/README.md`](Intracranial/README.md) for details.

### Predict Intracranial form DNN Activations
Finally we use DNN activations to map each intracranial probe to a DNN layer.
See [`Collusion/README.md`](Collusion/README.md) for deatais.
