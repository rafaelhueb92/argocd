bash ./helpers/colored-message.sh "Yellow" "Login into the CLI!"

bash ./init/get-initial-pwd.sh

PASSWORD="$(cat init/password.txt)"

PORT=0

if [ "$(kubectl config current-context)" = "minikube" ]; then
        PORT=59787
else
        PORT=8080
fi

bash ./helpers/colored-message.sh "Cyan" "Configuring ARGO CD CLI at localhost:$PORT"

sudo chown -R $(whoami) u+rwx ~/.config

argocd login localhost:$PORT --username admin --password $PASSWORD --insecure