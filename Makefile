GIT_SHA := $(shell git rev-parse --short HEAD)

NAME =  xamaral/echo

docker:
	docker build . --target prod -t $(NAME):$(GIT_SHA) -t $(NAME):latest

push: docker
	docker push $(NAME):$(GIT_SHA)
	docker push $(NAME):latest

docker-dev:
	docker build . --target dev -t $(NAME)-dev:latest

tele:
	telepresence --swap-deployment echo \
	--docker-run --rm -it -v $(shell pwd)/app:/usr/src/app --env-file secrets.env $(NAME)-dev:latest

.PHONY: docker push docker-dev tele
