export IMAGE_VERSION="0.0.5"
export IMAGE_TAG="ghcr.io/kbooth-insight/mutlicloud-demo:${IMAGE_VERSION}"

docker build  -t ${IMAGE_TAG} .
docker push ${IMAGE_TAG}