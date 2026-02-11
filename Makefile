reset:
	k3d cluster delete CaveHosting
	k3d cluster create --config k3d/dev-env.yaml

setup:
	kubectl create namespace argocd
	helm install argocd argo/argo-cd --namespace argocd

prod:
	kubectl apply -f root-apps/root-prod.yaml
