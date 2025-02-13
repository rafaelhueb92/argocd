echo "The Password in base64"
PASSWORD=$(kubectl get secret -n argocd argocd-initial-admin-secret -o yaml | grep -o 'password: .*' | \
sed 's/password: //')

echo $PASSWORD

echo -n "$PASSWORD" | base64 -d > password.txt