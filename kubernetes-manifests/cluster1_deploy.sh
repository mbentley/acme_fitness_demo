#!/bin/bash

set -e

# cluster 1
echo "Starting deploy for cluster 1..."
kubectl apply -f namespace.yaml
kubectl -n acme-fitness create secret generic cart-redis-pass --from-literal=password="$(echo $RANDOM | md5sum | head -c 12)"
kubectl -n acme-fitness apply -f cart-redis-total.yaml
kubectl -n acme-fitness apply -f cart-total.yaml
kubectl -n acme-fitness apply -f payment-total.yaml
kubectl -n acme-fitness create secret generic order-postgres-pass --from-literal=password="$(echo $RANDOM | md5sum | head -c 12)"
kubectl -n acme-fitness apply -f order-db-total.yaml
kubectl -n acme-fitness apply -f order-total.yaml
kubectl -n acme-fitness create secret generic users-mongo-pass --from-literal=password="$(echo $RANDOM | md5sum | head -c 12)"
kubectl -n acme-fitness create secret generic users-redis-pass --from-literal=password="$(echo $RANDOM | md5sum | head -c 12)"
kubectl -n acme-fitness create -f users-db-initdb-configmap.yaml
kubectl -n acme-fitness apply -f users-db-total.yaml
kubectl -n acme-fitness apply -f users-redis-total.yaml
kubectl -n acme-fitness apply -f users-total.yaml
kubectl -n acme-fitness apply -f frontend-total.yaml
kubectl -n acme-fitness apply -f point-of-sales-total.yaml
kubectl -n acme-fitness apply -f loadgen.yaml
echo "Deployment complete for cluster 1..."
