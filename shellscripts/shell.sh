echo "Waiting for ArgoCD server deployment..."
kubectl rollout status deployment/argocd-server -n argocd --timeout=10m

echo "Changing argocd-server Service to LoadBalancer..."
kubectl patch svc argocd-server -n argocd \
  -p '{"spec":{"type":"LoadBalancer"}}'

echo "Waiting for LoadBalancer hostname..."
kubectl wait --for=jsonpath='{.status.loadBalancer.ingress[0]}' \
  service/argocd-server \
  -n argocd \
  --timeout=10m

echo ""
echo "ArgoCD URL:"
kubectl get svc argocd-server -n argocd

echo ""
echo "ArgoCD Username:"
echo "admin"

echo ""
echo "ArgoCD Password:"
kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 --decode
echo
