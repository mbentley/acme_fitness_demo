#!/bin/bash

set -e

echo "Starting deployment for single cluster..."
kubectl apply -f namespace.yaml
kubectl -n acme-fitness create secret generic cart-redis-pass --from-literal=password="$(echo $RANDOM | md5sum | head -c 12)"
kubectl -n acme-fitness create secret generic catalog-mongo-pass --from-literal=password="$(echo $RANDOM | md5sum | head -c 12)"
kubectl -n acme-fitness create secret generic order-postgres-pass --from-literal=password="$(echo $RANDOM | md5sum | head -c 12)"
kubectl -n acme-fitness create secret generic users-mongo-pass --from-literal=password="$(echo $RANDOM | md5sum | head -c 12)"
kubectl -n acme-fitness create secret generic users-redis-pass --from-literal=password="$(echo $RANDOM | md5sum | head -c 12)"
kubectl -n acme-fitness apply -f cart-redis-total.yaml -f cart-total.yaml -f catalog-db-initdb-configmap.yaml -f catalog-db-total.yaml -f catalog-total.yaml -f payment-total.yaml -f order-db-total.yaml -f order-total.yaml -f users-db-initdb-configmap.yaml -f users-db-total.yaml -f users-redis-total.yaml -f users-total.yaml -f frontend-total.yaml -f point-of-sales-total.yaml -f frontend-ingress.yaml -f point-of-sales-ingress.yaml
echo "Finished deployment for single cluster..."
