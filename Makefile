
NAME=phpmyadmin
VERSION=4.8.2

build:
	docker build -t ${NAME} .

shell: build
	docker run -it --rm ${NAME} sh

test: build
	docker run --net backend  --env-file .testenv --rm -it -P ${NAME}

daemon: build
	docker run -d --name ${NAME} ${NAME}

release:
	git commit -av -e -m "Upgrade to phpMyAdmin ${VERSION}" && \
	git tag -f ${VERSION} && \
	git push && \
	git push --tags -f
