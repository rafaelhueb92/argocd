PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d)

echo -n "$PASSWORD" > ./init/password.txt

bash ./helpers/colored-message.sh "Blue" "The Password is created in init/password.txt"