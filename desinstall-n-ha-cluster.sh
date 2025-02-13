kubectl delete -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl delete ns argocd
clear

bash ./helpers/colored-message.sh "BrightMagenta" "ARGO CD Uninstalled"

