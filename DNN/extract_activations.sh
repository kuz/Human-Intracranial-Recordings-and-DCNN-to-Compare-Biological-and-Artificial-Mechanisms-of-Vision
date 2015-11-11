#!/bin/bash

CAFFEHOME=$HOME"/Software/Caffe"
LMDB="lmdb.empty"
NUMPY="numpy.empty"
MODEL="model/bvlc_empty_caffenet.caffemodel"

echo "Removing previously extracted activations ..."
rm -rf activations/$LMDB/*
rm -rf activations/$NUMPY/*

layers=("conv1" "conv2" "conv3" "conv4" "conv5" "fc6" "fc7" "fc8")
#layers=("fc8")

for layer in ${layers[@]}
do

	# extract activations into lmdb
	echo " "
	echo "Extracting activations from layer $layer ..."
	echo "--------------------------------------------"
	$CAFFEHOME/build/tools/extract_features.bin $MODEL model/extractor.prototxt $layer activations/$LMDB/$layer 419 lmdb GPU 0

	# convert lmdb into numpy
	mkdir activations/$NUMPY/$layer
	python lmdb2numpy.py activations/$LMDB/$layer

done

echo "Done."
