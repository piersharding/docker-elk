#!/bin/sh

# must have Elasticsearch index directory in ./data
mkdir -p data
sudo docker run --rm  -v /data --volumes-from elasticdata -v $(pwd)/data:/backup  -i trusty bash
