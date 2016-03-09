IMAGE = bekberov/docker_postgresql_centos7
TAG   = latest

build:
        @docker build  --no-cache -t $(IMAGE) .
#        @docker run -d --name postgresql_centos7 -p 6379:6379 -v /redis/log:/var/redis/log/redis -v /redis/data:/var/lib/redis $(IMAGE)

release:
#       @docker build -t $(IMAGE) .
#       @docker tag $(IMAGE):latest $(IMAGE):$(TAG)
#       @docker push $(IMAGE):latest
#       @docker push $(IMAGE):$(TAG)

.PHONY: build release
