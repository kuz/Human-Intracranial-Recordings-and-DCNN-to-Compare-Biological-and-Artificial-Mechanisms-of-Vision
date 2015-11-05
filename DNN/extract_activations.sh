#!/bin/bash

CAFFEHOME=$HOME"/Software/Caffe"

echo "Removing previously extracted activations ..."
rm -rf activations/lmdb/*
rm -rf activations/numpy/*

layers=("conv1" "conv2" "conv3" "conv4" "conv5" "fc6" "fc7" "fc8")
#layers=("fc8")

for layer in ${layers[@]}
do

	# extract activations into lmdb
	echo " "
	echo "Extracting activations from layer $layer ..."
	echo "--------------------------------------------"
	$CAFFEHOME/build/tools/extract_features.bin model/bvlc_empty_caffenet.caffemodel model/extractor.prototxt \
											$layer activations/lmdb/$layer 419 lmdb GPU 0

	# convert lmdb into numpy
	mkdir activations/numpy/$layer
	python lmdb2numpy.py activations/lmdb/$layer

done

echo "Done."
