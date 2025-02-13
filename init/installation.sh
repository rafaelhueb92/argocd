minikube start
kubectl create ns argocd

ARGO_CD_URL_MANIFEST=""

if [ $1 == "Non-HA" ]; then
    echo "Non-HA procedure"
    if [ $2 == "cluster-admin" ]; then
        echo "Installing as a clust-admin"
        ARGO_CD_URL_MANIFEST="https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml"
    elif [ $2 == "namespace" ]; then 
        echo "Installing as a namespace level privileges"
        ARGO_CD_URL_MANIFEST="https://github.com/argoproj/argo-cd/raw/stable/manifests/namespace-install.yaml"
    fi
elif [ $1 == "HA"]; then
    echo "HA procedure"
    if [ $2 == "cluster-admin" ]; then
        echo "Installing as a clust-admin"
        ARGO_CD_URL_MANIFEST="https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/ha/install.yaml"
    elif [ $2 == "namespace" ]; then 
        echo "Installing as a namespace level privileges"
        ARGO_CD_URL_MANIFEST="https://github.com/argoproj/argo-cd/raw/stable/manifests/ha/namespace-install.yaml"
    fi
elif [ $1 == "core"]; then
    kubectl apply -f https://github.com/argoproj/argo-cd/raw/stable/manifests/core-install.yaml
elif [ $1 == "Helm"]; then
    echo "Installing with Helm chart"
    helm repo add argo https://argoproj.github.io/argo-helm
    helm install my-release argo/argo-cd
    exit 0
else 
    echo "ERROR! Invalid Option!"
    exit 1
fi

echo "Applying Manifest"
kubectl apply -n argocd -f "$ARGO_CD_URL_MANIFEST"

kubectl get pods -n argocd
