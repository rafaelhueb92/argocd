install_argo_cd_cli() {
    bash ./helpers/colored-message.sh "Green" "Installing argocd cli."
    brew install argocd 

    bash ./init/login-cli.sh

}

if [ "$(kubectl config current-context)" = "minikube" ]; then
    status=$(minikube status | grep -i "host:")

    if [[ "$status" == *"Running"* ]]; then
        bash ./helpers/colored-message.sh "Green" "Minikube is already started."
    else
        bash ./helpers/colored-message.sh "Blue" "Minikube is not running. Starting Minikube..."
        minikube start
    fi
fi

if [ "$(kubectl get ns -l kubernetes.io/metadata.name=argocd --no-headers | wc -l)" -ne 1 ]; then
    bash ./helpers/colored-message.sh "Blue" "Creating argocd namespace..."
    kubectl create ns argocd
else
    if [ "$(kubectl get pods -n argocd | wc -l)" -gt 0 ]; then
        bash ./helpers/colored-message.sh "BrightMagenta" "Argo CD already Installed"
        exit 0
    fi
fi

ARGO_CD_URL_MANIFEST=""

if [ $1 == "Non-HA" ]; then
    bash ./helpers/colored-message.sh "Cyan" "Installing as Non-HA"
    if [ $2 == "cluster-admin" ]; then
        bash ./helpers/colored-message.sh "Green" "Installing as a clust-admin"
        ARGO_CD_URL_MANIFEST="https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml"
    elif [ $2 == "namespace" ]; then 
        bash ./helpers/colored-message.sh "Green" "Installing as a namespace level privileges"
        ARGO_CD_URL_MANIFEST="https://github.com/argoproj/argo-cd/raw/stable/manifests/namespace-install.yaml"
    fi
elif [ $1 == "HA"]; then
    bash ./helpers/colored-message.sh "Cyan" "Installing as HA"
    if [ $2 == "cluster-admin" ]; then
        bash ./helpers/colored-message.sh "Green" "Installing as a clust-admin"
        ARGO_CD_URL_MANIFEST="https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/ha/install.yaml"
    elif [ $2 == "namespace" ]; then 
        bash ./helpers/colored-message.sh "Green" "Installing as a namespace level privileges"
        ARGO_CD_URL_MANIFEST="https://github.com/argoproj/argo-cd/raw/stable/manifests/ha/namespace-install.yaml"
    fi
elif [ $1 == "core"]; then
    bash ./helpers/colored-message.sh "Green" "Installing as core"
    kubectl apply -f https://github.com/argoproj/argo-cd/raw/stable/manifests/core-install.yaml

    install_argo_cd_cli

    exit 0
elif [ $1 == "Helm"]; then
    bash ./helpers/colored-message.sh "Green" "Installing with Helm chart"
    helm repo add argo https://argoproj.github.io/argo-helm
    helm install my-release argo/argo-cd

    install_argo_cd_cli

    exit 0
else 
    bash ./helpers/colored-message.sh "Red" "ERROR! Invalid Option!"
    exit 1
fi

bash ./helpers/colored-message.sh "Blue" "Applying Manifest"
 
kubectl apply -n argocd -f "$ARGO_CD_URL_MANIFEST"

install_argo_cd_cli