# Homepage
k3s yaml files for deploying colinbruner.com homepage on a raspberry pi cluster. 

## Deployment
To future me, who may or may not need this file.

1. Decrypt secrets.yaml.gpg - this is encrypted with your personal GPG key.
2. Create the homepage namespace.
3. Create the secret for pulling private docker repos.
4. Create the service endpoint for all nodes.
5. Create the deployment of the containers.

```bash
gpg -o secret.yaml -d secret.yaml.gpg
kubectl apply -f homepage.json
kubectl apply -f secret.yaml
kubectl apply -f service.yaml
kubectl apply -f deploy.yaml
```

## Post
Switch context to homepage and view creating pods and service

``` bash
kubectl config set-context --current --namespace=homepage
kubectl get pod
kubectl get svc
```
