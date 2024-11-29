NAMESPACE?=lastdanmer

.PHONY:build
build:
	docker build --tag $(NAMESPACE)/kubectl-helm .

.PHONY:push
push:
	docker push $(NAMESPACE)/kubectl-helm
