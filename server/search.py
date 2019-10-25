# USAGE
# python search.py --tree vptree.pickle --hashes hashes.pickle --query queries/accordion.jpg

# import the necessary packages
from pyimagesearch.hashing import convert_hash
from pyimagesearch.hashing import dhash
import argparse
import pickle
import time
import cv2


# load the VP-Tree and hashes dictionary
print("[INFO] loading VP-Tree and hashes...")
tree = pickle.loads(open("vptree.pickle", "rb").read())
hashes = pickle.loads(open("hashes.pickle", "rb").read())


def photo(path):
# load the input query image
	image = cv2.imread(path)
	# compute the hash for the query image, then convert it
	queryHash = dhash(image)
	queryHash = convert_hash(queryHash)

	# perform the search
	print("[INFO] performing search...")
	start = time.time()
	results = tree.get_all_in_range(queryHash,10)
	results = sorted(results)
	end = time.time()
	print("[INFO] search took {} seconds".format(end - start))

	# loop over the results
	for (d, h) in results:
		# grab all image paths in our dataset with the same hash
		resultPaths = hashes.get(h, [])
		print("[INFO] {} total image(s) with d: {}, h: {}".format(
			len(resultPaths), d, h))
		# loop over the result paths
		if(resultPaths[0][str(resultPaths[0]).index("/")+1:str(resultPaths[0]).index(".")])=="wolfdog":
			return 2
		else:
			return 1
	return -1
		
		
