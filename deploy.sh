# Login to Docker Hub and pull image
echo "${DOCKER_PASSWORD}" | docker login -u "${DOCKER_USERNAME}" --password-stdin
docker pull "$DOCKER_USERNAME"/microci-throwaway_server:latest

# Login to Heroku registry directly from Docker CLI and push the image
echo "${HEROKU_API_KEY}" | docker login --username=_ --password-stdin registry.heroku.com
docker tag "$DOCKER_USERNAME"/microci-throwaway_server registry.heroku.com/microci-test/web
docker images
docker push registry.heroku.com/microci-test/web        
heroku container:release web