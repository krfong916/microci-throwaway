# Authenticate to Docker Hub and pull the latest image
echo "${DOCKER_PASSWORD}" | docker login -u "${DOCKER_USERNAME}" --password-stdin
echo "pulling from docker hub"
docker pull "$DOCKER_USERNAME"/microci-throwaway_server:latest
# Deploy image to Heroku
heroku container:login
docker tag microci-throwaway_server registry.heroku.com/microci-test/web
docker push registry.heroku.com/microci-test/web
echo "test container release"
heroku container:push web
heroku container:release web