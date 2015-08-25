#!/bin/bash

for file in ../../Data/imagesorig/*
do
	file=$(basename $file)
	convert ../../Data/imagesorig/$file -resize 227x227\! ../../Data/imagesdone/$file
done
