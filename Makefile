reset:
	k3d cluster delete CaveHosting
	k3d cluster create --config k3d/dev-env.yaml

setup:
	helm install argocd argo/argo-cd --namespace argocd --create-namespace

prod:
	helm upgrade --install argocd-root root-app/ --namespace argocd --create-namespace --wait

dev:
	helm upgrade --install argocd-root root-app/ --namespace argocd --create-namespace --wait -f root-app/values-dev.yaml
