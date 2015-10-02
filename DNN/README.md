Extract DNN Activations
=======================

This is collection of scripts needed to feed set of images into a networks and extract network activations.  
Ideally this should be run only once to extract all the activations. If `activations` folder is populated you have on need to rerun it unless you want to extract activations again.

Directory structure
-------------------

```
activations
  lmdb           # extracted cativations for each layer in lmdb format
    conv1
      data.mdb
      lock.mdb
    ...
  numpy           # extracted cativations for each layer in lmdb format
    conv1
      activations.npy
input_lmdb        # input images in lmdb format
model             # DNN model descriptions and binary file
< scripts >
```

Scripts and running order
-------------------------

1. `resize_images.sh` will take images from ../../Data/imagesorig and resize them to 227x227  
2. `make_input_lmdb.sh` produces lmdb form the images and stores it into `input_lmdb` directory
3. `extract_activations.sh` will push all images though the model and store activations in ;mdb and numpy formats under the `activations` directory

`lmdb2numpy.py` is a helper script used by `extract_activations.sh`
  