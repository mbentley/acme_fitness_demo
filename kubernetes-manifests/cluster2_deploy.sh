#!/bin/bash

set -e

# cluster 2
echo "Starting deploy for cluster 2..."
kubectl apply -f namespace.yaml
kubectl -n acme-fitness create secret generic catalog-mongo-pass --from-literal=password="$(echo $RANDOM | md5sum | head -c 12)"
kubectl -n acme-fitness create -f catalog-db-initdb-configmap.yaml
kubectl -n acme-fitness apply -f catalog-db-total.yaml
kubectl -n acme-fitness apply -f catalog-total.yaml
echo "Deployment complete for cluster 2..."
