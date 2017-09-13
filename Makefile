build: Dockerfile
	docker build -t devbox:latest .
clean:
	docker image prune
dev:
	docker run -i -t --rm devbox
