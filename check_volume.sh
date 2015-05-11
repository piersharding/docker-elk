#!/bin/sh

# must have Elasticsearch index directory in ./elasticsearch/data
sudo docker run --rm  -v /data --volumes-from elasticdata -v $(pwd)/elasticsearch/data:/backup  -i trusty bash
