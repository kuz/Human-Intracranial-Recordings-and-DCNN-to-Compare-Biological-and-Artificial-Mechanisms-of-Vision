#!/usr/bin/env python

import sys
import lmdb
import numpy as np
import caffe
import matplotlib.pyplot as plt

if len(sys.argv) != 3:
  print 'Usage:', sys.argv[0], '<lmdb_path>' '<numpy_path>'
  print 'Usage example: python lmdb2numpy.py activations/lmdb/fc7 activations/numpy/fc7'
  sys.exit(2)

lmdb_path = sys.argv[1]
numpy_path = sys.argv[2]

env = lmdb.open(lmdb_path)
env_stat = env.stat()
num_images = env_stat['entries']
print "Number of images: ", num_images

print "Extracting data from LMDB..."
data = None
counter = 0
with env.begin() as txn:
    with txn.cursor() as curs:
        for key, value in curs:
	
            # convert value to numpy array
            datum = caffe.proto.caffe_pb2.Datum()
            datum.ParseFromString(value)
            arr = caffe.io.datum_to_array(datum)

            # lazily initialize matrix, once we know number of features
            if data is None:
                num_features = np.prod(arr.shape)
                print "Number of features: ", num_features
                data = np.empty((num_images, num_features))

            # copy data to matrix
            data[int(key), ] = arr.reshape(num_features)

            # display progress
            sys.stdout.write('{0}/{1}\r'.format(counter, num_images))
            sys.stdout.flush()
            counter += 1

env.close()

print "Storing reconstructed images..."
np.save(numpy_path + '/activations.npy', data)
