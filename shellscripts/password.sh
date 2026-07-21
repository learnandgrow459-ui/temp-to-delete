#!/bin/bash

echo "ArgoCD Username:"
echo "admin"

echo "ArgoCD Password:"
kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 --decode
echo