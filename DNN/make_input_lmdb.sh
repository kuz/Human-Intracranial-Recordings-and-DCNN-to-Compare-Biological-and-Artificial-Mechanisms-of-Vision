#!/usr/bin/env sh

#
# Create the lmdb inputs from the images
#

IMAGES="../../Data/imagesdone/"
OUTPUTDIR="input_lmdb"
TOOLS=$HOME/Software/Caffe/build/tools

echo "Removing old lmdb files..."
rm -rf $OUTPUTDIR

echo "Creating lmdb..."
GLOG_logtostderr=1 $TOOLS/convert_imageset $IMAGES ../../Data/imagesdone.txt $OUTPUTDIR

echo "Done."
