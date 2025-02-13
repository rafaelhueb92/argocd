kubectl port-forward svc/argocd-server -n argocd 8080:443
#kubectl port-forward --address 0.0.0.0 svc/argocd-server -n argocd 8080:443

if [[ "$(uname)" == "Darwin" ]]; then
  open -a "Google Chrome" https://localhost:8080/
else
  google-chrome https://localhost:8080/
fi