# main configurations for docker scripts
# make appropriate changes before running the scripts
IMAGE=azmfaridee/nano-dl
CONTAINER=nano-dl-container
LOCAL_JUPYTER_PORT=8888
LOCAL_TENSORBOARD_PORT=6006
# end of config

docker-resume:
	nvidia-docker start -ai $(CONTAINER)

docker-run:
	nvidia-docker run -it -p $(LOCAL_JUPYTER_PORT):8888 -p $(LOCAL_TENSORBOARD_PORT):6006 -v $(shell pwd):/notebooks --name $(CONTAINER) $(IMAGE)

docker-shell:
	nvidia-docker exec -it $(CONTAINER) bash

docker-tensorboard:
	nvidia-docker exec -it $(CONTAINER) tensorboard --logdir=logs

docker-clean:
	docker rm $(CONTAINER)

docker-purge:
	docker rmi $(IMAGE)

docker-build:
	docker build -t $(IMAGE) .

docker-build-arm64:
	docker buildx build --platform linux/arm64 --push -t $(IMAGE) .

docker-push:
	docker push $(IMAGE)
        
docker-pull:
	docker pull $(IMAGE)
