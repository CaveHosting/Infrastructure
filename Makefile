reset:
	k3d cluster delete CaveHosting
	k3d cluster create --config k3d/dev-env.yaml

setup:
	kubectl apply -f ../_secrets/master-key.yaml
	helm install argocd argo/argo-cd --namespace argocd --create-namespace

prod:
	git clone https://github.com/CaveHosting/Infrastructure.git
	helm upgrade --install argocd-root Infrastructure/root-app/ --namespace argocd --create-namespace --wait

dev:
	helm upgrade --install argocd-root root-app/ --namespace argocd --create-namespace --wait -f root-app/values-dev.yaml

encrypt:
	kubeseal --format=yaml < ../_secrets/$(chart).yaml > charts/$(chart)/templates/secret.yaml --controller-name sealed-secrets
