docker images
# Deploy image to Heroku
echo "${HEROKU_AUTH_TOKEN}" | docker login --username="$DOCKER_USERNAME" --password-stdin registry.heroku.com
docker tag "$DOCKER_USERNAME"/microci-throwaway_server registry.heroku.com/microci-test/web
docker push registry.heroku.com/microci-test/web
# docker images
# echo "test container release"
# heroku container:login
# heroku container:push web
# heroku container:release web