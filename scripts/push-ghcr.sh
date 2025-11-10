set -e -x 
export USERNAME=yokawasa
echo $PAT | docker login ghcr.io -u $USERNAME --password-stdin
docker tag users-api ghcr.io/api-first-book/users-api/users-api:0.0.1
docker tag mysql:5.7 ghcr.io/api-first-book/users-api/mysql:5.7
docker push ghcr.io/api-first-book/users-api/users-api:0.0.1
docker push ghcr.io/api-first-book/users-api/mysql:5.7
