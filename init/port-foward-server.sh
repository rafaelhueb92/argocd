bash ./helpers/colored-message.sh "Cyan" "Init Server UI Argo CD!"

if [ "$(kubectl config current-context)" = "minikube" ]; then
    bash ./helpers/colored-message.sh "Yellow" "Init with Minikube!"
    minikube service argocd-server -n argocd --url
else
    kubectl port-forward svc/argocd-server -n argocd 8080:443
fi
