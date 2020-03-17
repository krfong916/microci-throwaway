# Authenticate to Docker Hub and pull the latest image
echo "${DOCKER_PASSWORD}" | docker login -u "${DOCKER_USERNAME}" --password-stdin
docker pull "$DOCKER_USERNAME"/microci-throwaway_server:latest
# Deploy image to Heroku
echo "${HEROKU_AUTH_TOKEN}" | docker login --username="$DOCKER_USERNAME" --password-stdin registry.heroku.com
docker tag "$DOCKER_USERNAME"/microci-throwaway_server registry.heroku.com/microci-test/web
docker images
docker push registry.heroku.com/microci-test/web
heroku container:release web