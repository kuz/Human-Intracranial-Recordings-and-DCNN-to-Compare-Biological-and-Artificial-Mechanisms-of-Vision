The Pipeline
============

### DNN Activations
First we feed stimuli though the DNN to extract activations of each layer of DNN.
See [`DNN/RADME.md`](DNN/RADME.md) section "Scripts and running order" for detalils.

### Intractanial Data
Next we transform brain data into suitable structure and extract features.
See [`Intracranial/README.md`](Intracranial/README.md) for details.

### Predict Intracranial form DNN Activations
Finally we use DNN activations to map each intracranial probe to a DNN layer.
See [`Collusion/README.md`](Collusion/README.md) for deatais.