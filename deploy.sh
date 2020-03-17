echo "${DOCKER_PASSWORD}" | docker login -u "${DOCKER_USERNAME}" --password-stdin
docker pull "$DOCKER_USERNAME"/microci-throwaway_server:latest
echo "${HEROKU_API_KEY}" | docker login --username=krfong@ucsc.edu --password-stdin registry.heroku.com
docker tag "$DOCKER_USERNAME"/microci-throwaway_server registry.heroku.com/microci-test/web
docker push registry.heroku.com/microci-test/web        
heroku container:release web