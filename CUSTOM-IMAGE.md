# Custom Container Images

カスタムコンテナイメージでテストする場合は次の手順でイメージを作成ならびにYAML設定をしてください。

## Build & load Container Images

Build container images and load them to the KIND cluster

```bash
cd app
docker build . -t users-api

cd ../mysql
docker build . -t mysql:5.7 --platform linux/x86_64

# load images to the KIND cluster
kind load docker-image users-api --name kind
kind load docker-image mysql:5.7 --name kind
```

## Push container Images to GHCR

```bash
echo $PAT | docker login ghcr.io -u yokawasa --password-stdin
docker tag users-api ghcr.io/api-first-book/users-api/users-api:0.0.1
docker tag mysql:5.7 ghcr.io/api-first-book/users-api/mysql:5.7
docker push ghcr.io/api-first-book/users-api/users-api:0.0.1
docker push ghcr.io/api-first-book/users-api/mysql:5.7
```

## Update container image in k8s manifests

Finally, update the container image property value in app-deployment.yml and mysql-deployment.yml with the new one:

> kubernetes/app-deployment.yml
```yaml
# image: ghcr.io/api-first-book/users-api/users-api:latest
image: users-api
```

> kubernetes/mysql-deployment.yml
```yaml
# image: ghcr.io/api-first-book/users-api/mysql:5.7
image: mysql:5.7
```

