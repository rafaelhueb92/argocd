kubectl delete pod -n argocd -l app.kubernetes.io/name=argocd-server
kubectl delete pod -n argocd -l app.kubernetes.io/name=argocd-repo-server
kubectl delete secret argocd-notifications-secret -n argocd
clear
echo "ARGO CD Restarted"
